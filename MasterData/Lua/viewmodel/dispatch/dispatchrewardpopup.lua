







require("ViewModel/Dispatch/DispatchRewardItem")
local objs = {
    itemPrefab = {path = "template/RewardItem", type = UITool.GameObject},
    scrollViewObj = {path = "root/Middle/ScrollView", type = UITool.GameObject},
    exitBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    maskCloseBtn = {path = "root/Mask", type = UITool.Button},
}

local this = {
    scrollWidth = 955,
    itemHeight = 90
}

this.before_awake = function()
    RedMgr.Singleton:RegisterViewModel(UIName.DispatchRewardPopup)
    this.scrollView = UIScrollView.New(this.scrollViewObj)
end

this.before_active = function()
    local allDatas = DispatchData.GetAllDatas()
    this.datas = {}
    for key, value in pairs(allDatas) do
        table.insert(this.datas, value)
    end
    table.sort(this.datas, this.SortDatas)
    this.scrollView:Clear(false)
    local scrollDatas = {}
    local index = 1
    for key, value in pairs(this.datas) do
        local data = value
        local scrollData = UIScrollData.GetData(this.itemPrefab, "DispatchRewardItem", this.scrollWidth, this.itemHeight, data)
        table.insert(scrollDatas, scrollData)
        index = index + 1
    end
    this.scrollView:SetParams(this.scrollWidth, 446)
    this.scrollView:SetData(scrollDatas, true)
end

this.SortDatas = function(data1, data2)
    if data1.zoneRewardStatus ~= data2.zoneRewardStatus then
        return data1.zoneRewardStatus < data2.zoneRewardStatus
    end
    return data1.id > data2.id
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.DispatchRewardPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.exitBtn, this.OnClickBack)
        LuaMgr.AddClick(this.maskCloseBtn, this.OnClickBack)
    end,
    before_active = function(vm)
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickBack)
        LuaMgr.RemoveClick(this.maskCloseBtn, this.OnClickBack)
        UIScrollView.ClearItem("DispatchRewardItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)