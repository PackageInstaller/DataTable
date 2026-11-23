local this = {
    time = 3,
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
    timeNum1 = { path = "root/Middle/Time/Num1", type = "GameObject" },
    timeNum2 = { path = "root/Middle/Time/Num2", type = "GameObject" },
    timeNum3 = { path = "root/Middle/Time/Num3", type = "GameObject" },
};


this.SetData = function()
    SetActive(this.pauseMaskGO, true);
    SetActive(this.pauseGO, true);
    SetActive(this.timeMaskGO, false);
    SetActive(this.timeGO, false);

end


this.OnTimer = function()
    if (this.time > 0) then
        SetActive(this.timeNum1, this.time == 1);
        SetActive(this.timeNum2, this.time == 2);
        SetActive(this.timeNum3, this.time == 3);
        this.time = this. time - 1;
        return;
    end
    LuaMgr.RemoveTimer(TimerConst.ParkourPauseTime);
    LuaMgr.HidePanel(UIName.ParkourPauseViewModel);
    ParkourMap.Play();
end


this.OnClickExit = function()
    LuaMgr.HidePanel(UIName.ParkourPauseViewModel);
    ParkourMap.ParkourReward();
end


this.OnClickRestart = function()
    LuaMgr.HidePanel(UIName.ParkourPauseViewModel);
    LuaMgr.InvokeUIEventListeners(UIEventConst.ParkourRestart);
end


this.OnClickResume = function()
    SetActive(this.pauseMaskGO, false);
    SetActive(this.pauseGO, false);
    SetActive(this.timeMaskGO, true);
    SetActive(this.timeGO, true);
    this.time = 3;

    LuaMgr.AddTimer(TimerConst.ParkourPauseTime, this.OnTimer, 1, -1, true);
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
        
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.ParkourPauseTime);
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