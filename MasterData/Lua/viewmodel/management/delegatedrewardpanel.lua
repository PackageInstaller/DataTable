require("ViewModel/Management/ViewItem/DelegatedRewardItem")
local objs = {
    itemPrefab = {path = "template/RewardItem", type = UITool.GameObject},
    scrollViewObj = {path = "root/Middle/ScrollView", type = UITool.GameObject},
    exitBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    maskCloseBtn = {path = "root/Mask", type = UITool.Button},
    fastGetBtn = {path = "root/Middle/FastGetBtn", type = UITool.Button}
}

local this = {
    scrollWidth = 848,
    itemHeight = 88,
    groupId = 4160
}

this.before_awake = function()
    RedMgr.Singleton:RegisterViewModel(UIName.DelegatedRewardPanel)
    this.scrollView = UIScrollView.New(this.scrollViewObj)
end

this.RefreshScrollList = function(isInit)
    local allDatas = ManagementData.GetDelegatedRewardData()
    this.datas = {}
    for i = 1, #allDatas, 1 do
        local data = allDatas[i]
        data.callback = this.OnGetCallback
        table.insert(this.datas, data)
    end
    table.sort(this.datas, this.SortAllDatas)
    this.scrollView:Clear(true)
    local scrollDatas = {}
    for i = 1, #this.datas do
        local data = this.datas[i]
        local scrollData = UIScrollData.GetData(this.itemPrefab, "DelegatedRewardItem", this.scrollWidth, this.itemHeight, data)
        table.insert(scrollDatas, scrollData)
    end
    this.scrollView:SetParams(this.scrollWidth, 383)
    this.scrollView:SetData(scrollDatas, true)
end

this.OnGetCallback = function()
    this.RefreshScrollList()
    LuaMgr.InvokeUIEventListeners(UIEventConst.ManagementRefreshCurrency)
    ManagementData.CheckRed()
    RedMgr.Singleton:RefreshOtherViewModel(UIName.ManagementHomePanel)
end

this.SortAllDatas = function(data1, data2)
    if data1.status == CommonRewardItem.Status.CanGet and data2.status ~= CommonRewardItem.Status.CanGet then
        return true
    elseif data1.status ~= CommonRewardItem.Status.CanGet and data2.status == CommonRewardItem.Status.CanGet then
        return false
    elseif data1.status == CommonRewardItem.Status.Got and data2.status ~= CommonRewardItem.Status.Got then
        return false
    elseif data1.status ~= CommonRewardItem.Status.Got and data2.status == CommonRewardItem.Status.Got then
        return true
    end
    return data1.config.id < data2.config.id
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.DelegatedRewardPanel)
end


this.IsReceive = function()
    local questEvent
    local questData
    local len = #this.datas
    for i = 1, len do
        questEvent = this.datas[i].config
        questData = DataMgr.Player.quests[questEvent.id]
        if questData ~= nil and questData.state == 2 then
            return true
        end
    end
    return false
end


this.OnClickFastGet = function()
    if not this.IsReceive() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10453"))
        return
    end
    DataExHelper.EX_GetGroupAward(this.groupId, this.OnGetCallback)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.exitBtn, this.OnClickBack)
        LuaMgr.AddClick(this.maskCloseBtn, this.OnClickBack)
        LuaMgr.AddClick(this.fastGetBtn, this.OnClickFastGet)
    end,
    before_active = function(vm)
        this.RefreshScrollList(true)
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickBack)
        LuaMgr.RemoveClick(this.maskCloseBtn, this.OnClickBack)
        UIScrollView.ClearItem("DelegatedRewardItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)