




local typePath = "Assets/_BundleResources/Images/CollectorAchieve/"
local this = { vm = nil }
local closeFunction
local collectotmission = {

    { type = "weekly", typeid = "603" },
    { type = "internachievement", typeid = "701" },
    { type = "internachievement", typeid = "702" },

}
local data = {
    distance = 0,
    practiceAchieveItemList = {
        {
            id = "",
            achieve = false,
            showdata = {},
            icon = DefaultTexture,

        }

    },
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if closeFunction ~= nil then
                closeFunction()
            end
            LuaMgr.HidePanel(UIName.CollectorPracticeAchieveViewModel)


        end
    },
    clickIndexItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local data = this.vm.data.practiceAchieveItemList[param + 1].id
            local type = this.vm.data.practiceAchieveItemList[param + 1].type
            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeTaskViewModel, data, type)


        end
    },
}



local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            this.initAchieveList()
            closeFunction = vm.behaviour.Params[0]
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then

        end
    end
}

this.initAchieveList = function()
    local templist = {}
    collectotmission = CollectorPracticeMgr.MissionConfigData
    for _index, _value in ipairs(collectotmission) do
        local data = DataMgr.Player.missions[_value.type][_value.typeid]

        if data ~= nil then
            local IconPath = _value.type == "weekly" and typePath .. "achievementTypeWeekly.png" or typePath .. _value.typeid .. ".png"
            local achieve = {
                id = _value.typeid,
                type = _value.type,
                achieve = this.checkAchievement(data),
                icon = LuaMgr.GetTexture(IconPath)
            }
            table.insert(templist, achieve)
        end

    end
    this.vm.data.practiceAchieveItemList = templist
end

this.checkAchievement = function(tab)
    local complete = true
    for key, value in pairs(tab) do
        if not value.completed then
            return false
        end
    end
    return complete
end
this.OnShowPanel = function(arge)
    if arge[0] == UIName.BattlePrepareViewModel then
        LuaMgr.RemoveUIEventListener(1001, this.OnShowPanel)
        LuaMgr.HidePanel(UIName.CollectorPracticeAchieveViewModel)
    end
end

this.MissionView = function(localType)
    local tempList = {}
    for key, value in pairs(DataMgr.Player.missions["weekly"]["603"]) do
        local eventConfig = ConfigMgr.Config.missionMap[value.id]
        local tempMission = {
            eventId = value.id, notGetStatus = value.completed == false and Vector3.one or Vector3.zero,
            alreadyGetState = value.completed == true and Vector3.one or Vector3.zero,
            canGet = value.current >= value.target and not value.completed,
            eventText = LuaMgr.GetLangText(eventConfig.NameLan),
            daily = typeStr == missionType.daily and Vector3.one or Vector3.zero,
            weekly = typeStr == missionType.weekly and Vector3.one or Vector3.zero,
            getBut = value.current >= value.target and Vector3.one or Vector3.zero,
            gotoBut = value.current < value.target and Vector3.one or Vector3.zero,
            current = value.current, target = value.target, eventLock = Vector3.zero,
            pointShowCount = "+" .. eventConfig.rewards[1].count, eventCount = value.current .. "<size=20><color=#262429>/" .. value.target .. "</color></size>",
            pointCount = eventConfig.rewards[1].count, targetCount = value.target,
            barFloat = value.current / value.target, width = Vector2(748 + screenAddWidth, 96), status = value.completed,
            showStartParticle = false
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
    this.vm.data.eventList = tempList
    if localType == "daily" then
        this.AcitveView(localType, missionType.dailyActive)
    elseif localType == "weekly" then
        this.AcitveView(localType, missionType.weeklyActive)
    end
end


this.AchievementView = function()
    unfinishedCount = 0
    local tempList = {}
    for key, value in pairs(DataMgr.Player.missions["achievement"][typeStr]) do
        local achievementConfig = ConfigMgr.Config.missionMap[value.id]
        if achievementConfig ~= nil then
            if not value.completed then
                unfinishedCount = unfinishedCount + 1
            end
            local tempAchievement = {
                achievementId = value.id, achievementText = LuaMgr.GetLangText(achievementConfig.NameLan),
                notStatus = value.completed == false and Vector3.one or Vector3.zero,
                alreadyState = value.completed == true and Vector3.one or Vector3.zero,
                aGetBtn = value.current >= value.target and Vector3.one or Vector3.zero,
                aGotoBut = value.current < value.target and Vector3.one or Vector3.zero,
                aRewardLis = {}, aBarFloat = value.current / value.target,
                aCount = LuaMgr.NumFormat(value.current) .. "<color=#6f665a>/" .. LuaMgr.NumFormat(value.target) .. "</color>",
                aLock = Vector3.zero, current = value.current, target = value.target, status = value.completed, num = value.current / value.target
            }

            local itemRare = 0
            local tempRewardLis = {}
            for i = 1, #achievementConfig.rewards do
                itemRare = ConfigMgr.Config.itemMap[achievementConfig.rewards[i].itemId].rare
                local rewardItem = {
                    id = achievementConfig.rewards[i].itemId, count = LuaMgr.NumFormat(achievementConfig.rewards[i].count), isCount = true,
                    rare = ActivityMgr.GetRareSprite(itemRare), rareInt = itemRare,
                    icon = ActivityMgr.GetItemTexture(achievementConfig.rewards[i].itemId),
                    scale = Vector3(0.9, 0.9, 1), sizeDelta = Vector2(128, 128), isClick = true
                }
                table.insert(tempRewardLis, rewardItem)
            end
            table.sort(tempList, this.AchievementSort)
            table.sort(tempRewardLis, this.RareSort)
            tempAchievement.aRewardLis = tempRewardLis
            table.insert(tempList, tempAchievement)
        end
    end
    table.sort(tempList, this.AchievementSort)
    this.vm.data.achievementList = tempList
    this.vm.data.achievementComplete = unfinishedCount > 0 and Vector3.zero or Vector3.one
    if unfinishedCount == 0 then
        for i = 1, #this.vm.data.achievementList do
            this.vm.data.achievementList[i].aLock = Vector3.one
        end
    end
end






return vm({
    data = data,
    command = command,
    hook = hook
})