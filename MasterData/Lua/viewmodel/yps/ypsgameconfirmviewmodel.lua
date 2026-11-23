local this = {
    confirmCallback = nil,
    cancelCallback = nil,
}

local objs = {
    msg = { path = "root/Middle/Group/Msg", type = "Text" },
    cancelBtn = { path = "root/Middle/Group/Cancel", type = "Button" },
    confirmBtn = { path = "root/Middle/Group/Confirm", type = "Button" },
}


this.SetData = function(msgStr)
    this.msg.text = msgStr;
end


this.OnClose = function()
    LuaMgr.HidePanel(UIName.YPSGameConfirmViewModel);
end


this.OnClickCancel = function()
    if (this.cancelCallback ~= nil) then
        this.cancelCallback();
    end
    FoodComposeMgr.Play();
    LuaMgr.NextFrame(this.OnClose);
end


this.OnClickConfirm = function()
    if (this.confirmCallback ~= nil) then
        this.confirmCallback();
    end
    FoodComposeMgr.Play();
    LuaMgr.NextFrame(this.OnClose);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.cancelBtn, this.OnClickCancel);
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.confirmCallback = vm.behaviour.Params[1];
        this.cancelCallback = vm.behaviour.Params[2];
        this.SetData(vm.behaviour.Params[0]);
    end,
    before_deactive = function(vm)
        this.confirmCallback = nil;
        this.cancelCallback = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.cancelBtn, this.OnClickCancel);
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm);
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})