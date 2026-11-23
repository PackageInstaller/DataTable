







local this = {}

local objs = {
    closeBtn = {path = "root/Mask", type = BalatroUtil.Button},
    icon = {path = "root/Middle/Icon", type = BalatroUtil.Image},
    title = {path = "root/Middle/TextGruop/TitleText", type = BalatroUtil.Text},
    des = {path = "root/Middle/TextGruop/DesText", type = BalatroUtil.Text}
}

this.before_awake = function()
    LuaMgr.AddClick(this.closeBtn, this.OnClickBack)
end

this.before_active = function()
    if not this.internalData then
        return
    end
    this.icon.sprite = LuaMgr.GetSprite(this.internalData.AtlaName, this.internalData.SpriteName)
    this.title.text = this.internalData.Name
    this.des.text = this.internalData.Des
end

this.ParseParam = function(data)
    if not data then
        LuaDebug.error("BalatroBrandInfoPopup ParseParam : 参数错误")
        return
    end
    this.internalData = data
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.BalatroBrandInfoPopup)
    if this.internalData and this.internalData.Func then
        this.internalData.Func()
    end
end

this.OnClickBackOnlyClose = function()
    LuaMgr.HidePanel(UIName.BalatroBrandInfoPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        LuaMgr.AddUIEventListener(UIEventConst.BalatroIntoCalView, this.OnClickBackOnlyClose)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
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
        LuaMgr.RemoveUIEventListener(UIEventConst.BalatroIntoCalView, this.OnClickBackOnlyClose)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickBack)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)