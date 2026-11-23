local this = {
    middle = nil,
    animator = nil,
    aniIn = "ani_ui_toblack_001",
    aniOut = "ani_ui_toblack_002",
    callback = nil,
};

this.PlayShowAni = function(vm)
    if (vm.behaviour.Params == nil) then return end

    if (vm.behaviour.Params.Length > 0) then
        this.callback = vm.behaviour.Params[0];
        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnShowAni);
        this.animator.AnimationName = this.aniIn;
        SetActive(this.middle, true);
    else
        SetActive(this.middle, false);
    end
end

this.OnShowAni = function(args)
    if (args.Length > 0 and args[0] == this.aniIn) then
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnShowAni);
        if (this.callback ~= nil) then
            this.callback();
        end
        LuaMgr.NextFrame(this.PlayHideAni);
    end
end

this.PlayHideAni = function()
    LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnHideAni);
    this.animator.AnimationName = this.aniOut;
end

this.OnHideAni = function(args)
    if (args.Length > 0 and args[0] == this.aniOut) then
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnHideAni);
        SetActive(this.middle, false);
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.middle = vm.behaviour.transform:Find("root/Middle").gameObject;
        this.animator = vm.behaviour.transform:Find("root/Middle/Animation"):GetComponent("UIAnimator");
    end,
    before_active = this.PlayShowAni,
    refresh = this.PlayShowAni,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnShowAni);
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnHideAni);
        this.callback = nil;
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})