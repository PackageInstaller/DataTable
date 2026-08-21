ys = ys or {}

local var_0_0 = ys

ys.Battle = ys.Battle or {}
pg.bfConsts = {}
;({}).DFT_CRIT_EFFECT = 1.5
;({}).DFT_CRIT_RATE = 0.05
;({}).SECONDs = 60
;({}).PERCENT = 0.01
;({}).PERCENT1 = 0.001
;({}).PERCENT2 = 0.0001
;({}).HUNDRED = 100
;({}).SCORE_RATE = {
	0.7,
	0.8,
	0.3
}
;({}).CRASH_RATE = {
	0.05,
	0.025
}
;({}).SUBMARINE_KAMIKAZE = {
	80,
	3.5,
	1.5,
	1,
	0.5,
	0.5,
	1,
	0.005
}
;({}).LEAK_RATE = {
	10,
	2.2,
	0.7,
	0.3,
	1,
	0.005,
	0.5
}
;({}).PLANE_LEAK_RATE = {
	1,
	1,
	0.01,
	0.5,
	0.7,
	0.3,
	1,
	0.005,
	150,
	150,
	1,
	1
}
;({}).METEO_RATE = {
	0.05,
	20,
	0.6,
	0.4
}
;({}).NUM1 = 1
;({}).NUM0 = 0
;({}).NUM10000 = 10000
;({}).ACCURACY = {
	0.1,
	2
}
;({}).DRATE = {
	25,
	0.02,
	0.0002,
	2000,
	0.1,
	0.8,
	150
}
;({}).SPEED_CONST = 0.02
;({}).HP_CONST = 1.5

local var_0_1 = singletonClass("BattleState", ys.MVC.Facade)

ys.Battle.BattleState = var_0_1
var_0_1.__name = "BattleState"
var_0_1.BATTLE_STATE_IDLE = "BATTLE_IDLE"
var_0_1.BATTLE_STATE_OPENING = "BATTLE_OPENING"
var_0_1.BATTLE_STATE_FIGHT = "BATTLE_FIGHT"
var_0_1.BATTLE_STATE_REPORT = "BATTLE_REPORT"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)
	arg_1_0:ChangeState(var_0_1.BATTLE_STATE_IDLE)

	return
end

function var_0_1.GetCombatSkinKey()
	return COMBAT_SKIN_KEY or "Standard"
end

function var_0_1.IsAutoBotActive(arg_3_0)
	return PlayerPrefs.GetInt("autoBotIsAcitve" .. AutoBotCommand.GetAutoBotMark(arg_3_0), 0) == 1 and AutoBotCommand.autoBotSatisfied()
end

function var_0_1.IsAutoSubActive(arg_4_0)
	return PlayerPrefs.GetInt("autoSubIsAcitve" .. AutoSubCommand.GetAutoSubMark(arg_4_0), 0) == 1
end

function var_0_1.ChatUseable(arg_5_0)
	local var_5_0 = PlayerPrefs.GetInt(HIDE_CHAT_FLAG)
	local var_5_1 = arg_5_0:GetBattleType()
	local var_5_2 = arg_5_0.IsAutoBotActive(var_5_1)
	local var_5_3 = var_5_1 == SYSTEM_DUEL
	local var_5_4 = var_5_1 == SYSTEM_CARDPUZZLE

	return (not var_5_0 or var_5_0 ~= 1) and (var_5_3 or var_5_2) and not var_5_4
end

function var_0_1.GetState(arg_6_0)
	return arg_6_0._state
end

function var_0_1.GetBattleType(arg_7_0)
	return arg_7_0._battleType
end

function var_0_1.SetBattleUI(arg_8_0, arg_8_1)
	arg_8_0._baseUI = arg_8_1

	return
end

function var_0_1.EnterBattle(arg_9_0, arg_9_1, arg_9_2)
	pg.TimeMgr.GetInstance():ResetCombatTime()
	arg_9_0:Active()
	arg_9_0:ResetTimer()

	arg_9_0._dataProxy = arg_9_0:AddDataProxy(var_0_0.Battle.BattleDataProxy.GetInstance())
	arg_9_0._uiMediator = arg_9_0:AddMediator(var_0_0.Battle.BattleUIMediator.New())
	arg_9_0._battleType = arg_9_1.battleType
	arg_9_0._battleCommand = arg_9_0:AddCommand(var_9_0.New())
	arg_9_0._sceneMediator = arg_9_0:AddMediator(var_0_0.Battle.BattleSceneMediator.New())
	arg_9_0._weaponCommand = arg_9_0:AddCommand(var_0_0.Battle.BattleControllerWeaponCommand.New())

	arg_9_0._dataProxy:InitBattle(arg_9_1)

	if BATTLE_DEFAULT_UNIT_DETAIL then
		arg_9_0:AddMediator(var_0_0.Battle.BattleReferenceBoxMediator.New())
		arg_9_0:GetMediatorByName(var_0_0.Battle.BattleReferenceBoxMediator.__name):ActiveUnitDetail(true)
	end

	if arg_9_2 then
		-- block empty
	else
		arg_9_0:ChangeState(var_0_1.BATTLE_STATE_OPENING)
		UpdateBeat:Add(arg_9_0.Update, arg_9_0)
	end

	return
end

function var_0_1.GetSceneMediator(arg_10_0)
	return arg_10_0._sceneMediator
end

function var_0_1.GetUIMediator(arg_11_0)
	return arg_11_0._uiMediator
end

function var_0_1.ActiveBot(arg_12_0, arg_12_1)
	arg_12_0._weaponCommand:ActiveBot(arg_12_1, true)
	arg_12_0:EnableJoystick(not arg_12_1)

	return
end

function var_0_1.EnableJoystick(arg_13_0, arg_13_1)
	arg_13_0._uiMediator:EnableJoystick(arg_13_1)

	return
end

function var_0_1.IsBotActive(arg_14_0)
	return arg_14_0._weaponCommand:GetWeaponBot():IsActive()
end

function var_0_1.Update(arg_15_0)
	if not arg_15_0._isPause then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._mediatorList) do
			iter_15_1:Update()
		end
	else
		for iter_15_2, iter_15_3 in pairs(arg_15_0._mediatorList) do
			iter_15_3:UpdatePause()
		end
	end

	return
end

function var_0_1.GenerateVertifyData(arg_16_0)
	return
end

function var_0_1.Vertify()
	return true, -1
end

function var_0_1.ChangeState(arg_18_0, arg_18_1)
	arg_18_0._state = arg_18_1

	if arg_18_1 == var_0_1.BATTLE_STATE_OPENING then
		arg_18_0._dataProxy:Start()

		local var_18_0 = getProxy(ChapterProxy)
		local var_18_1 = var_18_0 and var_18_0:GetContinuousData(SYSTEM_SCENARIO)

		if arg_18_0._dataProxy._dungeonInfo.beginStoy then
			if var_18_1 then
				pg.NewStoryMgr.GetInstance():ForceAutoPlay(arg_18_0._dataProxy._dungeonInfo.beginStoy, function()
					arg_18_0._battleCommand:DoPrologue()

					return
				end)
			else
				pg.NewStoryMgr.GetInstance():Play(arg_18_0._dataProxy._dungeonInfo.beginStoy, function()
					arg_18_0._battleCommand:DoPrologue()

					return
				end)
			end
		else
			arg_18_0._battleCommand:DoPrologue()
		end
	elseif arg_18_1 == var_0_1.BATTLE_STATE_FIGHT then
		arg_18_0:ActiveAutoComponentTimer()

		if not arg_18_0._dataProxy:GetFleetLegal(var_0_0.Battle.BattleConfig.FRIENDLY_CODE, arg_18_0:GetBattleType()) then
			arg_18_0._battleCommand:CalcStatistic()
			arg_18_0:BattleEnd()
		end
	elseif arg_18_1 == var_0_1.BATTLE_STATE_REPORT then
		-- block empty
	end

	return
end

function var_0_1.GetUI(arg_21_0)
	return arg_21_0._baseUI
end

function var_0_1.ConfigBattleEndFunc(arg_22_0, arg_22_1)
	arg_22_0._endFunc = arg_22_1

	return
end

function var_0_1.BattleEnd(arg_23_0)
	arg_23_0:disableCommon()

	if arg_23_0._dataProxy:GetStatistics()._battleScore >= var_0_0.Battle.BattleConst.BattleScore.B then
		arg_23_0._dataProxy:CelebrateVictory(arg_23_0._dataProxy:GetFriendlyCode())
		arg_23_0:reportDelayTimer(function()
			arg_23_0:DoResult()

			return
		end, var_0_0.Battle.BattleConfig.CelebrateDuration)
	else
		arg_23_0:DoResult()
	end

	return
end

function var_0_1.BattleTimeUp(arg_25_0)
	arg_25_0:disableCommon()
	arg_25_0:ActiveEscape()
	arg_25_0:reportDelayTimer(function()
		arg_25_0:DeactiveEscape()
		arg_25_0:DoResult()

		return
	end, var_0_0.Battle.BattleConfig.EscapeDuration)

	return
end

function var_0_1.DoResult(arg_27_0)
	arg_27_0._sceneMediator:PauseCharacterAction(true)
	arg_27_0._dataProxy:BotPercentage(arg_27_0._weaponCommand:GetBotActiveDuration())
	arg_27_0._dataProxy:HPRatioStatistics()
	arg_27_0._endFunc(arg_27_0._dataProxy:GetStatistics())

	return
end

function var_0_1.ExitBattle(arg_28_0)
	var_0_0.Battle.BattleCameraUtil.GetInstance():Clear()

	for iter_28_0, iter_28_1 in pairs(arg_28_0._mediatorList) do
		arg_28_0:RemoveMediator(iter_28_1)
	end

	for iter_28_2, iter_28_3 in pairs(arg_28_0._commandList) do
		arg_28_0:RemoveCommand(iter_28_3)
	end

	for iter_28_4, iter_28_5 in pairs(arg_28_0._proxyList) do
		arg_28_0:RemoveProxy(iter_28_5)
	end

	var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE = 1

	arg_28_0:RemoveAllTimer()
	var_0_0.Battle.BattleResourceManager.GetInstance():Clear()

	arg_28_0._takeoverProcess = nil

	arg_28_0:ChangeState(var_0_1.BATTLE_STATE_IDLE)

	arg_28_0._baseUI = nil
	arg_28_0._endFunc = nil
	arg_28_0._uiMediator = nil
	arg_28_0._sceneMediator = nil
	arg_28_0._battleCommand = nil
	arg_28_0._weaponCommand = nil

	removeSingletonInstance(var_0_0.Battle.BattleDataProxy)

	arg_28_0._dataProxy = nil

	var_0_0.Battle.BattleVariable.Clear()
	var_0_0.Battle.BattleBulletFactory.DestroyFactory()
	UpdateBeat:Remove(arg_28_0.Update, arg_28_0)
	pg.EffectMgr.GetInstance():ClearBattleEffectMap()

	arg_28_0._timeScale = nil
	arg_28_0._timescalerCache = nil

	gcAll(true)

	return
end

function var_0_1.Stop(arg_29_0, arg_29_1)
	if arg_29_0:GetBattleType() == SYSTEM_TEST then
		InDebugBattleLoop = nil

		pg.TipsMgr.GetInstance():ShowTips("interrupt")
	end

	arg_29_0:disableCommon()
	arg_29_0._baseUI:exitBattle(arg_29_1)

	return
end

function var_0_1.disableCommon(arg_30_0)
	arg_30_0._weaponCommand:ActiveBot(false)
	arg_30_0:ScaleTimer()
	var_0_0.Battle.BattleCameraUtil.GetInstance():ResetFocus()
	arg_30_0:ChangeState(var_0_1.BATTLE_STATE_REPORT)
	arg_30_0._dataProxy:ClearAirFighterTimer()
	arg_30_0._dataProxy:KillAllAircraft()
	arg_30_0._sceneMediator:AllBulletNeutralize()
	var_0_0.Battle.BattleCameraUtil.GetInstance():StopShake()
	var_0_0.Battle.BattleCameraUtil.GetInstance():Deactive()
	arg_30_0._uiMediator:DisableComponent()
	arg_30_0:Deactive()

	return
end

function var_0_1.reportDelayTimer(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0

	arg_31_0:RemoveAllTimer()
	pg.TimeMgr.GetInstance():ResumeBattleTimer()

	var_31_0 = pg.TimeMgr.GetInstance():AddBattleTimer("reportDelay", -1, arg_31_2, function()
		pg.TimeMgr.GetInstance():RemoveBattleTimer(var_31_0)

		var_31_0 = nil

		arg_31_1()

		return
	end)

	return
end

function var_0_1.SetTakeoverProcess(arg_33_0, arg_33_1)
	assert(arg_33_0._takeoverProcess == nil, "已经有接管的战斗过程，暂时没有定义这种逻辑")
	assert(arg_33_1.Pause ~= nil and type(arg_33_1.Pause) == "function", "SetTakeoverProcess附加过程，必须要有Pause函数")
	assert(arg_33_1.Pause ~= nil and type(arg_33_1.Resume) == "function", "SetTakeoverProcess附加过程，必须要有Pause函数")

	arg_33_0._takeoverProcess = arg_33_1

	arg_33_0:_pause()

	return
end

function var_0_1.ClearTakeoverProcess(arg_34_0)
	assert(arg_34_0._takeoverProcess, "没有接管的战斗过程，暂时没有定义这种逻辑")

	arg_34_0._takeoverProcess = nil

	arg_34_0:_resume()

	return
end

function var_0_1.IsPause(arg_35_0)
	return arg_35_0._isPause
end

function var_0_1.Pause(arg_36_0)
	if arg_36_0._takeoverProcess then
		arg_36_0._takeoverProcess.Pause()
	else
		arg_36_0:_pause()
	end

	return
end

function var_0_1._pause(arg_37_0)
	arg_37_0:Deactive()
	arg_37_0._dataProxy:PausePuzzleComponent()
	arg_37_0._sceneMediator:Pause()

	if arg_37_0._timeScale ~= 1 then
		arg_37_0:CacheTimescaler(arg_37_0._timeScale)
		arg_37_0:ScaleTimer(1)
	end

	var_0_0.Battle.BattleCameraUtil.GetInstance():PauseCameraTween()

	return
end

function var_0_1.Resume(arg_38_0)
	if arg_38_0._state == var_0_1.BATTLE_STATE_IDLE then
		arg_38_0:ChangeState(var_0_1.BATTLE_STATE_OPENING)
		UpdateBeat:Add(arg_38_0.Update, arg_38_0)
	elseif arg_38_0._state == var_0_1.BATTLE_STATE_REPORT then
		return
	end

	if arg_38_0._takeoverProcess then
		var_38_0.Resume()
	else
		arg_38_0:_resume()
	end

	return
end

function var_0_1._resume(arg_39_0)
	arg_39_0._sceneMediator:Resume()
	arg_39_0:Active()
	arg_39_0._dataProxy:ResumePuzzleComponent()

	if arg_39_0._timescalerCache then
		arg_39_0:ScaleTimer(arg_39_0._timescalerCache)
		arg_39_0:CacheTimescaler()
	end

	var_0_0.Battle.BattleCameraUtil.GetInstance():ResumeCameraTween()

	return
end

function var_0_1.ScaleTimer(arg_40_0, arg_40_1)
	arg_40_1 = arg_40_1 or var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE

	pg.TimeMgr.GetInstance():ScaleBattleTimer(arg_40_1)

	arg_40_0._timeScale = arg_40_1

	return
end

function var_0_1.GetTimeScaleRate(arg_41_0)
	return arg_41_0._timeScale or 1
end

function var_0_1.CacheTimescaler(arg_42_0, arg_42_1)
	arg_42_0._timescalerCache = arg_42_1

	return
end

function ys.Battle.PlayBattleSFX(arg_43_0)
	if arg_43_0 ~= "" then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/" .. arg_43_0)
	end

	return
end

function var_0_1.OpenConsole(arg_44_0)
	arg_44_0._uiMediator:InitDebugConsole()
	arg_44_0._uiMediator:ActiveDebugConsole()

	return
end

function var_0_1.ActiveReference(arg_45_0)
	arg_45_0._controllerCommand = arg_45_0:AddCommand(var_0_0.Battle.BattleControllerCommand.New())

	return
end

return
