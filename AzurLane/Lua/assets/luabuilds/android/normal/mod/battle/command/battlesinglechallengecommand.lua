ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent
local var_0_3 = var_0.Battle.BattleDataFunction

class = var_0_10004

local var_0_4 = var_0_10004("BattleSingleChallengeCommand", var_0.Battle.BattleSingleDungeonCommand)

var_0.Battle.BattleSingleChallengeCommand = var_0_4
var_0_4.__name = "BattleSingleChallengeCommand"

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	arg_1_0._challengeConst = var_0.Battle.BattleConfig.CHALLENGE_ENHANCE

	return
end

function var_0_4.onInitBattle(arg_2_0)
	var_0_4.super.onInitBattle(arg_2_0)

	local var_2_0 = arg_2_0._dataProxy
	local var_2_1 = var_1.GetInitData(var_2_0).ChallengeInfo
	local var_2_2 = var_1.getRound(var_2_1)

	math = var_2_1
	arg_2_0._enhancemntP = var_2_1.max(var_2_2 - arg_2_0._challengeConst.K, 0)
	arg_2_0._enhancemntPPercent = arg_2_0._enhancemntP * 0.01

	local var_2_3 = arg_2_0._challengeConst.A * arg_2_0._enhancemntP
	local var_2_4 = arg_2_0._dataProxy
	local var_2_5 = var_3.GetDungeonLevel(var_2_4)
	local var_2_6 = arg_2_0._dataProxy

	var_4.SetDungeonLevel(var_2_6, var_2_5 + var_2_3)

	arg_2_0._enahanceDURAttr = arg_2_0._challengeConst.X1 * arg_2_0._enhancemntPPercent
	arg_2_0._enahanceATKAttr = arg_2_0._challengeConst.X2 * arg_2_0._enhancemntPPercent
	arg_2_0._enahanceEVDAttr = arg_2_0._challengeConst.Y1 * arg_2_0._enhancemntP
	arg_2_0._enahanceLUKAttr = arg_2_0._challengeConst.Y2 * arg_2_0._enhancemntP

	return
end

function var_0_4.initWaveModule(arg_3_0)
	local function var_3_0(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_3_0._dataProxy
		local var_4_1 = var_3.SpawnMonster(var_4_0, arg_4_0, arg_4_1, arg_4_2, var_0.Battle.BattleConfig.FOE_CODE, function(arg_5_0)
			local var_5_0 = arg_3_0

			var_1.monsterEnhance(var_5_0, arg_5_0)

			return
		end)

		return
	end

	local function var_3_1(arg_6_0)
		local var_6_0 = arg_3_0._dataProxy

		var_1.SpawnAirFighter(var_6_0, arg_6_0)

		return
	end

	local function var_3_2()
		if arg_3_0._vertifyFail then
			pg = var_0

			local var_7_0 = var_0.m02
			local var_7_1 = var_0.sendNotification

			GAME = var_2_10002

			var_7_1(var_7_0, var_2_10002.CHEATER_MARK, {
				reason = arg_3_0._vertifyFail
			})

			return
		end

		local var_7_2 = arg_3_0._dataProxy

		var_0.TriggerFinishBattle(var_7_2)

		local var_7_3 = arg_3_0._dataProxy

		var_0.CalcChallengeScore(var_7_3, true)

		local var_7_4 = arg_3_0._state

		var_0.BattleEnd(var_7_4)

		return
	end

	local function var_3_3(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		local var_8_0 = arg_3_0._dataProxy

		var_5.SpawnCubeArea(var_8_0, var_0.Battle.BattleConst.AOEField.SURFACE, -1, arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)

		return
	end

	arg_3_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(var_3_0, var_3_1, var_3_2, var_3_3)

	return
end

function var_0_4.DoPrologue(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.Marching(var_9_0)

	local function var_9_1()
		local var_10_0 = arg_9_0._uiMediator

		var_0.OpeningEffect(var_10_0, function()
			getProxy = var_3_10000
			PlayerProxy = var_3_10001

			local var_11_0 = var_3_10000(var_3_10001)
			local var_11_1 = arg_9_0._uiMediator

			var_1.ShowAutoBtn(var_11_1)

			local var_11_2 = arg_9_0._state

			var_1.ChangeState(var_11_2, var_0.Battle.BattleState.BATTLE_STATE_FIGHT)

			local var_11_3 = arg_9_0._uiMediator

			var_1.ShowTimer(var_11_3)

			local var_11_4 = arg_9_0._state
			local var_11_5 = var_1.GetCommandByName(var_11_4, var_0.Battle.BattleControllerWeaponCommand.__name)

			var_1.TryAutoSub(var_11_5)

			local var_11_6 = arg_9_0._waveUpdater

			var_2.Start(var_11_6)

			return
		end)

		local var_10_1 = arg_9_0._dataProxy
		local var_10_2 = var_0.GetFleetByIFF(var_10_1, var_0.Battle.BattleConfig.FRIENDLY_CODE)

		var_0.FleetWarcry(var_10_2)

		local var_10_3 = arg_9_0._dataProxy

		var_1.InitAllFleetUnitsWeaponCD(var_10_3)

		local var_10_4 = arg_9_0._dataProxy

		var_1.TirggerBattleStartBuffs(var_10_4)

		local var_10_5 = arg_9_0

		pg = var_10_4

		local var_10_6 = var_10_4.TimeMgr.GetInstance()

		var_10_5._challengeStartTime = var_2.GetCombatTime(var_10_6)

		return
	end

	local var_9_2 = arg_9_0._uiMediator

	var_2.SeaSurfaceShift(var_9_2, 45, 0, nil, var_9_1)

	return
end

function var_0_4.onPlayerShutDown(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._state

	if var_2.GetState(var_12_0) ~= arg_12_0._state.BATTLE_STATE_FIGHT then
		return
	end

	local var_12_1 = arg_12_1.Data.unit
	local var_12_2 = arg_12_0._userFleet

	if var_12_1 == var_3.GetFlagShip(var_12_2) then
		local var_12_3 = arg_12_0._dataProxy

		var_3.TriggerFinishBattle(var_12_3)

		local var_12_4 = arg_12_0._dataProxy

		var_3.CalcChallengeScore(var_12_4, false)

		local var_12_5 = arg_12_0._state

		var_3.BattleEnd(var_12_5)

		return
	end

	local var_12_6 = arg_12_0._userFleet

	if #var_3.GetScoutList(var_12_6) == 0 then
		local var_12_7 = arg_12_0._dataProxy

		var_3.TriggerFinishBattle(var_12_7)

		local var_12_8 = arg_12_0._dataProxy

		var_3.CalcChallengeScore(var_12_8, false)

		local var_12_9 = arg_12_0._state

		var_3.BattleEnd(var_12_9)
	end

	return
end

function var_0_4.onUpdateCountDown(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._dataProxy

	if var_2.GetCountDown(var_13_0) <= 0 then
		local var_13_1 = arg_13_0._dataProxy

		var_2.TriggerFinishBattle(var_13_1)

		local var_13_2 = arg_13_0._dataProxy

		var_2.CalcChallengeScore(var_13_2, false)

		local var_13_3 = arg_13_0._state

		var_2.BattleEnd(var_13_3)
	end

	return
end

function var_0_4.monsterEnhance(arg_14_0, arg_14_1)
	var_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "maxHP", arg_14_0._enahanceDURAttr)
	var_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "cannonPower", arg_14_0._enahanceATKAttr)
	var_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "torpedoPower", arg_14_0._enahanceATKAttr)
	var_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "airPower", arg_14_0._enahanceATKAttr)
	var_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "dodgeRate", arg_14_0._enahanceEVDAttr)
	var_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "luck", arg_14_0._enahanceLUKAttr)

	return
end

return
