local this = {
    portConfig = nil,
    dungeonId = "",
    members = nil,
    enterDungeon = nil,
};

local objs = {
    cancelBtn = { path = "root/Middle/MopUp/Cancel", type = "Button" },
};


this.OnClickCancel = function()
    LuaMgr.RemoveTimer(TimerConst.VoyageRichManMopUpDelay);
    LuaMgr.ShowLuaPanel(UIName.VoyageRichManBattleViewModel, this.portConfig, this.dungeonId, this.members, this.enterDungeon);
    LuaMgr.HidePanel(UIName.VoyageRichManMopUpViewModel);
end


this.OnMopUpDelay = function()
    LuaMgr.RemoveTimer(TimerConst.VoyageRichManMopUpDelay);
    PlayerVoyageMgr.EnterLeaveDungeon(this.dungeonId, this.EnterLeaveDungeonResponse);
end


this.EnterLeaveDungeonResponse = function(result)
    LuaMgr.HidePanel(UIName.VoyageRichManMopUpViewModel);
    PlayerVoyageMgr.SetRollDiceCount(true);
    LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManShowDice);
    VoyageRichManMgr.SetWait(false);
    VoyageRichManMgr.CheckCorsair();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.cancelBtn, this.OnClickCancel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        VoyageRichManSceneMgr.SetDrag(false);
        this.portConfig = vm.behaviour.Params[0];
        this.dungeonId = vm.behaviour.Params[1];
        this.members = vm.behaviour.Params[2];
        this.enterDungeon = vm.behaviour.Params[3];
        LuaMgr.AddTimer(TimerConst.VoyageRichManMopUpDelay, this.OnMopUpDelay, 2, 1, false);
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.VoyageRichManMopUpDelay);
        this.portConfig = nil;
        this.members = nil;
        this.enterDungeon = nil;
        this.monsterIds = nil;
        VoyageRichManSceneMgr.SetDrag(true);
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.cancelBtn, this.OnClickCancel);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})