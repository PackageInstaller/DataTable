







require("ViewModel/KingDeer/KingDeerNovelItem")
local this = {
    scrollView = nil,
    showIndex = 0,
    showList = nil
}

local objs = {
    novelItem = {path = "template/NovelItem", type = UITool.GameObject},
    scrollView = {path = "root/Middle/ScrollView", type = UITool.GameObject},
    closeBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    maskBtn = {path = "root/Mask", type = "Button"},
}

this.SetData = function()
    this.SetNovelList()
end

this.SetNovelList = function()
    this.scrollView:Clear(false)
    local scrollData
    local scrollDatas = {}
    local novelDatas = KingDeerData.GetNovelDatas()
    local len = #novelDatas
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.novelItem, "KingDeerNovelItem", 214, 196, novelDatas[i])
        table.insert(scrollDatas, scrollData)
    end
    this.scrollView:SetParams(1231, 363)
    this.scrollView:SetData(scrollDatas, true)
    this.showIndex = 1
    this.showList = this.scrollView.screenList
    for _, v in pairs(this.showList) do
        SetActive(v.gameObject, false)
    end
    LuaMgr.AddTimer(TimerConst.KingDeerNovelItemShow, this.OnNovelList, 0.05, -1, false)
end


this.OnNovelList = function()
    if (this.showIndex > #this.showList) then
        LuaMgr.RemoveTimer(TimerConst.KingDeerNovelItemShow)
        return
    end
    local item = this.showList[this.showIndex]
    SetActive(item.gameObject, true)
    this.showIndex = this.showIndex + 1
end

this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.KingDeerNovelPopup)
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
        LuaMgr.RemoveTimer(TimerConst.KingDeerNovelShow)
        LuaMgr.RemoveTimer(TimerConst.KingDeerNovelItemShow)
        this.showList = nil
        this.scrollView:Clear(true)
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickClose)
        UIScrollView.ClearItem("KingDeerNovelItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)