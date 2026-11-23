







require("ViewModel/Mission/MissionItemViewModel")
require("ViewModel/Mission/MissionRewardViewModel")
require("ViewModel/Mission/AchievementGroupViewModel")
require("ViewModel/Mission/AchievementItemViewModel")

local this = {
    vm = nil,tableInsert = table.insert,tableSort = table.sort,totalWidth = nil,
    labelRoot = nil,curLabel = nil,labelEnum = {Daily = 1,Weekly = 2,Achievement = 3},
    missionRoot = nil,missionRootMask = nil,
    rewardScroll = nil,rewardTemplate = nil,
    missionScroll = nil,missionTemplate = nil,missionScrollPos = nil,
    achievementRoot = nil,achievementData = nil,achievementScroll = nil,
    achievementGroup = nil,achievementTemplate = nil,columnCount = 0,spaceX = 0,
    allCompleted = nil,notCompletedCount = 0,
    d_RedPointCount = 0,w_RedPointCount = 0,a_RedPointCount = 0,
    m_allGetObj = nil,m_allGetBtn = nil,
    a_allGetObj = nil,a_allGetBtn = nil,a_allGetRect = nil,
    effectPoint = nil,effect_boom = nil,
    isLock = nil,
}

local data = {

}

local command = {
    dailyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.curLabel == this.labelEnum.Daily then
                return
            end
            this.curLabel = this.labelEnum.Daily
            this.SwitchLabel()
        end
    },
    weeklyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.curLabel == this.labelEnum.Weekly then
                return
            end
            this.curLabel = this.labelEnum.Weekly
            this.SwitchLabel()
        end
    },
    achievementCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.curLabel == this.labelEnum.Achievement then
                return
            end
            this.curLabel = this.labelEnum.Achievement
            this.SwitchLabel()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.GetLabelRoot()
        this.GetViewRoot()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.ScreenMonitorType("t_6");
        this.AddUIEvent()
        this.CheckBtnHide()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
        HeroParameter.EmptyEffectPoint()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("MissionRewardViewModel")
        UIScrollView.ClearItem("MissionItemViewModel")
        UIScrollView.ClearItem("AchievementGroupViewModel")
        LuaMgr.RemoveClick(this.m_allGetBtn,this.CompletedAllMission)
        LuaMgr.RemoveClick(this.a_allGetBtn,this.CompletedAllMission)
        this = nil
    end,
}

this.AddUIEvent = function()
    LuaMgr.AddUIEventListener(UIEventConst.MissionGotoPanel,this.GotoPanel)
    LuaMgr.AddUIEventListener(UIEventConst.MissionCompleted,this.CompletedMission)
end
this.RemoveUIEvent = function()
    this.achievementData = nil
    this.rewardScroll:Clear()
    this.missionScroll:Clear()
    this.achievementScroll:Clear()
    SetActive(this.effect_boom,false)
    LuaMgr.RemoveUIEventListener(UIEventConst.MissionGotoPanel,this.GotoPanel)
    LuaMgr.RemoveUIEventListener(UIEventConst.MissionCompleted,this.CompletedMission)
    LuaMgr.RemoveTimer(TimerConst.MissionRewardTime)
    LuaMgr.RemoveTimer(TimerConst.MissionItemTime)
    LuaMgr.RemoveTimer(TimerConst.MissionSendCompleted)
    LuaMgr.RemoveTimer(TimerConst.MissionEffectFlyRecover)
end


this.CheckBtnHide = function()
    this.isLock = FeatureManager.IsLock("1018")
    SetActive(this.labelRoot.achievementLayer.gameObject,not this.isLock)
end


this.InitParameter = function()
    if HeroParameter.MissionLabel == nil then
        this.curLabel = this.labelEnum.Daily
    else
        this.curLabel = HeroParameter.MissionLabel
    end
    this.totalWidth = 928 + LuaMgr.GetScreenAddWidth()
    this.missionRoot.sizeDelta = Vector2(this.totalWidth,720)
    this.achievementRoot.sizeDelta = Vector2(this.totalWidth,720)
    this.missionScrollPos.anchoredPosition = Vector2(464 + LuaMgr.GetScreenAddWidth() / 2,100)
    this.SwitchLabel()
    this.SetRedPoint()
    this.InitEffectPoint()
end


this.UpdateScreenSize = function()
    this.columnCount = math.floor(this.totalWidth / 292)
    this.spaceX = math.floor((this.totalWidth - (this.columnCount * 292)) / this.columnCount)
end

this.InitEffectPoint = function()
    if HeroParameter.effectPoint == nil then
        HeroParameter.SaveEffectPoint(this.effectPoint.transform.position,nil)
    end
end


this.SwitchLabel = function()
    LuaMgr.RemoveTimer(TimerConst.MissionSendCompleted)
    LuaMgr.RemoveTimer(TimerConst.MissionEffectFlyRecover)
    SetActive(this.missionRootMask,false)
    SetActive(this.effect_boom,false)

    SetActive(this.labelRoot.dailySelect,this.curLabel == this.labelEnum.Daily)
    SetActive(this.labelRoot.weeklySelect,this.curLabel == this.labelEnum.Weekly)
    SetActive(this.labelRoot.achievementSelect,this.curLabel == this.labelEnum.Achievement)
    this.ModifyLabelLayer()

    SetActive(this.missionRoot.gameObject,this.curLabel ~= this.labelEnum.Achievement)
    SetActive(this.achievementRoot.gameObject,this.curLabel == this.labelEnum.Achievement)

    if this.curLabel == this.labelEnum.Achievement then
        this.UpdateScreenSize()
        this.SetAchievement()
        this.vm.behaviour:UpdateTopBar("achievement",this.Back)
    else
        this.SetMissionActivity()
        this.SetMissionEvent()
        if this.curLabel == this.labelEnum.Daily then
            this.vm.behaviour:UpdateTopBar("daily",this.Back)
        else
            this.vm.behaviour:UpdateTopBar("weekly",this.Back)
        end
    end
end


this.SetMissionActivity = function()
    this.notCompletedCount = 0
    this.rewardScroll.scrollRect:StopMovement()
    local activityData,type = {},nil
    if this.curLabel == this.labelEnum.Daily then
        type = "102"
        for key,value in pairs(DataMgr.Player.missions["daily"][type]) do
            this.tableInsert(activityData,value)
        end
    elseif this.curLabel == this.labelEnum.Weekly then
        type = "104"
        for key,value in pairs(DataMgr.Player.missions["weekly"][type]) do
            this.tableInsert(activityData,value)
        end
    end
    this.rewardScroll:Clear(false)
    local scrollData = {}
    local groupData,index = nil,1
    this.tableSort(activityData,this.ActivityRewardSort)
    this.rewardScroll:SetParams(this.totalWidth,213)
    LuaMgr.AddTimer(TimerConst.MissionRewardTime,function()
        if activityData[index] ~= nil then
            if not activityData[index].completed then
                this.notCompletedCount = this.notCompletedCount + 1
            end
            groupData = {}
            groupData.type = type
            groupData.reward = activityData[index]
            scrollData = UIScrollData.GetData(this.rewardTemplate,"MissionRewardViewModel",228 + 17,212,groupData)
            this.rewardScroll:AddData(scrollData, true)
            index = index + 1
        else
            LuaMgr.RemoveTimer(TimerConst.MissionRewardTime)
        end
    end,0.06,-1,true)
    this.rewardScroll.content.sizeDelta = Vector2(this.rewardScroll.content.sizeDelta.x - 20,this.rewardScroll.content.sizeDelta.y)
    SetActive(this.allCompleted,this.notCompletedCount == 0)
end


this.SetMissionEvent = function()
    this.missionScroll.scrollRect:StopMovement()
    local count = 0
    local missionData,type = {},nil
    if this.curLabel == this.labelEnum.Daily then
        type = "101"
        for key,value in pairs(DataMgr.Player.missions["daily"][type]) do
            this.tableInsert(missionData,value)
        end
    elseif this.curLabel == this.labelEnum.Weekly then
        type = "103"
        for key,value in pairs(DataMgr.Player.missions["weekly"][type]) do
            this.tableInsert(missionData,value)
        end
    end
    this.tableSort(missionData,this.MissionEventSort)
    this.missionScroll:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    for i = 1, #missionData do
        if not missionData[i].completed and missionData[i].current >= MissionHelper.GetTargetCount(missionData[i].id) then
            count = 1
        end
        groupData = {}
        groupData.type = type
        groupData.data = missionData[i]
        groupData.animBool = false
        groupData.width = this.totalWidth
        scrollData = UIScrollData.GetData(this.missionTemplate,"MissionItemViewModel",this.totalWidth,80 + 2,groupData)
        this.tableInsert(scrollDatas,scrollData)
    end
    this.missionScroll:SetParams(this.totalWidth,460)
    if HeroParameter.MissionLabel == nil then
        this.missionScroll:SetData(scrollDatas, true)
    else
        this.missionScroll.contentX = HeroParameter.MissionContentX
        this.missionScroll.contentY = HeroParameter.MissionContentY
        this.missionScroll:SetData(scrollDatas, false)
        HeroParameter.EmptyMissionParam()
    end
    local index = this.missionScroll:GetIndex()
    LuaMgr.AddTimer(TimerConst.MissionItemTime,function()
        if this.missionScroll.itemMap[index] ~= nil then
            SetActive(this.missionScroll.itemMap[index].animatorObj,true)
            index = index + 1
        else
            for i = 1, #this.missionScroll.dataList do
                this.missionScroll.dataList[i].data.animBool = true
            end
            LuaMgr.RemoveTimer(TimerConst.MissionItemTime)
        end
    end,0.05,-1,true)
    this.SetCompletedAllBtn(count)
    missionData,type = nil,nil
end


this.SetAchievement = function()
    this.missionScroll:Clear(false)
    this.achievementScroll:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local tempData;
    local index = 1
    local count = 0
    this.GetAchievementData()
    while (index <= #this.achievementData) do
        groupData = {}
        groupData.item = this.achievementTemplate
        groupData.spaceX = this.spaceX
        groupData.achievement = {}
        for i = 1, this.columnCount do
            tempData = this.achievementData[index + i - 1]
            if tempData ~= nil then
                if not tempData.completed and tempData.current >= MissionHelper.GetTargetCount(tempData.id) then
                    count = 1
                end
                this.tableInsert(groupData.achievement,tempData)
            end
        end
        scrollData = UIScrollData.GetData(this.achievementGroup,"AchievementGroupViewModel",this.totalWidth,200,groupData)
        this.tableInsert(scrollDatas,scrollData)
        index = index + this.columnCount
    end
    this.achievementScroll:SetParams(this.totalWidth,650)
    if HeroParameter.MissionLabel == nil then
        this.achievementScroll:SetData(scrollDatas,true)
    else
        this.achievementScroll.contentX = HeroParameter.MissionContentX
        this.achievementScroll.contentY = HeroParameter.MissionContentY
        this.achievementScroll:SetData(scrollDatas,false)
        HeroParameter.EmptyMissionParam()
    end
    this.SetCompletedAllBtn(count)
end


this.ModifyLabelLayer = function()
    if this.curLabel == this.labelEnum.Daily then
        this.labelRoot.dailyLayer:SetSiblingIndex(3)
    elseif this.curLabel == this.labelEnum.Weekly then
        this.labelRoot.weeklyLayer:SetSiblingIndex(3)
    elseif this.curLabel == this.labelEnum.Achievement then
        this.labelRoot.achievementLayer:SetSiblingIndex(3)
    end
end


this.SetCompletedAllBtn = function(count)
    if this.curLabel == this.labelEnum.Achievement then
        if count > 0 then
            local width = (this.columnCount * 292 + this.columnCount * this.spaceX) - this.spaceX + 34
            this.a_allGetRect.sizeDelta = Vector2(width,116)
            this.achievementScroll:SetParams(this.totalWidth,580)
        else
            this.achievementScroll:SetParams(this.totalWidth,650)
        end
        SetActive(this.a_allGetObj,count > 0)
    else
        if count > 0 then
            if this.notCompletedCount > 0 then
                this.missionScroll:SetParams(this.totalWidth,386)
            else
                this.missionScroll:SetParams(this.totalWidth,460)
            end
            this.m_allGetObj.transform.sizeDelta = Vector2(this.totalWidth + 34,116)
        else
            this.missionScroll:SetParams(this.totalWidth,460)
        end
        SetActive(this.m_allGetObj,count > 0 and this.notCompletedCount ~= 0)
    end
end


this.SetRedPoint = function()

    this.d_RedPointCount = 0
    if this.CheckWhetherSetRedPoint("daily","102") then
        for key,value in pairs(DataMgr.Player.missions["daily"]["101"]) do
            if not value.completed and value.current >= MissionHelper.GetTargetCount(key) then
                this.d_RedPointCount = 1
                break
            end
        end
    end
    SetActive(this.labelRoot.dailyRedPoint,this.d_RedPointCount > 0)

    this.w_RedPointCount = 0
    if this.CheckWhetherSetRedPoint("weekly","104") then
        for key,value in pairs(DataMgr.Player.missions["weekly"]["103"]) do
            if not value.completed and value.current >= MissionHelper.GetTargetCount(key) then
                this.w_RedPointCount = 1
                break
            end
        end
    end
    SetActive(this.labelRoot.weeklyRedPoint,this.w_RedPointCount > 0)

    this.a_RedPointCount = 0
    if not this.isLock then
        for key,value in pairs(DataMgr.Player.missions["achievement"]["201"]) do
            if not value.completed and value.current >= MissionHelper.GetTargetCount(key) then
                this.a_RedPointCount = 1
                break
            end
        end
    end
    SetActive(this.labelRoot.achievementRedPoint,this.a_RedPointCount > 0)
end


this.CheckWhetherSetRedPoint = function(key,type)
    local isSet = false
    for k,value in pairs(DataMgr.Player.missions[key][type]) do
        if not value.completed then
            return true
        end
    end
    return isSet
end

this.GotoPanel = function(args)
    local taskName = nil
    local missionId = args[0]
    local config = ConfigMgr.Config.missionMap[missionId]
    if this.curLabel == this.labelEnum.Daily then
        taskName = "daily"
    elseif this.curLabel == this.labelEnum.Weekly then
        taskName = "weekly"
    elseif this.curLabel == this.labelEnum.Achievement then
        taskName = "achievement"
    end

    DataReportMgr.AchievementTaskJumpPage(config.id,taskName)
    if config.pageSkip ~= "" then
        config = FeatureManager.GetPanelInfo(config.pageSkip)
        if config.tab == "" then
            FeatureManager.GotoPanel(config.id)
        else
            FeatureManager.GotoPanel(config.id,config.tab)
        end
        if this.curLabel == this.labelEnum.Achievement then
            HeroParameter.SaveMissionParam(this.curLabel,this.achievementScroll.contentX,this.achievementScroll.contentY)
        else
            HeroParameter.SaveMissionParam(this.curLabel,this.missionScroll.contentX,this.missionScroll.contentY)
        end
    end
    taskName,missionId,config = nil,nil,nil
end

this.SetScroll = function(reset)
    SetActive(this.effect_boom,false)
    this.rewardScroll.scrollRect:StopMovement()
    this.missionScroll.scrollRect:StopMovement()
    SetActive(this.missionRootMask,true)
    this.rewardScroll.content.anchoredPosition = Vector2.zero
    if not reset and this.curLabel ~= this.labelEnum.Achievement then
        this.SetMissionEvent()
    end
end

this.RecoverScroll = function()
    SetActive(this.missionRootMask,false)
end
this.CompletedMission = function(args)
    this.SetScroll(true)
    if args.Length > 1 then
        this.PlayerEffect(true,args[1])
    end
    local missionId = args[0]
    local tempData = {}
    if this.curLabel == this.labelEnum.Daily then
        tempData.Tab = "daily"
    elseif this.curLabel == this.labelEnum.Weekly then
        tempData.Tab = "weekly"
    elseif this.curLabel == this.labelEnum.Achievement then
        tempData.Tab = "achievement"
    end
    tempData.MissionID = missionId
    ApiMgr.Request("complete_mission",tempData,true,function(result)
        this.CompletedResult(result,this.curLabel ~= this.labelEnum.Achievement)
    end,nil,true)
    missionId,tempData = nil,nil
end

this.CompletedAllMission = function()
    this.SetScroll(false)
    local tempData,eventIdList = {},{}
    if this.curLabel == this.labelEnum.Daily then
        tempData.Tab = "daily"
        for key,value in pairs(DataMgr.Player.missions["daily"]["101"]) do
            if not value.completed and value.current >= MissionHelper.GetTargetCount(key) then
                this.tableInsert(eventIdList,value.id)
            end
        end
        tempData.MissionIDs = eventIdList
        this.PlayerEffect(false,#eventIdList)
    elseif this.curLabel == this.labelEnum.Weekly then
        tempData.Tab = "weekly"
        for key,value in pairs(DataMgr.Player.missions["weekly"]["103"]) do
            if not value.completed and value.current >= MissionHelper.GetTargetCount(key) then
                this.tableInsert(eventIdList,value.id)
            end
        end
        tempData.MissionIDs = eventIdList
        this.PlayerEffect(false,#eventIdList)
    elseif this.curLabel == this.labelEnum.Achievement then
        local count = 0
        for i = 1, #this.achievementData do
            if not this.achievementData[i].completed and this.achievementData[i].current >= MissionHelper.GetTargetCount(this.achievementData[i].id) then
                count = count + 1
            end
        end
        if count == 0 then
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2036"].NameLan))
            return
        else
            tempData.Tab = "achievement"
            tempData.MissionID = "all"
        end
        local num = this.achievementScroll:GetIndex()
        local length = ConfigHelper.GetTableLength(this.achievementScroll.itemMap)
        for i = 1, length do
            for j = 1, #this.achievementScroll.itemMap[num].itemList do
                if this.achievementScroll.itemMap[num].itemList[j].gameObject.activeSelf then
                    if this.achievementScroll.itemMap[num].itemList[j].getObj.activeSelf then
                        this.achievementScroll.itemMap[num].itemList[j]:PlayAnim()
                    end   
                end
            end
            num = num + 1
        end
    end
    ApiMgr.Request("complete_mission",tempData,true,function(result)
        this.CompletedResult(result,this.curLabel ~= this.labelEnum.Achievement)
    end,nil,true)
    tempData,eventIDList = nil,nil
end

this.CompletedResult = function(result,delay)
    this.SetRedPoint()
    LuaMgr.AddTimer(TimerConst.MissionSendCompleted,function()
        local re = json.decode(result)
        local resultData = json.encode(re.result)
        this.RecoverScroll()
        this.CompletedCallBack(resultData)
        LuaMgr.RemoveTimer(TimerConst.MissionSendCompleted)
    end,1.75,-1,not delay)
end


this.PlayerEffect = function(animType,param)
    local num = this.missionScroll:GetIndex()
    if animType then
        for i = 1, ConfigHelper.GetTableLength(this.missionScroll.itemMap) do
            if this.missionScroll.itemMap[num].index == param then
                this.missionScroll.itemMap[num]:PlayEffect()
                break
            end
            num = num + 1
        end
    else
        local count = param > 5 and 5 or param
        for i = 1, count do
            if this.missionScroll.itemMap[num].index ~= nil then
                this.missionScroll.itemMap[num]:PlayEffect()
                num = num + 1
            end
        end
    end
    LuaMgr.AddTimer(TimerConst.MissionEffectFlyRecover,function()
        SetActive(this.effect_boom,true)
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Mission_Light_002.mp3")
        LuaMgr.RemoveTimer(TimerConst.MissionEffectFlyRecover)
    end,1.75,-1,false)
end

this.CompletedCallBack = function(resultData)
    if this.curLabel == this.labelEnum.Achievement then
        LuaMgr.ShowItemRewared(resultData,function()
            this.achievementData = nil
            this.SetAchievement()
        end)
    else
        LuaMgr.ShowItemRewared(resultData,nil)
        this.SetMissionActivity()
        this.SetMissionEvent()
    end
end

this.GetAchievementData = function()
    if this.achievementData ~= nil then return end
    this.achievementData = {}
    for key,value in pairs(DataMgr.Player.missions["achievement"]["201"]) do
        this.tableInsert(this.achievementData,value)
    end
    this.tableSort(this.achievementData,this.AchievementSort)
end


this.MissionEventSort = function(item1,item2)
    if item1.completed == item2.completed then
        if item1.current / MissionHelper.GetTargetCount(item1.id) ~= item2.current / MissionHelper.GetTargetCount(item2.id) then
            return item1.current / MissionHelper.GetTargetCount(item1.id) > item2.current / MissionHelper.GetTargetCount(item2.id)
        else
            return item1.id < item2.id
        end
    else
        return not item1.completed and item2.completed
    end
end


this.ActivityRewardSort = function(item1,item2)
    if item1.completed == item2.completed then
        return item1.id < item2.id
    else
        return not item1.completed and item2.completed
    end
end


this.AchievementSort = function(item1,item2)
    if item1.completed == item2.completed then
        if item1.current / MissionHelper.GetTargetCount(item1.id) ~= item2.current / MissionHelper.GetTargetCount(item2.id) then
            return item1.current / MissionHelper.GetTargetCount(item1.id) > item2.current / MissionHelper.GetTargetCount(item2.id)
        else
            return item1.id < item2.id
        end
    else
        return not item1.completed and item2.completed
    end
end

this.LabelTransform = {

    dailyLayer = {path = "DailyLabel",type = "RectTransform"},
    dailySelect = {path = "DailyLabel/Select",type = "GameObject"},
    dailyRedPoint = {path = "DailyLabel/RedPoint",type = "GameObject"},

    weeklyLayer = {path = "WeeklyLabel",type = "RectTransform"},
    weeklySelect = {path = "WeeklyLabel/Select",type = "GameObject"},
    weeklyRedPoint = {path = "WeeklyLabel/RedPoint",type = "GameObject"},

    achievementLayer = {path = "AchievementLabel",type = "RectTransform"},
    achievementSelect = {path = "AchievementLabel/Select",type = "GameObject"},
    achievementRedPoint = {path = "AchievementLabel/RedPoint",type = "GameObject"},
}

this.GetLabelRoot = function()
    local root = this.vm.behaviour.transform:Find("root/Middle/LabelRoot"):GetComponent("RectTransform")
    this.labelRoot = {}
    UITool.Parse(root,this.labelRoot,this.LabelTransform)
    this.LabelTransform = nil
end

this.GetViewRoot = function()
    this.missionRoot = this.vm.behaviour.transform:Find("root/Middle/MissionRoot"):GetComponent("RectTransform")
    this.missionRootMask = this.vm.behaviour.transform:Find("root/Middle/MissionRoot/MissionRootMask").gameObject
    this.rewardScroll = UIScrollView.New(this.vm.behaviour.transform:Find("root/Middle/MissionRoot/RewardView").gameObject)
    this.rewardTemplate = this.vm.behaviour.transform:Find("template/RewardItem").gameObject
    this.missionScrollPos = this.vm.behaviour.transform:Find("root/Middle/MissionRoot/MissionView"):GetComponent("RectTransform")
    this.missionScroll = UIScrollView.New(this.vm.behaviour.transform:Find("root/Middle/MissionRoot/MissionView").gameObject)
    this.missionTemplate = this.vm.behaviour.transform:Find("template/MissionItem").gameObject
    
    this.achievementRoot = this.vm.behaviour.transform:Find("root/Middle/AchievementRoot"):GetComponent("RectTransform")
    this.achievementScroll = UIScrollView.New(this.vm.behaviour.transform:Find("root/Middle/AchievementRoot/AchievementView").gameObject)
    this.achievementGroup = this.vm.behaviour.transform:Find("template/AchievementGroup").gameObject
    this.achievementTemplate = this.vm.behaviour.transform:Find("template/AchievementItem").gameObject
    
    this.allCompleted = this.vm.behaviour.transform:Find("root/Middle/MissionRoot/AllCompleted").gameObject
    
    this.m_allGetObj = this.vm.behaviour.transform:Find("root/Middle/MissionRoot/AllGetBtn").gameObject
    this.m_allGetBtn = this.vm.behaviour.transform:Find("root/Middle/MissionRoot/AllGetBtn"):GetComponent("Button")
    LuaMgr.AddClick(this.m_allGetBtn,this.CompletedAllMission)
    this.a_allGetObj = this.vm.behaviour.transform:Find("root/Middle/AchievementRoot/AllGetBtn").gameObject
    this.a_allGetBtn = this.vm.behaviour.transform:Find("root/Middle/AchievementRoot/AllGetBtn"):GetComponent("Button")
    this.a_allGetRect = this.vm.behaviour.transform:Find("root/Middle/AchievementRoot/AllGetBtn"):GetComponent("RectTransform")
    LuaMgr.AddClick(this.a_allGetBtn,this.CompletedAllMission)
    
    this.effectPoint = this.vm.behaviour.transform:Find("root/Middle/MissionRoot/EffectPoint").gameObject
    this.effect_boom = this.vm.behaviour.transform:Find("root/Middle/MissionRoot/EffectPoint/eff_boom").gameObject
end
this.Back = function()
    LuaMgr.Back()
end
return vm({
    data = data,
    command = command,
    hook = hook
})