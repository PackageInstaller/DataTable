local objs = {
    icon = {path = "root/Middle/Icon", type = UITool.Image},
    desc = {path = "root/Middle/Desc", type = UITool.Text},
    confirmBtn = {path = "root/Middle/ConfirmBtn", type = UITool.Button},
    cancelBtn = {path = "root/Middle/CancelBtn", type = UITool.Button}
}

local this = {}

this.before_awake = function()
end

this.before_active = function()
    this.icon.sprite = LuaMgr.GetSprite(JZQWConst.GameAtlasName, this.propsData.Config.Icon)
    this.desc.text = LuaMgr.GetLangText(this.propsData.Config.NameLan)
end

this.OnClickConfirmBtn = function()
    LuaMgr.HidePanel(UIName.JZQWGamePropsInfoPopup)
    if this.onConfirm ~= nil then
        this.onConfirm()
    end
end

this.OnClickCancelBtn = function()
    LuaMgr.HidePanel(UIName.JZQWGamePropsInfoPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirmBtn)
        LuaMgr.AddClick(this.cancelBtn, this.OnClickCancelBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length < 1 then
            return
        end
        local data = vm.behaviour.Params[0]
        this.propsData = data.PropsData
        this.onConfirm = data.OnConfirm
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirmBtn)
        LuaMgr.RemoveClick(this.cancelBtn, this.OnClickCancelBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)