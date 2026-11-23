local this = {
    
};

local objs = {
    maskBtn = { path = "root/Mask", type = "Button" },
};


this.OnClickMask = function()
    LuaMgr.HidePanel(UIName.VoyageTradeHelpViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
    end,
    before_deactive = function(vm)
        
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})