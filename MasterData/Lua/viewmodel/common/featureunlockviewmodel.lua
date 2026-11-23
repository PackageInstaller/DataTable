




local this = {
    vm = nil,
    textImg = nil,
    isPlayAni = false,
}

local data = {
    unlockText = DefaultSprite,
    isGoBtn = false,
    aniName = "",
}


this.FeatureUnlockNext = function()
    if (#this.unlockTipsList > 0) then
        this.SetData();
    else
        LuaMgr.RemoveTimer(TimerConst.FeatureUnlockNext);
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorHide);
        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorHide);
        this.vm.data.aniName = "ani_FeatureUnlockPanel_002";
        this.isPlayAni = true;
    end
end


this.GotoPanel = function(interface)
    if (IsLua(interface.screen)) then
        if (interface.tab ~= "") then
            LuaMgr.ShowLuaPanel(interface.screen, interface.tab);
        else
            LuaMgr.ShowLuaPanel(interface.screen); 
        end
    else
        if (interface.tab ~= "") then
            LuaMgr.ShowPanel(interface.screen, interface.tab);
        else
            LuaMgr.ShowPanel(interface.screen);
        end
    end
end


this.SetData = function()
    if (#this.unlockTipsList > 0) then
        this.config = this.unlockTipsList[1];
        table.remove(this.unlockTipsList, 1);
        this.vm.data.unlockText = LuaMgr.GetSprite("FeatureUnlockText", this.config.Resources);
        this.textImg:SetNativeSize();
        this.vm.data.isGoBtn = this.config.PageSkip ~= "" and not LuaMgr.IsGuide();
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorShow);
        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorShow);
        this.vm.data.aniName = "ani_FeatureUnlockPanel_001";
        AudioHelper.PlayUISFX(AudioNames.Unlocktips);
        this.isPlayAni = true;
        LuaMgr.AddTimer(TimerConst.FeatureUnlockNext, this.FeatureUnlockNext, 2, -1);
    end
end


this.OnAnimatorShow = function()
    this.isPlayAni = false;
end


this.OnAnimatorHide = function()
    this.isPlayAni = false;
    LuaMgr.HidePanel(UIName.FeatureUnlockViewModel);
end

local command = {
    OnClickClose = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (not this.isPlayAni) then
                this.FeatureUnlockNext();
            end
        end
    },
    OnClickGo = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (this.config ~= nil) then
                local pageSkip = this.config.PageSkip;
                if (pageSkip ~= "") then
                    LuaMgr.HidePanel(UIName.FeatureUnlockViewModel);
                    local interface = ConfigInterfaceMgr.GetInterfaceById(pageSkip);
                    if (interface == nil) then return end

                    if (interface.scene ~= "") then
                        LuaMgr.LoadScene(interface.scene, nil, function()
                            this.GotoPanel(interface);
                        end);
                    else
                        this.GotoPanel(interface);
                    end
                end
            end
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.textImg = vm.behaviour.transform:Find("root/Middle/Unlock/Text"):GetComponent("Image");
    end,

    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.unlockTipsList = vm.behaviour.Params[0];
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.FeatureUnlockNext);
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorShow);
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorHide);
        this.unlockTipsList = nil; 
        this.config = nil;
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook,
})