local this = {
    
};

local objs = {
    tips = { path = "root/Left/Tips/Text", type = "Text" },
};


this.SetData = function()
    this.tips.text = ConfigMgr.LangGlobal("18341");
    local closeTime = ConfigMgr.Config.TravelConstants.CloseTips;
    LuaMgr.AddTimer(TimerConst.GuoBaoMainTipsDelay, this.OnTipsDelay, closeTime, 1, false);
end


this.OnTipsDelay = function()
    LuaMgr.HidePanel(UIName.GuoBaoMainTipsViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.GuoBaoMainTipsDelay);
    end,
    before_destroy = function()
        
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})