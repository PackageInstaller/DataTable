require("ViewModel/MiniBattle/MiniBattleMgr")

local this = {
    vm=nil,
    battleCfg_1 = nil,
    battleCfg_2 = nil,
    activityData = nil,
    chooseIndex = 0,
};

local data = {
    curScore = "",
    DungeonName_1 = "",
    DungeonScore_1 = "",
    DungeonAllScore_1 = "",
    DungeonName_2 = "",
    DungeonScore_2 = "",
    DungeonAllScore_2 = "",
    leftTimeStr = "",
    isShowGetScorePopup = false,
    getScoreStr = "",
    isShowNoScorePopup = false,
}

local command = {
    dungeonItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index = tonumber(param)
            local battleCfg = nil
            if index == 1 then
                battleCfg = this.battleCfg_1
            elseif index == 2 then
                battleCfg = this.battleCfg_2
            end
            ActivityBattlePrepareMgr.SetMembers(battleCfg.ID)
            local curDungeonScore = MiniBattleMgr.GetDungeonScore(battleCfg.DungeonId)
            local totalDungeonScore = battleCfg.CreditLimit
            if curDungeonScore >= totalDungeonScore then
                this.chooseIndex = index
                this.vm.data.isShowNoScorePopup = true
            else
                LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.MiniBattle, index)
            end
        end
    },

    rewardBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.MiniBattleRewardPopupViewModel);
        end
    },
    
    GetScorePopupMaskCommand = {
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.isShowGetScorePopup = false
        end
    },

    NoScorePopupMaskCommand = {
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.isShowNoScorePopup = false
        end
    },

    NoScorePopupConfirmCommand = {
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.MiniBattle, this.chooseIndex)
            this.vm.data.isShowNoScorePopup = false
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm=vm
        RedMgr.Singleton:RegisterViewModel(UIName.MiniBattleViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.Init()
        this.Refresh()
        this.CheckScore()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    before_destroy=function(vm)
        this = nil;
    end
}

this.Init = function()
    this.battleCfg_1 = MiniBattleMgr.GetCurMiniBattleCfg(1)
    this.battleCfg_2 = MiniBattleMgr.GetCurMiniBattleCfg(2)
end

this.Refresh = function()
    this.activityData=DataExHelper.GetDataExByTag(ActivityKey.MiniBattle);
    if this.activityData == nil or not DataExHelper.CommonActivityCheck(ActivityKey.MiniBattle) then
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("18344"))
        LuaMgr.HidePanel(UIName.MiniBattleViewModel);
        return
    end

    this.vm.data.curScore = MiniBattleMgr.GetTotalScore()
    this.vm.data.DungeonName_1 = LuaMgr.GetLangText(this.battleCfg_1.NameLan)
    this.vm.data.DungeonScore_1 = MiniBattleMgr.GetDungeonScore(this.battleCfg_1.DungeonId)
    this.vm.data.DungeonAllScore_1 = string.format("/%d", this.battleCfg_1.CreditLimit)
    this.vm.data.DungeonName_2 = LuaMgr.GetLangText(this.battleCfg_2.NameLan)
    this.vm.data.DungeonScore_2 = MiniBattleMgr.GetDungeonScore(this.battleCfg_2.DungeonId)
    this.vm.data.DungeonAllScore_2 = string.format("/%d", this.battleCfg_2.CreditLimit)
    local dataStr = os.date(LuaMgr.GetLangText("MiniBattleViewModel_0"), this.activityData.expireTime)
    this.vm.data.leftTimeStr = dataStr
    
    local status = ActivityMgr.ActivityCanFinish(ActivityKey.MiniBattle);
    RedMgr.Singleton:UpdateClientRedData("16420", status and 1 or 0);
end

this.CheckScore = function()
    this.vm.data.isShowGetScorePopup = false
    if MiniBattleMgr.recordedScore == -1 then
        return
    end
    
    local changedScore = MiniBattleMgr.GetTotalScore() - MiniBattleMgr.recordedScore
    if changedScore > 0 then
        this.vm.data.getScoreStr = tostring(changedScore)
        this.vm.data.isShowGetScorePopup = true
    end
    
    MiniBattleMgr.recordedScore = -1
end

this.OnBack = function()
    if this.vm.data.isShowGetScorePopup then
        this.vm.data.isShowGetScorePopup = false
    elseif this.vm.data.isShowNoScorePopup then
        this.vm.data.isShowNoScorePopup = false
    else
        LuaMgr.Back();
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})