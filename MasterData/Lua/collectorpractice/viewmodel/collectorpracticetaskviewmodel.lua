



local equipIconPath = "Assets/_BundleResources/Images/ItemIcons/itemicon_"
local this = { vm = nil }
local type
local typeid
local posGropData = {
    { Vector3(-61.2, -11.3, 0) },
    { Vector3(-107.3, -14, 0), Vector3(-6.7, -14, 0) },
    { Vector3(-105.5, 12.9, 0), Vector3(-6.7, 12.9, 0), Vector3(-57.4, -58.9, 0) },
    { Vector3(-131.9, 15, 0), Vector3(-35.3, 15, 0), Vector3(-84.8, -56.8, 0), Vector3(12.1, -56.8, 0) },
    { Vector3(-139.1, 17, 0), Vector3(-55.5, 16.1, 0), Vector3(26.4, 16.1, 0), Vector3(-99.5, -50.7, 0), Vector3(-12.8, -50.7, 0),},
    { Vector3(-147.7, 11.4, 0), Vector3(-76.7, 9.6, 0), Vector3(-6.5, 11.3, 0), Vector3(-112.2, -46.9, 0), Vector3(-40.4, -47.7, 0), Vector3(27.3, -45.1, 0),},
    { Vector3(-123.4, -22.3, 0), Vector3(-91, 31.8, 0), Vector3(-28.9, 31.1, 0), Vector3(3.3, -21.1, 0), Vector3(-27, -73.8, 0), Vector3(-90, -72.6, 0), Vector3(-59.5, -22.438, 0),},
    { Vector3(-152.5, 9.8, 0), Vector3(-96.1, 9.7, 0), Vector3(-41.3, 10.7, 0), Vector3(13.3, 9.94, 0), Vector3(-123.9, -37.3, 0), Vector3(-67.1, -36.5, 0), Vector3(-13.7, -37.3, 0), Vector3(41.2, -38.7, 0),},
    { Vector3(-84.6, 28.7, 0), Vector3(-30.4, 29.8, 0), Vector3(-111.7, -17.7, 0), Vector3(-58, -16.8, 0), Vector3(-2.2, -16.8, 0), Vector3(-139.6, -65.1, 0), Vector3(-84.6, -65.1, 0), Vector3(-28.6, -66, 0), Vector3(25.1, -66, 0),},
    { Vector3(-114.2, 24.3, 0), Vector3(-56.9, 24.3, 0), Vector3(1.1, 24.3, 0), Vector3(-143.6, -24.5, 0), Vector3(-86.4, -23.6, 0), Vector3(-28.9, -23, 0), Vector3(28.5, -24, 0), Vector3(-114.8, -71.9, 0), Vector3(-57.8, -71.9, 0), Vector3(0, -71.9, 0),},
}
local scaleData = { 1, 1, 1, 1, 0.92, 0.78, 0.7, 0.62, 0.6, 0.7 }
local data = {
    count = "0",
    equipIcon = DefaultTexture,
    equipRare = DefaultSprite,
    itemcount = "",
    practiceCardItem = {
        {
            id = "",
            name = "",
            rewardIcon = DefaultTexture,
            rewardRare = DefaultSprite,
            rewardcount = "",
            canGet = false,
            alreadyget = false,
            openGroup = true,
            numCard1 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard2 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard3 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard4 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard5 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard6 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard7 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard8 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard9 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard10 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
        }

    },
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.Back()
        end
    }, ClickGoodItemClick = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local event = this.vm.data.practiceCardItem[param + 1]
            if event.canGet then

                this.SendCompletedEvent(event)
            else
                return
            end
        end
    },
    ClickcloseBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.Back()
        end
    },
    ClickRewardItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local id = this.vm.data.practiceCardItem[param + 1].rewardId
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, id, false, false,
            false)
        end
    }
}


local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then

            typeid = vm.behaviour.Params[1]
            type = vm.behaviour.Params[0]
            this.MissionView(type, typeid)
            LuaMgr.HidePanel(UIName.CollectorPracticeAchieveViewModel)

        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then

        end
    end
}


this.MissionView = function(id, type)
    local tempList = {}
    for key, value in pairs(DataMgr.Player.missions[type][id]) do
        local eventConfig = ConfigMgr.Config.missionMap[value.id]
        local tempMission = {
            eventId = value.id,
            canGet = value.current >= value.target and not value.completed,
            eventText = LuaMgr.GetLangText(eventConfig.NameLan),
            current = value.current,
            target = value.target,
            eventCount = value.current .. "<size=20><color=#262429>/" .. value.target .. "</color></size>",
            pointCount = eventConfig.rewards[1].count,
            pointIcon = eventConfig.rewards[1].itemId,
            targetCount = value.target,
            status = value.completed,
        }
        table.insert(tempList, tempMission)
    end
    table.sort(tempList, function(a, b)
        if a.status == b.status then
            return (a.current / a.target) > (b.current / b.target)
        else
            return not a.status and b.status
        end
    end)
    local realNeedtemplist = {}
    for i, value in ipairs(tempList) do
        local taskItem = {
            id = value.eventId,
            name = value.eventText,
            canGet = value.current >= value.target and not value.status,
            alreadyget = value.status,
            rewardId = value.pointIcon,
            openGroup = not value.status,
            rewardIcon = LuaMgr.GetTexture(equipIconPath .. value.pointIcon .. ".png"),
            rewardRare = LuaMgr.GetSprite("ItemRare", "itemRare" .. ConfigHelper.GetItemById(value.pointIcon).rare),
            rewardcount = tostring(value.pointCount),
            numCard1 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
            numCard2 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
            numCard3 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
            numCard4 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
            numCard5 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
            numCard6 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
            numCard7 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
            numCard8 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
            numCard9 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
            numCard10 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
        }
        local target = type == "weekly" and value.target or value.target / 10
        local current = type == "weekly" and value.current or value.current / 10
        local posGrop = posGropData[target]

        for index = 1, target, 1 do
            local carditem = "numCard" .. index

            taskItem[carditem].unget = true
            taskItem[carditem].get = current >= index
            taskItem[carditem].scale = Vector3(scaleData[target], scaleData[target], scaleData[target])
            taskItem[carditem].pos = posGrop[index]
            taskItem[carditem].active = true
        end
        table.insert(realNeedtemplist, taskItem)
    end
    this.vm.data.practiceCardItem = realNeedtemplist
end


this.SendCompletedEvent = function(event)
    local data = {}
    data.Tab = type
    data.MissionID = event.id
    ApiMgr.Request("complete_mission", data, true, function(result)
        local re = json.decode(result)
        local resultData = json.encode(re.result)
        LuaMgr.ShowItemRewared(resultData, function()
            this.MissionView(type, typeid)
        end)
    end, nil, true)
end

return vm({
    data = data,
    command = command,
    hook = hook
})