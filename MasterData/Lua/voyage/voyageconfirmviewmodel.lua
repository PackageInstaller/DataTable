local this = {
    confirmCalback = nil,
    cancelCallback = nil,
    data = nil,
};

local objs = {
    maskBtn = { path = "root/Mask", type = "Button" },
    content = { path = "root/Middle/Confirm/Content", type = "Text" },
    confirmBtn = { path = "root/Middle/Confirm/ConfirmBtn", type = "Button" },
    cancelBtn = { path = "root/Middle/Confirm/CancelBtn", type = "Button" },
};


this.SetData = function(params)
    local len = params.Length;
    this.content.text = params[0];
    this.confirmCalback = params[1];
    if (len >= 3) then
        this.cancelCallback = params[2];
    else
        this.cancelCallback = nil;
    end
    if (len >= 4) then
        this.data = params[3];
    else
        this.data = nil;
    end
end


this.SetCount = function()
    this.countText.text = tostring(this.count);
    this.limit.text = string.format(LuaMgr.GetLangText("VoyageConfirmViewModel_0"), this.count, this.maxCount);
end


this.OnClickConfirm = function()
    local confirmCalback = this.confirmCalback;
    local data = this.data;
    LuaMgr.HidePanel(UIName.VoyageConfirmViewModel);
    if (confirmCalback ~= nil) then
        confirmCalback(data);
    end
end


this.OnClickCancel = function()
    local cancelCallback = this.cancelCallback;
    local data = this.data;
    LuaMgr.HidePanel(UIName.VoyageConfirmViewModel);
    if (cancelCallback ~= nil) then
        cancelCallback(data);
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm);
        LuaMgr.AddClick(this.cancelBtn, this.OnClickCancel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.SetData(vm.behaviour.Params);
    end,
    before_deactive = function(vm)
        this.confirmCalback = nil;
        this.cancelCallback = nil;
        this.data = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm);
        LuaMgr.RemoveClick(this.cancelBtn, this.OnClickCancel);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})