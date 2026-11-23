require("ViewModel/YPS/YPSSignIn7DaysItem")
require("ViewModel/Activity/SignIn7DaysGoodsItem")

local objs = {
    itemParent = {path = "template/ItemParent", type = UITool.GameObject},
    explorerTitle = {path = "root/Middle/ExplorerGroup/Title", type = UITool.Text},
    explorerDesc = {path = "root/Middle/ExplorerGroup/Desc/Viewport/Content", type = UITool.Text},
    explorerScorll = {path = "root/Middle/ExplorerGroup/ScrollView", type = UITool.GameObject},
    explorerGetBtn = {path = "root/Middle/ExplorerGroup/GetBtn", type = UITool.Button},
    explorerUnlockBtn = {path = "root/Middle/ExplorerGroup/GetBtn/Unlock", type = UITool.GameObject},
    maskBtn = {path = "root/Mask", type = UITool.Button},
    closeBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    explorerGotObj = {path = "root/Middle/ExplorerGroup/GetBtn/Got", type = UITool.GameObject}
}

local this = {
    signDays = 7,

    signDaysItems = nil,

    lastSelectItem = nil,
    vm = nil,
    groupId = nil,
    activityData = nil,
    activityConfig = nil,
    questEvents = nil,
    signInTemplateOnt = nil,
    tipGoodsList = nil,
    tipsGoodContentOne = nil
}

local data = {}

this.BatchInitNode = function()
    for i = 1, this.signDays do
        local name = "Day" .. i
        local data = {}
        data.path = "root/Middle/SignGroup/" .. name
        data.type = UITool.GameObject
        objs[name] = data
    end
end

this.BatchCreateSignDay = function()
    this.signDaysItems = {}
    for i = 1, this.signDays do
        local name = "Day" .. i
        local obj = this[name]
        local signItem = YPSSignIn7DaysItem.New(obj, this.ClickItemCallback)
        table.insert(this.signDaysItems, #this.signDaysItems + 1, signItem)
    end
    this.rewardListView = UIScrollView.New(this.explorerScorll)
end


this.InitParameter = function()
    this.activityData = DataExHelper.GetDataExByTag(ActivityKey.YPS)
    if this.activityData == nil or this.TimeExpired() then
        return
    end
    this.questEvents = DataExHelper.Check_ConfigQuestEventByText("MScheckIn")
    if TableIsNull(this.questEvents) then
        return
    end
    table.sort(this.questEvents, this.QuestSort)
end

this.RefreshSignItem = function()
    if this.questEvents == nil then
        return
    end
    this.lastSelectIndex = nil
    local len = #this.questEvents
    for i = 1, len do
        local eventData = this.questEvents[i]
        local state = 0
        if DataMgr.Player.quests[eventData.id] ~= nil then
            state = DataMgr.Player.quests[eventData.id].state
        end
        local data = {
            eventCfg = eventData,
            index = i,
            state = state,
            dayName = LuaMgr.GetLangText(eventData.namelan),
            dayDesc = LuaMgr.GetLangText(eventData.remarksLan),
            items = eventData.reward,
            callBack = this.ItemCallback
        }
        this.signDaysItems[i]:SetData(data)
        if this.lastSelectIndex == nil and data.state == 2 then
            this.lastSelectIndex = i
            local item = this.signDaysItems[i]
            this.RefreshDayDetail(item)
            this.OnPlaySelectedAnim(item)
        end
    end
    local noneCanGet = false
    if this.lastSelectIndex == nil then
        for i = 1, len do
            local eventData = this.questEvents[i]
            local state = 0
            if DataMgr.Player.quests[eventData.id] ~= nil then
                state = DataMgr.Player.quests[eventData.id].state
            end
            if state == 3 then
                this.lastSelectIndex = i
            end
        end
        noneCanGet = true
    end
    local item = this.signDaysItems[this.lastSelectIndex or 1]
    item.gameObject.transform:SetAsLastSibling()
    if noneCanGet == true then
        this.RefreshDayDetail(item)
        this.OnPlaySelectedAnim(item)
    end
end



this.RefreshDayDetail = function(item)
    if item == nil then
        return
    end
    this.explorerTitle.text = item.data.dayName
    this.explorerDesc.text = item.data.dayDesc
    SetActive(this.explorerGotObj, item.data.state == 3)
    SetActive(this.explorerUnlockBtn, item.data.state ~= 2 and item.data.state ~= 3)
    this.selectData = item.data
    this.lastSelectIndex = item.data.index

    this.rewardListView:Clear()
    local scrollDatas = {}
    local allDatas = this.selectData.eventCfg.reward
    local len = NumTool.GetLen(allDatas)
    for i = 1, len do
        local data = allDatas[i]
        data.scale = 0.6
        local scrollData = UIScrollData.GetData(this.itemParent, "CommonRewardItem", 80, 80, data)
        table.insert(scrollDatas, scrollData)
    end
    this.rewardListView:SetParams(282, 84)
    this.rewardListView:SetData(scrollDatas)
end



this.ClickItemCallback = function(item)
    item.gameObject.transform:SetAsLastSibling()
    this.RefreshDayDetail(item)
    this.OnPlaySelectedAnim(item)
end

this.OnPlaySelectedAnim = function(item)
    if this.lastSelectItem ~= nil then
        this.lastSelectItem:PlayAnim(false)
    end
    this.lastSelectItem = item
    this.lastSelectItem:PlayAnim(true)
end

this.OnGetReward = function()
    if this.selectData.state ~= 2 then
        return
    end
    local questId = this.selectData.eventCfg.id
    local callback = function()
        this.RefreshSignItem()
        RedMgr.Singleton:Refresh()
        HeroRedDataHelper.SetYPSRed()
    end
    DataExHelper.EX_GetAward(questId, callback)
end

this.ClearReward = function()
    if TableIsNull(this.tipGoodsList) then
        return
    end
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

this.QuestSort = function(item1, item2)
    return item1.id < item2.id
end

this.OnClose = function()
    LuaMgr.HidePanel(UIName.YPSSignIn7DaysViewModel)
end

local command = {}

local hook = {
    before_awake = function(vm)
        this.BatchInitNode()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.BatchCreateSignDay()
        this.vm = vm
        LuaMgr.AddClick(this.explorerGetBtn, this.OnGetReward)
        LuaMgr.AddClick(this.maskBtn, this.OnClose)
        LuaMgr.AddClick(this.closeBtn, this.OnClose)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.InitParameter()
        this.RefreshSignItem()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.explorerGetBtn, this.OnGetReward)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClose)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClose)
        UIScrollView.ClearItem("CommonRewardItem")
        this = nil
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)