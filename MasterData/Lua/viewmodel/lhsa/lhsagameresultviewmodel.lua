local this = {
    confirmCallback = nil,
}

local objs = {
    textTitle   = { path = "root/Middle/Result/TextTitle", type = "Text" },
    cancelBtn   = { path = "root/Middle/Result/BtnBox/Cancel", type = "Button" },
    confirmBtn  = { path = "root/Middle/Result/BtnBox/Confirm", type = "Button" },
}


this.SetData = function(titleStr)
    this.textTitle.text = titleStr
end


this.OnClickCancel = function()
    LuaMgr.HidePanel(UIName.LHSAGameResultViewModel)
end


this.OnClickConfirm = function()
    if this.confirmCallback ~= nil then
        this.confirmCallback()
    end
    LuaMgr.HidePanel(UIName.LHSAGameResultViewModel)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.cancelBtn,  this.OnClickCancel)
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then return end
        local data = vm.behaviour.Params[0]
        this.confirmCallback = data.callback
        this.SetData(data.content)
    end,
    before_deactive = function(vm)
        this.confirmCallback = nil
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.cancelBtn,  this.OnClickCancel)
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm)
    end,
}

return vm({
    data    = data,
    command = command,
    hook    = hook
})