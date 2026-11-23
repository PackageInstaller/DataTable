local this = 
{
    vm = nil,
    activityData = nil,
    leftTime = 0,
}
local animator = nil
local data =
{
    floor = "",
    rank = "",
    time = "",
    showRank = true,
    firstFloor = true,
    notFirstFloor = false,
}

local command = 
{
    StartCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            RedMgr.Singleton:FrushRedCondition("17622")
            local maxFloor = ConfigMgr.Config.TeamTowerConstants.TowerLoopFloorMax;
            if TeamTowerMgr.GetTeamTowerData().TowerCount >= maxFloor then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29761"))
                return
            end
            animator:Play("ani_TeamTowerMainPanel_root_002")
            LuaMgr.NextFrame(function()
                HeroRedDataHelper.CheckTeamTowerRed()
                LuaMgr.ShowLuaPanel(UIName.TeamTowerLevelViewModel)
            end, 25)

        end
    },
    RewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.TeamTowerRewardPopUp)
        end
    },
}

local hook = 
{
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.TeamTowerMainViewModel);
        animator = vm.behaviour.transform:Find("root"):GetComponent("Animator")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.RefreshView()
        TeamTowerMgr.Init()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveTimer(TimerConst.MiniBattleNewTimer)
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

this.RefreshView = function()
    local teamTowerdata = TeamTowerMgr.GetTeamTowerData()
    this.activityData = DataExHelper.GetDataExByTag(ActivityKey.TeamTower);
    if this.activityData == nil or not DataExHelper.CommonActivityCheck(ActivityKey.TeamTower) then
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("18344"))
        LuaMgr.HidePanel(UIName.TeamTowerMainViewModel);
        return
    end
    this.vm.data.firstFloor = IsNullOrEmpty(teamTowerdata.TowerId)
    this.vm.data.notFirstFloor = not IsNullOrEmpty(teamTowerdata.TowerId)
    
    this.vm.data.floor = string.format(LuaMgr.GetLangText("TeamTowerMainViewModel_0"),TeamTowerMgr.GetCurChallengeFloor());
    if teamTowerdata.Rank == 0 then
        this.vm.data.showRank = false
    else
        this.vm.data.showRank = true
        this.vm.data.rank = string.format(LuaMgr.GetLangText("TeamTowerMainViewModel_1"),tostring(teamTowerdata.Rank))
    end
    
    LuaMgr.RemoveTimer(TimerConst.MiniBattleNewTimer)
    LuaMgr.AddTimer(TimerConst.MiniBattleNewTimer, this.UpdateLeftTimer, 1, -1, true)
    HeroRedDataHelper.CheckTeamTowerRed()
end

this.UpdateLeftTimer = function()
    this.leftTime = this.activityData.expireTime - LuaMgr.Timestamp()
    local day = math.floor(this.leftTime/86400)
    local hour = math.fmod(math.floor(this.leftTime/3600),24)
    local minute = math.fmod(math.floor(this.leftTime/60), 60)
    this.vm.data.time = string.format(LuaMgr.GetLangText("TeamTowerMainViewModel_2"),day,hour)
end

this.OnBack = function()
    LuaMgr.Back();
end

return vm({
    data = data,
    command = command,
    hook = hook
})