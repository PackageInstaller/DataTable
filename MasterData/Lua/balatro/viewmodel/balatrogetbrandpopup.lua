







local this = {
    otherBrandParentData = nil
}
local objs = {
    backBtn = {path = "root/Middle/ExitBtn", type = BalatroUtil.Button},
    confirmBtn = {path = "root/Middle/ConfirmBtn", type = BalatroUtil.Button},
    brandPreviewPrefab = {path = "template/BrandShowItem", type = BalatroUtil.GameObject},
    otherBrandGroup = {path = "root/Middle/Group/OtherBrandGroup", type = BalatroUtil.GameObject},
    propsBrandNode = {path = "root/Middle/Group/BrandNode", type = BalatroUtil.Transform},
    icon = {path = "root/Middle/Group/BrandNode/Icon", type = BalatroUtil.Image},
    name = {path = "root/Middle/Group/Name", type = BalatroUtil.Text},
    des = {path = "root/Middle/Group/Des", type = BalatroUtil.Text}
}

this.before_awake = function()
    this.otherBrandParentData = BalatroBrandShowUI.New(this.otherBrandGroup, this.brandPreviewPrefab, false)
end

this.before_active = function()
    if this.InternalParam and this.InternalParam.propsConfig then
        this.name.text = LuaMgr.GetLangText(this.InternalParam.propsConfig.Namelan) 
        this.des.text = LuaMgr.GetLangText(this.InternalParam.propsConfig.Deslan) 
        local sprite = LuaMgr.GetSprite(BalatroUtil.AlataOther, this.InternalParam.propsConfig.ResID)
        if sprite then
            this.icon.sprite = sprite
        end
    end
    this.otherBrandParentData:InitItem()
end

this.ParseParam = function(data)
    this.InternalParam = data
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.BalatroGetBrandPopup)
    this.ClosePanelCallback(true)
end

this.OnClickConfim = function()
    LuaMgr.HidePanel(UIName.BalatroGetBrandPopup)
    this.ClosePanelCallback(nil)
end

this.ClosePanelCallback = function(isCancel)
    if not this.InternalParam then
        LuaDebug.error("BalatroGetBrandPopup.ClosePanelCallback 外部传入参数不存在")
        return
    end
    local data = {}
    data.isCancel = isCancel
    data.operateType = this.InternalParam.operateType
    data.propsConfig = this.InternalParam.propsConfig
    if this.InternalParam.callback then
        this.InternalParam.callback(data)
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.backBtn, this.OnClickBack)
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfim)
        this.before_awake()
    end,
    before_active = function(vm)
        if not vm.behaviour.Params or vm.behaviour.Params.Length < 1 then
            return
        end
        this.ParseParam(vm.behaviour.Params[0])
        vm.behaviour:PopupBack(this.OnClickBack)
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.backBtn, this.OnClickBack)
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfim)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)