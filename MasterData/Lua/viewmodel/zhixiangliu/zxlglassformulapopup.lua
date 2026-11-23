
require("ViewModel/ZhiXiangLiu/ViewItem/ZXLFormulaItem")
local objs = {
    formulaItem = {path = "template/FormulaItem", type = UITool.GameObject},
    closeBtn = {path = "root/Mask", type = UITool.Button},
    maskCloseBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    scrollView = {path = "root/Middle/ScrollView", type = UITool.GameObject}
}

local this = {}

this.before_awake = function()
    this.scrollViewUI = UIScrollView.New(this.scrollView)
end

this.before_active = function()
    this.scrollViewUI:Clear()
    local allDatas = ZXLData.GetAllGlassDatas(true)
    local scrollDatas = {}
    local width = 831
    for i = 1, #allDatas do
        local data = allDatas[i]
        if data.config.Type == 1 then
            local scrollData = UIScrollData.GetData(this.formulaItem, "ZXLFormulaItem", width, 95, data)
            table.insert(scrollDatas, #scrollDatas + 1, scrollData)
        end
    end
    this.scrollViewUI:SetParams(this.scrollWidth, 388.5)
    this.scrollViewUI:SetData(scrollDatas, true)
end

this.OnClickCloseBtn = function()
    LuaMgr.HidePanel(UIName.ZXLGlassFormulaPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.closeBtn, this.OnClickCloseBtn)
        LuaMgr.AddClick(this.maskCloseBtn, this.OnClickCloseBtn)
    end,
    before_active = function(vm)
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickCloseBtn)
        LuaMgr.RemoveClick(this.maskCloseBtn, this.OnClickCloseBtn)
        UIScrollView.ClearItem("ZXLFormulaItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)