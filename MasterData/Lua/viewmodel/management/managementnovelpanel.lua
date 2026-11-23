require("ViewModel/Management/ViewItem/ManagementNovelItem")
local this = {
    scrollView = nil,
    showIndex = 0,
    showList = nil
}

local objs = {
    novelItem = {path = "template/NovelItem", type = UITool.GameObject},
    scrollView = {path = "root/Middle/ScrollView", type = UITool.GameObject},
    closeBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    maskBtn = {path = "root/Mask", type = "Button"}
}

this.SetData = function()
    this.SetNovelList()
end

this.SetNovelList = function()
    this.scrollView:Clear(false)
    local scrollData
    local scrollDatas = {}
    local novelDatas = ManagementData.GetNovelData()
    local len = #novelDatas
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.novelItem, "ManagementNovelItem", 290, 312, novelDatas[i])
        table.insert(scrollDatas, scrollData)
    end
    this.scrollView:SetParams(1140, 364)
    this.scrollView:SetData(scrollDatas, true)
    this.scrollView.scrollCallBack = this.ScrollCallBack
    this.showIndex = 1
    this.showList = this.scrollView.screenList
    for _, value in pairs(this.showList) do
        value:SetAlpha(1)
        value:SetAnimtor(false)
        SetActive(value.gameObject, false)
    end
    LuaMgr.AddTimer(TimerConst.ManagementDelayShowItem, this.OnNovelList, 0.05, -1, false)
end

this.ScrollCallBack = function(screenList)
    for key, value in pairs(screenList) do
        value:SetAnimtor(true)
        SetActive(value.gameObject, true)
    end
end


this.OnNovelList = function()
    if this.showIndex > #this.showList then
        LuaMgr.RemoveTimer(TimerConst.ManagementDelayShowItem)
        this.showList = nil
        return
    end
    local item = this.showList[this.showIndex]
    SetActive(item.gameObject, true)
    item:SetAlpha(1)
    this.showIndex = this.showIndex + 1
end

this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.ManagementNovelPanel)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.scrollView = UIScrollView.New(this.scrollView)
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose)
        LuaMgr.AddClick(this.maskBtn, this.OnClickClose)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.SetData()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.ManagementDelayShowItem)
        this.showList = nil
        this.scrollView:Clear(true)
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickClose)
        UIScrollView.ClearItem("ManagementNovelItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)