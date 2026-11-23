local this = {
    aniName = "ani_GuoBaoFirstPagePanel_root",
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
};

this.OnPlayFinish = function(args)
    if (args[0] == this.aniName) then
        LuaMgr.HidePanel(UIName.GuoBaoFirstPageViewModel);
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnPlayFinish);
        this.animator.AnimationName = this.aniName;
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnPlayFinish);
    end,
    before_destroy = function()
        
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})