local this = {vm = nil}

local isOpen = false
local PAGE_DOWN_AUDIO_PATH = "Assets/_BundleResources/Audio/newUI/page_down.mp3";
local TREASURE_DROP_AUDIO_PATH = "Assets/_BundleResources/Audio/newUI/treasure_drop.mp3";
local TREASURE_OPEN_AUDIO_PATH = "Assets/_BundleResources/Audio/newUI/treasure_open.mp3";
local PREFAB_PATH = "Assets/_BundleResources/UI/Area/AreaExploreBoxPanel.prefab";

local data = {
    uiAniName = "",
    isEffect = false
}

local command = {
    openCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if isOpen then 
                return;
            end

            isOpen = true;
            LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish);
            this.vm.data.uiAniName = "UI_AreaExploreBoxPanel_02"
            LuaMgr.AddTimer(TimerConst.AreaExploreBoxEffect, this.OnBoxEffect, 0.1, 1)
            AudioMgr.Singleton:PlayUISFX(TREASURE_OPEN_AUDIO_PATH);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then return end

        this.vm.data.uiAniName = "UI_AreaExploreBoxPanel_01"
        this.vm.data.isEffect = false
        isOpen = false
        AudioMgr.Singleton:PlayUISFX(PAGE_DOWN_AUDIO_PATH)
        LuaMgr.AddTimer(TimerConst.AreaExploreBoxTreasureDrop, this.OnTreasureDrop, 0.2, 1)
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish)
        LuaMgr.RemoveTimer(TimerConst.AreaExploreBoxEffect);
        LuaMgr.RemoveTimer(TimerConst.AreaExploreBoxTreasureDrop);
    end,
}

this.OnTreasureDrop = function()
    AudioMgr.Singleton:PlayUISFX(TREASURE_DROP_AUDIO_PATH)
end

this.OnAnimatorPlayFinish = function(args)
    LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish);
    LuaMgr.ShowLuaPanel(UIName.AreaExploreResultViewModel, this.vm.behaviour.Params[0]);
    LuaMgr.SetDropReward(this.vm.behaviour.Params[1]);
    LuaMgr.HidePanel(UIName.AreaExploreBoxViewModel);
end

this.OnBoxEffect = function()
    this.vm.data.isEffect = true
end

return vm({
data = data,
command = command,
hook = hook,
})