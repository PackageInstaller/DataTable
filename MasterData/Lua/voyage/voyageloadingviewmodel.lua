local this = {
    aniName = "ani_VoyageLoadingPanel_root",
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
};

local data = {}

local command = {}


this.OnPlayFinish = function(args)
    if (args.Length > 0 and args[0] == this.aniName) then
        LuaMgr.HidePanel(UIName.VoyageLoadingViewModel);
        VoyageRichManMgr.Start();
    end
end


this.OnShowPanel = function(args)
    if (args.Length > 0 and args[0] == UIName.VoyageLoadingViewModel) then
        LuaMgr.ShowLuaPanel(UIName.VoyageRichManViewModel);
    end
end

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnPlayFinish);
        LuaMgr.AddUIEventListener(UIEventConst.ShowPanel, this.OnShowPanel);
        this.animator.AnimationName = this.aniName;
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnPlayFinish);
        LuaMgr.RemoveUIEventListener(UIEventConst.ShowPanel, this.OnShowPanel);
    end,
    before_destroy = function()
        
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})