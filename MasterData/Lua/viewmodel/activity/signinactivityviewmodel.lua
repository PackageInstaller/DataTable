




require("ViewModel/Activity/SignInItemModel")

local this = {
    vm = nil,groupId = nil, activityData = nil, activityConfig = nil, 
    questEvents = nil,

    signInScrollOne = nil,
    signInTemplateOnt = nil,





    tipGoodsList = nil,
    tipsGoodContentOne = nil,
}

local data = {
    phaseOne = false,



    timeText = "",
}

local command = {
    
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.tipsGoodContentOne = this.vm.behaviour.transform:Find("root/Middle/Phase/Tips/GoodsList"):GetComponent("RectTransform")
        this.signInTemplateOnt = this.vm.behaviour.transform:Find("template/SignInItemOne").gameObject
        this.signInScrollOne =  UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Phase/SignInScroll").gameObject)

    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("SignInItemModel")
        this.ClearReward()
        this = nil
    end,
}

this.AddUIEvent = function()
    LuaMgr.AddUIEventListener(UIEventConst.SignInItemClickGetReward, this.UpdateSingIn)
end
this.RemoveUIEvent = function()
    this.signInScrollOne:Clear()
    LuaMgr.RemoveUIEventListener(UIEventConst.SignInItemClickGetReward, this.UpdateSingIn)
end


this.InitParameter = function()
    this.groupId = ActivityMgr.groupKeyList["SignIn14"]
    
    if IsNullOrEmpty(this.groupId) then return end
    this.activityData = DataMgr.Player.variables[this.groupId]
    
    if this.activityData == nil then return end

    if this.TimeExpired() then return end
    this.SetActivityTime()

    local typeId = string.sub(this.groupId,7)
    this.activityConfig = ConfigMgr.Config.activityGroup[typeId]
    this.questEvents = {}
    if this.activityConfig ~= nil then

        this.questEvents = DataExHelper.Check_ConfigQuestEventByGroupId(this.activityConfig.id)
        if TableIsNull(this.questEvents) then
            return
        end
        table.sort(this.questEvents,this.QuestSort)
    end


    this.CreateSignInItem()
    this.CreateTipGoodsItem()
end

this.SetActivityTime = function()
    local startTimeStr = ""
    local delayTimeStr = ""
    if this.activityData ~= nil then
        startTimeStr = os.date(LuaMgr.GetLangText("CollectActivityPopup_6"),this.activityData.startTime)
        delayTimeStr = os.date(LuaMgr.GetLangText("CollectActivityPopup_7"),this.activityData.delTime)
    end
    local tipStr = ConfigMgr.LangGlobal("15014")
    local timeStr = string.format("%s-%s",startTimeStr,delayTimeStr)
    this.vm.data.timeText = tipStr..timeStr
end












this.CreateSignInItem = function()
    local template = nil
    template = this.signInTemplateOnt

    this.signInScrollOne:Clear()
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local length = #this.questEvents
    local index_1,index_2 = -1,-1
    local state = 0
    for i = 1, length do
        state = DataMgr.Player.quests[this.questEvents[i].id].state
        if index_1 < 0 and state == 2 then
            index_1 = i
        end
        if index_2 < 0 and state == 1 then
            index_2 = i
        end
        groupData = {}
        groupData.state = state
        groupData.data = this.questEvents[i]
        scrollData = UIScrollData.GetData(template,"SignInItemModel",136 - 10,328,groupData)
        table.insert(scrollDatas,scrollData)
    end
    this.signInScrollOne:SetParams(976.8,355)
    this.signInScrollOne:SetPadding(0,12,0,0)
    this.signInScrollOne:SetData(scrollDatas, true)
    if index_1 < 0 and index_2 < 0 then
        this.signInScrollOne.scrollRect.horizontalNormalizedPosition = 0
    elseif index_1 < 0 and index_2 > 0 then
        this.signInScrollOne.scrollRect.horizontalNormalizedPosition = index_2 > 7 and 1.0 or 0.0
    else
        this.signInScrollOne.scrollRect.horizontalNormalizedPosition = index_1 > 7 and 1.0 or 0.0
    end
end

this.CreateTipGoodsItem = function()
    local content = nil
    content = this.tipsGoodContentOne
    if TableIsNull(this.tipGoodsList) then
        this.tipGoodsList = {}
    end
    local itemConfig = nil
    local id,count = nil,nil
    local index = 1
    for i = 1, #this.questEvents do
        if i == 3 or i == 7 or i == 10 or i == 14 then
            id = this.questEvents[i].reward[2].id
            count = this.questEvents[i].reward[2].count
            itemConfig = table.Copy(ConfigMgr.Config.itemMap[id])
            if TableIsNull(itemConfig) then return end
            if #this.tipGoodsList < index then
                table.insert(this.tipGoodsList,GoodsDataItem.New(content))
            end
            itemConfig["count0"] = count
            this.tipGoodsList[index]:SetData(index,itemConfig,1,false,Vector3(0.6,0.6,0.6),false)
            index = index + 1
        end
    end
end

this.UpdateSingIn = function(args)
    if this.TimeExpired() then
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("15901"))
        return
    end
    local missionId = args[0]
    DataExHelper.EX_GetAward(missionId,function()
        this.questEvents = DataExHelper.Check_ConfigQuestEventByGroupId(this.activityConfig.id)
        if TableIsNull(this.questEvents) then
            return
        end
        table.sort(this.questEvents,this.QuestSort)
        this.CreateSignInItem()

        local re = (ActivityMgr.ActivityCanFinish("SignIn14"))
        local redNum = re and 1 or 0
        RedMgr.Singleton:UpdateClientRedData("1310",redNum)
    end)
end

this.ClearReward = function()
    if TableIsNull(this.tipGoodsList) then return end
    for i = 1, #this.tipGoodsList do
        this.tipGoodsList[i]:Clear()
    end
    this.tipGoodsList = nil
end


this.TimeExpired = function()
    local nowTime = LuaMgr.Timestamp()
    local isExpired = false
    if nowTime < this.activityData.startTime or nowTime >= this.activityData.delTime then
        isExpired = true
    end
    return isExpired
end

this.QuestSort = function(item1,item2)
    return item1.progress < item2.progress
end

return vm({
    data = data,
    command = command,
    hook = hook
})