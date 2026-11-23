local this = {
    time = 4,
    callback = nil,
};

local objs = {
    animator = { path = "root/Middle", type = "UIAnimator" },
    pauseMaskGO = { path = "root/PauseMask", type = "GameObject" },
    pauseGO = { path = "root/Middle/Pause", type = "GameObject" },
    exitBtn = { path = "root/Middle/Pause/Exit", type = "Button" },
    restartBtn = { path = "root/Middle/Pause/Restart", type = "Button" },
    resumeBtn = { path = "root/Middle/Pause/Resume", type = "Button" },
    timeMaskGO = { path = "root/TimeMask", type = "GameObject" },
    timeGO = { path = "root/Middle/Time", type = "GameObject" },
};


this.SetData = function(type)
    SetActive(this.pauseMaskGO, true);
    SetActive(this.pauseGO, true);
    SetActive(this.timeMaskGO, false);
    SetActive(this.timeGO, false);
    if (type == 0) then
        this.OnClickResume();
    end
end


this.OnTimer = function()
    if (this.time > 0) then
        this.time = this.time - 1;
        return;
    end
    LuaMgr.RemoveTimer(TimerConst.FoodComposePauseTime);
    JSYZGameMgr.Play();
    if (this.callback ~= nil) then
        this.callback();
    end
    LuaMgr.HidePanel(UIName.JSYZGamePauseViewModel);
end


this.OnClickExit = function()
    LuaMgr.HidePanel(UIName.JSYZGamePauseViewModel);
    JSYZGameMgr.Result(false);

end


this.OnClickRestart = function()
    LuaMgr.HidePanel(UIName.JSYZGamePauseViewModel);
    LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZGameRestart);
end


this.OnClickResume = function()
    SetActive(this.pauseMaskGO, false);
    SetActive(this.pauseGO, false);
    SetActive(this.timeMaskGO, true);
    SetActive(this.timeGO, true);
    this.time = 4;
    LuaMgr.AddTimer(TimerConst.FoodComposePauseTime, this.OnTimer, 1, -1, true);
end

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.exitBtn, this.OnClickExit);
        LuaMgr.AddClick(this.restartBtn, this.OnClickRestart);
        LuaMgr.AddClick(this.resumeBtn, this.OnClickResume);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.callback = vm.behaviour.Params[1];
        this.SetData(vm.behaviour.Params[0]);
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.FoodComposePauseTime);
        this.callback = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickExit);
        LuaMgr.RemoveClick(this.restartBtn, this.OnClickRestart);
        LuaMgr.RemoveClick(this.resumeBtn, this.OnClickResume);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})