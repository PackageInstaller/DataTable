




require("ViewModel/Activity/TurnOverMissionItem")

local this = {
    vm = nil,activityConfig = nil,callBack = nil,
    missionScroll = nil,missionTemplate = nil,
}

local data = {

}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.TurnOverMissionPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.missionTemplate = this.vm.behaviour.transform:Find("template/MissionItem").gameObject
        this.missionScroll = UIScrollView.New(this.vm.behaviour.transform:Find("root/Middle/Scroll").gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.callBack = nil
        this.RemoveUIEvent()
        this.missionScroll:Clear()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("TurnOverMissionItem")
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length > 0 then
        this.callBack = this.vm.behaviour.Params[0]
    end
    local groupId = ActivityMgr.groupKeyList[ActivityKey.NewCelebration]
    if IsNullOrEmpty(groupId) then return end
    local typeId = string.sub(groupId,7)
    this.activityConfig = ConfigMgr.Config.activityGroup[typeId]
    if not TableIsNull(this.activityConfig) then
        local questEvent = DataExHelper.Check_ConfigQuestEventByText("CelebrationTask")
        if TableIsNull(questEvent) then
            return
        end
        this.SetMission(questEvent)
    end
end

this.SetMission = function(questEvent)
    this.missionScroll:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    for i = 1, #questEvent do
        groupData = {}
        groupData.config = questEvent[i]
        if DataMgr.Player.quests[questEvent[i].id] == nil then
            goto continue
        end
        groupData.data = DataMgr.Player.quests[questEvent[i].id]
        if groupData.data.state == 2 and groupData.data.progress >= groupData.config.progress then
            groupData.sortNum = 1
        elseif groupData.data.state == 1 then
            groupData.sortNum = 2
        else
            groupData.sortNum = 3
        end
        groupData.gotoPanel = this.MissionGotoPanel
        groupData.getReward = this.GetReward
        scrollData = UIScrollData.GetData(this.missionTemplate,"TurnOverMissionItem",556,76,groupData)
        table.insert(scrollDatas,scrollData)
        ::continue::
    end
    this.missionScroll:SetParams(556,490)
    table.sort(scrollDatas,this.RewardSort)
    this.missionScroll:SetData(scrollDatas, true)
end

this.MissionGotoPanel = function(config)
    if TableIsNull(config) then
        return
    end
    if IsNullOrEmpty(config.skipPage) then
        return
    end
    FeatureManager.GotoViewModel(config.skipPage)
    LuaMgr.HidePanel(UIName.TurnOverMissionPopup)
end

this.GetReward = function()
    local tempList = {}
    for i = 1, #this.missionScroll.dataList do
        if this.missionScroll.dataList[i].data.data.state == 2 then
            table.insert(tempList,this.missionScroll.dataList[i].data.data.id)
        end
    end
    if TableIsNull(tempList) then
        return
    end
    DataExHelper.EX_GetAwards(tempList,function()
        if not TableIsNull(this.activityConfig) then
            local questEvent = DataExHelper.Check_ConfigQuestEventByText("CelebrationTask")
            if TableIsNull(questEvent) then
                return
            end
            this.SetMission(questEvent)
            if this.callBack ~= nil then
                this.callBack()
            end
        end
    end)
end

this.RewardSort = function(item1,item2)
    local targetCount1 = item1.data.config.progress
    local targetCount2 = item2.data.config.progress
    if item1.data.sortNum == item2.data.sortNum then
        if item1.data.data.progress / targetCount1 ~= item2.data.data.progress / targetCount2 then
            return item1.data.data.progress / targetCount1 > item2.data.data.progress / targetCount2
        else
            return item1.data.data.id < item2.data.data.id
        end
    else
        return item1.data.sortNum < item2.data.sortNum
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})