local this = {
    type = 0,
};

local objs = {

    tipsStart = { path = "root/Middle/Start", type = "GameObject" },
    tipsEnd = { path = "root/Middle/End", type = "GameObject" },
};


this.SetData = function()
    SetActive(this.tipsStart, this.type == 1);
    SetActive(this.tipsEnd, this.type == 2 or this.type == 3);
    LuaMgr.AddTimer(TimerConst.ParkourResultTime, this.OnTimer, 1, 1, false);
end


this.OnTimer = function()
    if (this.type == 1) then
        ParkourMap.Play();
    elseif (this.type == 2) then
        ParkourCharacter.MoveOffScreen(ParkourMap.ParkourReward);
    elseif (this.type == 3) then
        ParkourMap.ParkourReward();
    end
    LuaMgr.HidePanel(UIName.ParkourTipsViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.type = vm.behaviour.Params[0];
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.ParkourResultTime);
    end,
    before_destroy = function()
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})