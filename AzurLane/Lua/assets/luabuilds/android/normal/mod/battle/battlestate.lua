ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1

if not var_0.Battle then
	var_0_1 = {}
end

var_0.Battle = var_0_1

local var_0_2 = {}

pg = var_0_10002
var_0_10002.bfConsts = var_0_2
var_0_2.DFT_CRIT_EFFECT = 1.5
var_0_2.DFT_CRIT_RATE = 0.05
var_0_2.SECONDs = 60
var_0_2.PERCENT = 0.01
var_0_2.PERCENT1 = 0.001
var_0_2.PERCENT2 = 0.0001
var_0_2.HUNDRED = 100
var_0_2.SCORE_RATE = {
	0.7,
	0.8,
	0.3
}
var_0_2.CRASH_RATE = {
	0.05,
	0.025
}
var_0_2.SUBMARINE_KAMIKAZE = {
	80,
	3.5,
	1.5,
	1,
	0.5,
	0.5,
	1,
	0.005
}
var_0_2.LEAK_RATE = {
	10,
	2.2,
	0.7,
	0.3,
	1,
	0.005,
	0.5
}
var_0_2.PLANE_LEAK_RATE = {
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
var_0_2.METEO_RATE = {
	0.05,
	20,
	0.6,
	0.4
}
var_0_2.NUM1 = 1
var_0_2.NUM0 = 0
var_0_2.NUM10000 = 10000
var_0_2.ACCURACY = {
	0.1,
	2
}
var_0_2.DRATE = {
	25,
	0.02,
	0.0002,
	2000,
	0.1,
	0.8,
	150
}
var_0_2.SPEED_CONST = 0.02
var_0_2.HP_CONST = 1.5
singletonClass = var_2

local var_0_3 = var_2("BattleState", var_0.MVC.Facade)

var_0.Battle.BattleState = var_0_3
var_0_3.__name = "BattleState"
var_0_3.BATTLE_STATE_IDLE = "BATTLE_IDLE"
var_0_3.BATTLE_STATE_OPENING = "BATTLE_OPENING"
var_0_3.BATTLE_STATE_FIGHT = "BATTLE_FIGHT"
var_0_3.BATTLE_STATE_REPORT = "BATTLE_REPORT"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)
	arg_1_0:ChangeState(var_0_3.BATTLE_STATE_IDLE)

	return
end

function var_0_3.GetCombatSkinKey()
	COMBAT_SKIN_KEY = var_1_10000
	var_1_10000 = var_1_10000 or "Standard"

	return var_1_10000
end

function var_0_3.IsAutoBotActive(arg_3_0)
	AutoBotCommand = var_1_10001

	local var_3_0 = var_1_10001.GetAutoBotMark(arg_3_0)

	PlayerPrefs = var_2

	local var_3_1

	if var_2.GetInt("autoBotIsAcitve" .. var_3_0, 0) == 1 then
		AutoBotCommand = var_2
		var_3_1 = var_2.autoBotSatisfied()
	else
		var_3_1 = false
	end

	if false then
		var_3_1 = true
	end

	return var_3_1
end

function var_0_3.IsAutoSubActive(arg_4_0)
	AutoSubCommand = var_1_10001

	local var_4_0 = var_1_10001.GetAutoSubMark(arg_4_0)

	PlayerPrefs = var_2

	return var_2.GetInt("autoSubIsAcitve" .. var_4_0, 0) == 1
end

function var_0_3.ChatUseable(arg_5_0)
	PlayerPrefs = var_1_10001

	local var_5_0 = var_1_10001.GetInt

	HIDE_CHAT_FLAG = var_1_10002

	local var_5_1 = not var_5_0(var_1_10002) or var_1 ~= 1
	local var_5_2 = arg_5_0:GetBattleType()
	local var_5_3 = arg_5_0.IsAutoBotActive(var_5_2)

	SYSTEM_DUEL = var_5

	local var_5_4 = var_5_2 == var_5

	SYSTEM_CARDPUZZLE = var_1_10006

	local var_5_5 = var_5_2 == var_1_10006

	return var_5_1 and (var_5_4 or var_5_3) and not var_5_5
end

function var_0_3.GetState(arg_6_0)
	return arg_6_0._state
end

function var_0_3.GetBattleType(arg_7_0)
	return arg_7_0._battleType
end

function var_0_3.SetBattleUI(arg_8_0, arg_8_1)
	arg_8_0._baseUI = arg_8_1

	return
end

function var_0_3.EnterBattle(arg_9_0, arg_9_1, arg_9_2)
	pg = var_1_10003

	local var_9_0 = var_1_10003.TimeMgr.GetInstance()

	var_3.ResetCombatTime(var_9_0)
	arg_9_0:Active()
	arg_9_0:ResetTimer()

	arg_9_0._dataProxy = arg_9_0:AddDataProxy(var_0.Battle.BattleDataProxy.GetInstance())
	arg_9_0._uiMediator = arg_9_0:AddMediator(var_0.Battle.BattleUIMediator.New())
	arg_9_0._battleType = arg_9_1.battleType

	local var_9_1

	if not var_0.Battle.BattleFacadeGate.CommandGates[arg_9_0._battleType] then
		var_9_1 = var_0.Battle.BattleSingleDungeonCommand
	end

	arg_9_0._battleCommand = arg_9_0:AddCommand(var_9_1.New())
	arg_9_0._sceneMediator = arg_9_0:AddMediator(var_0.Battle.BattleSceneMediator.New())
	arg_9_0._weaponCommand = arg_9_0:AddCommand(var_0.Battle.BattleControllerWeaponCommand.New())

	local var_9_2 = arg_9_0._dataProxy

	var_4.InitBattle(var_9_2, arg_9_1)

	BATTLE_DEFAULT_UNIT_DETAIL = var_4

	if var_4 then
		arg_9_0:AddMediator(var_0.Battle.BattleReferenceBoxMediator.New())

		local var_9_3 = arg_9_0:GetMediatorByName(var_0.Battle.BattleReferenceBoxMediator.__name)

		var_4.ActiveUnitDetail(var_9_3, true)
	end

	if arg_9_2 then
		-- block empty
	else
		arg_9_0:ChangeState(var_0_3.BATTLE_STATE_OPENING)

		UpdateBeat = var_4

		var_4:Add(arg_9_0.Update, arg_9_0)
	end

	return
end

function var_0_3.GetSceneMediator(arg_10_0)
	return arg_10_0._sceneMediator
end

function var_0_3.GetUIMediator(arg_11_0)
	return arg_11_0._uiMediator
end

function var_0_3.ActiveBot(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._weaponCommand

	var_2.ActiveBot(var_12_0, arg_12_1, true)
	arg_12_0:EnableJoystick(not arg_12_1)

	return
end

function var_0_3.EnableJoystick(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._uiMediator

	var_2.EnableJoystick(var_13_0, arg_13_1)

	return
end

function var_0_3.IsBotActive(arg_14_0)
	local var_14_0 = arg_14_0._weaponCommand
	local var_14_1 = var_1.GetWeaponBot(var_14_0)

	return var_1.IsActive(var_14_1)
end

function var_0_3.Update(arg_15_0)
	if not arg_15_0._isPause then
		pairs = var_1

		for iter_15_0, iter_15_1 in var_1(arg_15_0._mediatorList) do
			iter_15_1:Update()
		end
	else
		pairs = var_1

		for iter_15_2, iter_15_3 in var_1(arg_15_0._mediatorList) do
			iter_15_3:UpdatePause()
		end
	end

	return
end

function var_0_3.GenerateVertifyData(arg_16_0)
	return
end

function var_0_3.Vertify()
	return true, -1
end

function var_0_3.ChangeState(arg_18_0, arg_18_1)
	arg_18_0._state = arg_18_1

	if arg_18_1 == var_0_3.BATTLE_STATE_OPENING then
		local var_18_0 = arg_18_0._dataProxy

		var_2.Start(var_18_0)

		local var_18_1 = arg_18_0._dataProxy._dungeonInfo.beginStoy

		getProxy = var_18_0
		ChapterProxy = var_1_10004

		if var_18_0(var_1_10004) then
			::label_18_0::

			var_1_10005 = var_3
			var_1_10004 = var_3.GetContinuousData
			SYSTEM_SCENARIO = var_1_10006
			var_1_10004 = var_1_10004(var_1_10005, var_1_10006)
		end

		if var_18_1 then
			if var_1_10004 then
				pg = var_1_10005

				local var_18_2 = var_1_10005.NewStoryMgr.GetInstance()

				var_1_10005.ForceAutoPlay(var_18_2, var_18_1, function()
					local var_19_0 = arg_18_0._battleCommand

					var_0.DoPrologue(var_19_0)

					return
				end)
			else
				pg = var_1_10005

				local var_18_3 = var_1_10005.NewStoryMgr.GetInstance()

				var_5.Play(var_18_3, var_18_1, function()
					local var_20_0 = arg_18_0._battleCommand

					var_0.DoPrologue(var_20_0)

					return
				end)
			end
		else
			local var_18_4 = arg_18_0._battleCommand

			var_5.DoPrologue(var_18_4)
		end
	elseif arg_18_1 == var_0_3.BATTLE_STATE_FIGHT then
		arg_18_0:ActiveAutoComponentTimer()

		local var_18_5 = arg_18_0._dataProxy

		if not var_2.GetFleetLegal(var_18_5, var_0.Battle.BattleConfig.FRIENDLY_CODE, arg_18_0:GetBattleType()) then
			local var_18_6 = arg_18_0._battleCommand

			var_2.CalcStatistic(var_18_6)
			arg_18_0:BattleEnd()
		end
	elseif arg_18_1 == var_0_3.BATTLE_STATE_REPORT then
		-- block empty
	end

	return
end

function var_0_3.GetUI(arg_21_0)
	return arg_21_0._baseUI
end

function var_0_3.ConfigBattleEndFunc(arg_22_0, arg_22_1)
	arg_22_0._endFunc = arg_22_1

	return
end

function var_0_3.BattleEnd(arg_23_0)
	arg_23_0:disableCommon()

	local var_23_0 = arg_23_0._dataProxy

	if var_1.GetStatistics(var_23_0)._battleScore >= var_0.Battle.BattleConst.BattleScore.B then
		local var_23_1 = arg_23_0._dataProxy
		local var_23_2 = var_1.CelebrateVictory
		local var_23_3 = arg_23_0._dataProxy

		var_23_2(var_23_1, var_3.GetFriendlyCode(var_23_3))
		arg_23_0:reportDelayTimer(function()
			local var_24_0 = arg_23_0

			var_0.DoResult(var_24_0)

			return
		end, var_0.Battle.BattleConfig.CelebrateDuration)
	else
		arg_23_0:DoResult()
	end

	return
end

function var_0_3.BattleTimeUp(arg_25_0)
	arg_25_0:disableCommon()
	arg_25_0:ActiveEscape()
	arg_25_0:reportDelayTimer(function()
		local var_26_0 = arg_25_0

		var_0.DeactiveEscape(var_26_0)

		local var_26_1 = arg_25_0

		var_0.DoResult(var_26_1)

		return
	end, var_0.Battle.BattleConfig.EscapeDuration)

	return
end

function var_0_3.DoResult(arg_27_0)
	local var_27_0 = arg_27_0._sceneMediator

	var_1.PauseCharacterAction(var_27_0, true)

	local var_27_1 = arg_27_0._dataProxy
	local var_27_2 = var_1.BotPercentage
	local var_27_3 = arg_27_0._weaponCommand

	var_27_2(var_27_1, var_3.GetBotActiveDuration(var_27_3))

	local var_27_4 = arg_27_0._dataProxy

	var_1.HPRatioStatistics(var_27_4)

	local var_27_5 = arg_27_0._endFunc
	local var_27_6 = arg_27_0._dataProxy

	var_27_5(var_2.GetStatistics(var_27_6))

	return
end

function var_0_3.ExitBattle(arg_28_0)
	local var_28_0 = var_0.Battle.BattleCameraUtil.GetInstance()

	var_1.Clear(var_28_0)

	pairs = var_1

	for iter_28_0, iter_28_1 in var_1(arg_28_0._mediatorList) do
		arg_28_0:RemoveMediator(iter_28_1)
	end

	pairs = var_1

	for iter_28_2, iter_28_3 in var_1(arg_28_0._commandList) do
		arg_28_0:RemoveCommand(iter_28_3)
	end

	pairs = var_1

	for iter_28_4, iter_28_5 in var_1(arg_28_0._proxyList) do
		arg_28_0:RemoveProxy(iter_28_5)
	end

	var_0.Battle.BattleConfig.BASIC_TIME_SCALE = 1

	arg_28_0:RemoveAllTimer()

	local var_28_1 = var_0.Battle.BattleResourceManager.GetInstance()

	var_1.Clear(var_28_1)

	arg_28_0._takeoverProcess = nil

	arg_28_0:ChangeState(var_0_3.BATTLE_STATE_IDLE)

	arg_28_0._baseUI = nil
	arg_28_0._endFunc = nil
	arg_28_0._uiMediator = nil
	arg_28_0._sceneMediator = nil
	arg_28_0._battleCommand = nil
	arg_28_0._weaponCommand = nil
	removeSingletonInstance = var_1

	var_1(var_0.Battle.BattleDataProxy)

	arg_28_0._dataProxy = nil

	var_0.Battle.BattleVariable.Clear()
	var_0.Battle.BattleBulletFactory.DestroyFactory()

	UpdateBeat = var_1

	var_1:Remove(arg_28_0.Update, arg_28_0)

	pg = var_1

	local var_28_2 = var_1.EffectMgr.GetInstance()

	var_1.ClearBattleEffectMap(var_28_2)

	arg_28_0._timeScale = nil
	arg_28_0._timescalerCache = nil
	gcAll = var_1

	var_1(true)

	return
end

function var_0_3.Stop(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0
	local var_29_1 = arg_29_0.GetBattleType(var_29_0)

	SYSTEM_TEST = var_29_0

	if var_29_1 == var_29_0 then
		local var_29_2

		pg = InDebugBattleLoop

		local var_29_3 = var_2.TipsMgr.GetInstance()

		var_2.ShowTips(var_29_3, "interrupt")
	end

	arg_29_0:disableCommon()

	local var_29_4 = arg_29_0._baseUI

	var_2.exitBattle(var_29_4, arg_29_1)

	return
end

function var_0_3.disableCommon(arg_30_0)
	local var_30_0 = arg_30_0._weaponCommand

	var_1.ActiveBot(var_30_0, false)
	arg_30_0:ScaleTimer()

	local var_30_1 = var_0.Battle.BattleCameraUtil.GetInstance()

	var_1.ResetFocus(var_30_1)
	arg_30_0:ChangeState(var_0_3.BATTLE_STATE_REPORT)

	local var_30_2 = arg_30_0._dataProxy

	var_1.ClearAirFighterTimer(var_30_2)

	local var_30_3 = arg_30_0._dataProxy

	var_1.KillAllAircraft(var_30_3)

	local var_30_4 = arg_30_0._sceneMediator

	var_1.AllBulletNeutralize(var_30_4)

	local var_30_5 = var_0.Battle.BattleCameraUtil.GetInstance()

	var_1.StopShake(var_30_5)

	local var_30_6 = var_0.Battle.BattleCameraUtil.GetInstance()

	var_1.Deactive(var_30_6)

	local var_30_7 = arg_30_0._uiMediator

	var_1.DisableComponent(var_30_7)
	arg_30_0:Deactive()

	return
end

function var_0_3.reportDelayTimer(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0

	local function var_31_1()
		pg = var_2_10000

		local var_32_0 = var_2_10000.TimeMgr.GetInstance()

		var_0.RemoveBattleTimer(var_32_0, var_31_0)

		var_31_0 = nil

		arg_31_1()

		return
	end

	arg_31_0:RemoveAllTimer()

	pg = var_5

	local var_31_2 = var_5.TimeMgr.GetInstance()

	var_5.ResumeBattleTimer(var_31_2)

	pg = var_5

	local var_31_3 = var_5.TimeMgr.GetInstance()

	var_31_0 = var_5.AddBattleTimer(var_31_3, "reportDelay", -1, arg_31_2, var_31_1)

	return
end

function var_0_3.SetTakeoverProcess(arg_33_0, arg_33_1)
	assert = var_1_10002

	var_1_10002(arg_33_0._takeoverProcess == nil, "已经有接管的战斗过程，暂时没有定义这种逻辑")

	assert = var_1_10002

	if arg_33_1.Pause ~= nil then
		type = var_3

		local var_33_0

		if var_3(arg_33_1.Pause) ~= "function" then
			var_33_0 = false
		else
			var_33_0 = true
		end

		var_1_10002(var_33_0, "SetTakeoverProcess附加过程，必须要有Pause函数")

		assert = var_1_10002

		if arg_33_1.Pause ~= nil then
			type = var_3

			local var_33_1

			if var_3(arg_33_1.Resume) ~= "function" then
				var_33_1 = false
			else
				var_33_1 = true
			end

			var_1_10002(var_33_1, "SetTakeoverProcess附加过程，必须要有Pause函数")

			arg_33_0._takeoverProcess = arg_33_1

			arg_33_0:_pause()

			return
		end
	end
end

function var_0_3.ClearTakeoverProcess(arg_34_0)
	assert = var_1_10001

	var_1_10001(arg_34_0._takeoverProcess, "没有接管的战斗过程，暂时没有定义这种逻辑")

	arg_34_0._takeoverProcess = nil

	arg_34_0:_resume()

	return
end

function var_0_3.IsPause(arg_35_0)
	return arg_35_0._isPause
end

function var_0_3.Pause(arg_36_0)
	if arg_36_0._takeoverProcess then
		var_1.Pause()
	else
		arg_36_0:_pause()
	end

	return
end

function var_0_3._pause(arg_37_0)
	arg_37_0:Deactive()

	local var_37_0 = arg_37_0._dataProxy

	var_1.PausePuzzleComponent(var_37_0)

	local var_37_1 = arg_37_0._sceneMediator

	var_1.Pause(var_37_1)

	if arg_37_0._timeScale ~= 1 then
		arg_37_0:CacheTimescaler(arg_37_0._timeScale)
		arg_37_0:ScaleTimer(1)
	end

	local var_37_2 = var_0.Battle.BattleCameraUtil.GetInstance()

	var_1.PauseCameraTween(var_37_2)

	return
end

function var_0_3.Resume(arg_38_0)
	if arg_38_0._state == var_0_3.BATTLE_STATE_IDLE then
		arg_38_0:ChangeState(var_0_3.BATTLE_STATE_OPENING)

		UpdateBeat = var_1

		var_1:Add(arg_38_0.Update, arg_38_0)
	elseif arg_38_0._state == var_0_3.BATTLE_STATE_REPORT then
		return
	end

	if arg_38_0._takeoverProcess then
		var_1.Resume()
	else
		arg_38_0:_resume()
	end

	return
end

function var_0_3._resume(arg_39_0)
	local var_39_0 = arg_39_0._sceneMediator

	var_1.Resume(var_39_0)
	arg_39_0:Active()

	local var_39_1 = arg_39_0._dataProxy

	var_1.ResumePuzzleComponent(var_39_1)

	if arg_39_0._timescalerCache then
		arg_39_0:ScaleTimer(arg_39_0._timescalerCache)
		arg_39_0:CacheTimescaler()
	end

	local var_39_2 = var_0.Battle.BattleCameraUtil.GetInstance()

	var_1.ResumeCameraTween(var_39_2)

	return
end

function var_0_3.ScaleTimer(arg_40_0, arg_40_1)
	arg_40_1 = arg_40_1 or var_0.Battle.BattleConfig.BASIC_TIME_SCALE
	pg = var_1_10002

	local var_40_0 = var_1_10002.TimeMgr.GetInstance()

	var_2.ScaleBattleTimer(var_40_0, arg_40_1)

	arg_40_0._timeScale = arg_40_1

	return
end

function var_0_3.GetTimeScaleRate(arg_41_0)
	local var_41_0

	if not arg_41_0._timeScale then
		var_41_0 = 1
	end

	return var_41_0
end

function var_0_3.CacheTimescaler(arg_42_0, arg_42_1)
	arg_42_0._timescalerCache = arg_42_1

	return
end

function var_0.Battle.PlayBattleSFX(arg_43_0)
	if arg_43_0 ~= "" then
		pg = var_1_10001

		local var_43_0 = var_1_10001.CriMgr.GetInstance()

		var_1.PlaySoundEffect_V3(var_43_0, "event:/" .. arg_43_0)
	end

	return
end

function var_0_3.OpenConsole(arg_44_0)
	local var_44_0 = arg_44_0._uiMediator

	var_1.InitDebugConsole(var_44_0)

	local var_44_1 = arg_44_0._uiMediator

	var_1.ActiveDebugConsole(var_44_1)

	return
end

function var_0_3.ActiveReference(arg_45_0)
	arg_45_0._controllerCommand = arg_45_0:AddCommand(var_0.Battle.BattleControllerCommand.New())

	return
end

return
