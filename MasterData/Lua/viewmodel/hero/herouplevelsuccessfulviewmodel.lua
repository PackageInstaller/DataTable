local this = {vm = nil}

local data = {
}

local command = {
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,

    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Level_up_2.mp3")
        LuaMgr.RemoveTimer(TimerConst.HeroUpLevelSuccessful)
        LuaMgr.AddTimer(TimerConst.HeroUpLevelSuccessful, this.OnTimer, 2, 1)
    end,

    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
}

this.OnTimer = function() 
    LuaMgr.HidePanel(UIName.HeroUpLevelSuccessfulViewModel)
end

return vm({
    data = data,
    command = command,
    hook = hook,
})