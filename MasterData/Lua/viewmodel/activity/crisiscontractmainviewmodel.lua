local this = {
    vm = nil,
    data = {
        leftTime = 0,
    }
}

local data = {
    scoreNum_1 = DefaultSprite,
    scoreNum_2 = DefaultSprite,
    scoreNumActive_2 = false,
    leftTimeStr = "",
    animName = "",
    rewardRed = false,
}

local command = {
    taskBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.CrisisContractTaskPopup,this.UpdateRed);
        end
    },
    startBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.CrisisContractBuffViewModel);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        this.RefreshData()
        this.vm.data.animName = "ani_CrisisContractMainPanel_root_001"
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        LuaMgr.RemoveTimer(TimerConst.CrisisContractTimer)
        LuaMgr.RemoveTimer(TimerConst.CrisisContractScoreRefresh)
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.RefreshData = function()
    local lastScore = ActivityMgr.crisiscontractLastScore
    local newScore = DataMgr.Player.crisisContracts.maxScore
    if lastScore == nil then
        this.SetScore(newScore)
    else
        this.SetScore(lastScore)
    end
    this.SetLeftTime()
    this.UpdateRed()
end

this.UpdateRed = function()
    if this == nil then
        return
    end
    this.vm.data.rewardRed = HeroRedDataHelper.SetCrisisContract() > 0
end

this.SetScore = function(score)
    if score == nil then return end
    if score < 10 then
        this.vm.data.scoreNum_1 = ActivityMgr.GetCrisisContractNumSprite(score)
        this.vm.data.scoreNumActive_2 = false
    else
        local num_1 = math.floor(score / 10)
        local num_2 = score - num_1 * 10
        this.vm.data.scoreNum_1 = ActivityMgr.GetCrisisContractNumSprite(num_1)
        this.vm.data.scoreNum_2 = ActivityMgr.GetCrisisContractNumSprite(num_2)
        this.vm.data.scoreNumActive_2 = true
    end
    ActivityMgr.crisiscontractLastScore = score
end

this.OnAniPlayFinish = function(args)
    local lastScore = ActivityMgr.crisiscontractLastScore
    local newScore = DataMgr.Player.crisisContracts.maxScore
    if args[0] == "ani_CrisisContractMainPanel_root_001" and lastScore ~= nil and lastScore ~= newScore then
        this.vm.data.animName = "ani_CrisisContractMainPanel_root_002_score"
        LuaMgr.AddTimer(TimerConst.CrisisContractScoreRefresh, function()
            this.SetScore(newScore)
        end, 0.3, 1, false)
    end
end

this.SetLeftTime=function()
    local variables=DataExHelper.GetDataExByTag(ActivityKey.crisiscontract)
if variables == nil then
        LuaMgr.HidePanel(UIName.CrisisContractMainViewModel)
        return
    end 
    this.data.leftTime = variables.expireTime-LuaMgr.Timestamp();
    LuaMgr.AddTimer(TimerConst.CrisisContractTimer, this.UpdateLeftTimer, 1, -1, true)
end

this.UpdateLeftTimer=function()
    if this.data.leftTime <= 0 then
        LuaMgr.HidePanel(UIName.CrisisContractMainViewModel)
        return
    end
    
    local d, h, m, s = GetTimeDHMS(this.data.leftTime)
    local timeStr = ""
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
    else
        h, m, s=GetTimeHMS(this.data.leftTime)
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("2121"));
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
    end
    this.vm.data.leftTimeStr = timeStr
    this.data.leftTime = this.data.leftTime - 1
end

return vm({
    data = data,
    command = command,
    hook = hook
})