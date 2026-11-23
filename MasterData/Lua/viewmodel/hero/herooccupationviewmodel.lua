




local data = {
    texture = DefaultTexture,
    aniName = "";
}

local this = {
    vm = nil;
    isAni = false;
};

local texturePath = "Assets/_BundleResources/Images/GuidePics/ui_xsyd_tu43.png";

this.OnAnimatorPlayFinish = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish);
    this.isAni = false;
end

local command = {
    OnClickClose={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          if (this.isAni) then return end
          
          LuaMgr.HidePanel(UIName.HeroOccupationViewModel);
      end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish);
        this.isAni = true;
        vm.data.aniName = "ani_ui_GuidePicsPanel_enter";
        vm.data.texture = LuaMgr.GetTexture(texturePath);
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish);
        this.isAni = false;
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})