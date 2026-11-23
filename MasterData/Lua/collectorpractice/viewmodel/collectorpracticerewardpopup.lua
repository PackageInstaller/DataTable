




require("CollectorPractice/ViewModel/YXTwoRewardItemViewModel")

local this = {
    vm = nil,missionTab = "",missionType = "",missionGroup = nil,
    scrollView = nil,rewardTemplate = nil,completedIdList = nil,
}

local data = {
    rewardTipText = "",
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.CollectorPracticeRewardPopup)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.rewardTemplate = this.vm.behaviour.transform:Find("template/RewardItem").gameObject
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Scroll").gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.SetLanguageText()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.scrollView:Clear(false)
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("YXTwoRewardItemViewModel")
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length ~= 3 then return end
    this.missionTab = this.vm.behaviour.Params[0]
    this.missionType = this.vm.behaviour.Params[1]
    this.missionGroup = this.vm.behaviour.Params[2]
    if IsNullOrEmpty(this.missionTab) or IsNullOrEmpty(this.missionType) then return end
    
    local tempData = DataMgr.Player.missions["YX2BUFF"]["701"]
    if TableIsNull(tempData) then return end
    this.completedIdList = {}
    
    this.scrollView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local tempConfig = nil
    for key,value in pairs(tempData) do
        tempConfig = ConfigMgr.Config.missionMap[key]
        if not TableIsNull(tempConfig) then
            if tonumber(tempConfig.condition1[1].ElementID) == this.missionGroup then
                groupData = {}
                groupData.data = value
                groupData.config = tempConfig
                groupData.fun = this.GetMissionReward
                scrollData = UIScrollData.GetData(this.rewardTemplate,"YXTwoRewardItemViewModel",660,60 + 5,groupData)
                table.insert(scrollDatas,scrollData)
                if not value.completed and value.current >= MissionHelper.GetTargetCount(key) then
                    table.insert(this.completedIdList,value.id)
                end
            end
        end
    end
    this.scrollView:SetParams(673,365)
    this.scrollView:SetPadding(0,0,-10,0)
    table.sort(scrollDatas,this.RewardSort)
    this.scrollView:SetData(scrollDatas,true)
end


this.SetLanguageText = function()
    this.vm.data.rewardTipText = ConfigMgr.LangGlobal("7201")
end

this.GetMissionReward = function()
    if TableIsNull(this.completedIdList) then return end
    local tempData = {}
    tempData.Tab = ""
    tempData.MissionIDs = this.completedIdList
    ApiMgr.Request("complete_mission",tempData,true,function(result)
        local re = json.decode(result)
        local resultData = json.encode(re.result)
        LuaMgr.ShowItemRewared(resultData,nil)
        this.InitParameter()
        LuaMgr.InvokeUIEventListeners(UIEventConst.YXTwoMissionGetReward)
        HeroRedDataHelper.RefreshCollectorAchievementVersion2Red();
    end,nil,true)
    tempData,this.completedIdList = nil,nil
end

this.RewardSort = function(item1,item2)
    if item1.data.data.completed == item2.data.data.completed then
        return item1.data.data.target < item2.data.data.target
    else
        return not item1.data.data.completed and item2.data.data.completed
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})