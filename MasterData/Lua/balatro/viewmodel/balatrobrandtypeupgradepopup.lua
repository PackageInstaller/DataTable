







require("Balatro/ViewModel/BalatroBrandTypeUpItem")
local objs = {
    itemTemplete = {path = "template/BrandTypeItem", type = BalatroUtil.GameObject},
    backBtn = {path = "root/Middle/ExitBtn", type = BalatroUtil.Button},
    confirmBtn = {path = "root/Middle/ConfirmBtn", type = BalatroUtil.Button},
    scrollViewObj = {path = "root/Middle/Group/ScrollView", type = BalatroUtil.GameObject},
    scrollViewContent = {path = "root/Middle/Group/ScrollView/Viewport/Content", type = BalatroUtil.Transform}
}

local this = {
    scrollWidth = 880,
    scrollHeight = 515,
    itemHeight = 80
}

this.before_awake = function()
    LuaMgr.AddClick(this.backBtn, this.OnClickBack)
    LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm)
    this.scrollView = UIScrollView.New(this.scrollViewObj)
    this.scrollView:Clear(false)
end

this.before_active = function()
    local orginDatas = BalatroDataMgr.GetBrandTypeDatas()
    this.datas = {}
    for key, value in pairs(orginDatas) do
        table.insert(this.datas, value)
    end
    table.sort(this.datas, this.SortBrandType)
    local scrollDatas = {}
    local index = 1
    for key, value in pairs(this.datas) do
        local data = {}
        data.index = index
        data.brandTypeData = value
        data.clickCallback = this.OnChooseBrandType
        local scrollData = UIScrollData.GetData(this.itemTemplete, "BalatroBrandTypeUpItem", this.scrollWidth, this.itemHeight, data)
        table.insert(scrollDatas, scrollData)
        index = index + 1
    end
    this.scrollView:SetParams(this.scrollWidth, this.scrollHeight)
    this.scrollView:SetData(scrollDatas, true)
end




this.SortBrandType = function(data1, data2)
    return data1:GetSortID() > data2:GetSortID()
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.BalatroBrandTypeUpgradePopup)
    this.ClosePanelCallback(true)
end

this.OnClickConfirm = function()
    if not this.curChoosedItem then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20009")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    LuaMgr.HidePanel(UIName.BalatroBrandTypeUpgradePopup)
    this.ClosePanelCallback(nil)
end


this.OnChooseBrandType = function(item)
    if not item then
        LuaDebug.error(debug.traceback("this.ShowBrandTypeDetail"))
        return
    end
    if this.curChoosedItem then
        this.curChoosedItem:SetSelected(false)
    end
    this.curChoosedItem = item
    this.curChoosedItem:SetSelected(true)
end

this.ParseParam = function(data)
    this.InternalParam = data
end

this.ClosePanelCallback = function(isCancel)
    if not this.InternalParam then
        LuaDebug.error("BalatroBrandTypeUpgradePopup.ClosePanelCallback 外部传入参数不存在")
        return
    end
    local data = {}
    data.isCancel = isCancel
    data.operateType = this.InternalParam.operateType
    data.selectID = 0
    if this.curChoosedItem then
        local tempData = this.curChoosedItem:GetData()
        if tempData then
            data.selectID = tempData:GetID()
        end
    end
    if this.InternalParam.callback then
        this.InternalParam.callback(data)
    end
    if this.curChoosedItem then
        this.curChoosedItem:SetSelected(false)
        this.curChoosedItem = nil
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddUIEventListener(UIEventConst.BalatroBrandTypeUpgradeSelect, this.OnChooseBrandType)
        if vm.behaviour.Params and vm.behaviour.Params.Length > 0 then
            this.ParseParam(vm.behaviour.Params[0])
        end
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params and vm.behaviour.Params.Length > 0 then
            this.ParseParam(vm.behaviour.Params[0])
            vm.behaviour:PopupBack(this.OnClickBack)
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.BalatroBrandTypeUpgradeSelect, this.OnChooseBrandType)
        LuaMgr.RemoveClick(this.backBtn, this.OnClickBack)
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm)
        UIScrollView.ClearItem("BalatroBrandTypeUpItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)