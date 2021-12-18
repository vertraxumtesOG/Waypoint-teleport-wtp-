-- by vertraxumtes
-- Scripting 1
RegisterCommand('tpw', function(source, args, raw)
    local playerPed = PlayerPedId() -- GetPlayerPed(-1)
    local waypoint = GetFirstBlipInfoId(8)
    local waypointCoords = GetBlipInfoIdCoord(waypoint)

    SetEntityCoords(playerPed, waypointCoords.x, waypointCoords.y, waypointCoords.z+35)

end)


-- Scripting 2
Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10000)
        print('do')
        TriggerEvent('skinchanger:getSkin', function(skinData)
            if skinData ~= nil then
                if skinData['beard_2'] > -1 and skinData['beard_2'] < 10 then
                    skinData['beard_2'] = skinData['beard_2'] + 1
                    TriggerEvent('skinchanger:loadSkin', skinData)
                    TriggerServerEvent('esx_skin:save', skinData)
                end
            end
        end)
    end
end)

-- Scripting 3
Citizen.CreateThread(function()
    while true do

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = Vdist(playerCoords, Config.Destination.x, Config.Destination.y, Config.Destination.z)

        if IsControlJustReleased(0, 38) then
            if distance < 3.0 then
                ShowNotification('yes')
            else
                ShowNotification('no')
            end
        end

        Citizen.Wait(1)

    end
end)

function ShowNotification(text)
	SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
	DrawNotification(false, true)
end


-- Scripting 4
_menuPool = NativeUI.CreatePool()
local mainMenu

Citizen.CreateThread(function()
    while true do

        _menuPool:ProcessMenus()

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = Vdist(playerCoords, Config.Destination.x, Config.Destination.y, Config.Destination.z)

        if IsControlJustReleased(0, 38) then
            if distance < 3.0 then
                openMenu()
                ShowNotification('yes')
            else
                ShowNotification('no')
            end
        end

        Citizen.Wait(1)

    end
end)

function openMenu()
    mainMenu = NativeUI.CreateMenu('Titel', 'Description')
    _menuPool:Add(mainMenu)

    local testItem = NativeUI.CreateItem('Name', 'Desc')
    mainMenu:AddItem(testItem)

    mainMenu.OnItemSelect = function(sender, item, index)
        if item == testItem then
            ShowNotification('pressed')
        end
    end

    testItem.Activated = function(sender, index)
        ShowNotification('pressed')
    end

    mainMenu:Visible(true)

    _menuPool:MouseEdgeEnabled(false)
end

function ShowNotification(text)
	SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
	DrawNotification(false, true)
end

-- Scripting 4

-- /broadcast
RegisterCommand('broadcast', function(source, args, raw)
    local finalString = ''
    for i=1, #args, 1 do 
        finalString = finalString .. ' ' .. args[i]
    end

    TriggerServerEvent('bc:get', finalString)
end, false)

RegisterNetEvent('bc:send')
AddEventHandler('bc:send', function(finalString)

    ShowNotification(finalString)

end)

function ShowNotification(text)
	SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
	DrawNotification(false, true)
end

-- by vertraxumtes
