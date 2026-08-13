ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent
local var_0_3 = var_0.Battle.BattleConst

class = var_0_10004

local var_0_4 = var_0_10004("BattleSubRoutineCommand", var_0.Battle.BattleSubmarineRunCommand)

var_0.Battle.BattleSubRoutineCommand = var_0_4
var_0_4.__name = "BattleSubRoutineCommand"

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	return
end

function var_0_4.Initialize(arg_2_0)
	var_0_4.super.Initialize(arg_2_0)

	local var_2_0 = arg_2_0._dataProxy

	var_1.SubmarineRunInit(var_2_0)

	return
end

function var_0_4.DoPrologue(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.Marching(var_3_0)

	local function var_3_1()
		local var_4_0 = arg_3_0._uiMediator
		local var_4_1 = var_0.OpeningEffect

		local function var_4_2()
			local var_5_0 = arg_3_0._uiMediator

			var_0.ShowTimer(var_5_0)

			local var_5_1 = arg_3_0._state

			var_0.ChangeState(var_5_1, var_0.Battle.BattleState.BATTLE_STATE_FIGHT)

			local var_5_2 = arg_3_0._waveUpdater

			var_0.Start(var_5_2)

			return
		end

		SYSTEM_SUB_ROUTINE = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003)

		local var_4_3 = arg_3_0._dataProxy
		local var_4_4 = var_0.GetFleetByIFF(var_4_3, var_0.Battle.BattleConfig.FRIENDLY_CODE)

		var_0.FleetWarcry(var_4_4)
		var_0:ChangeSubmarineState(var_0.Battle.OxyState.STATE_FREE_DIVE)

		local var_4_5 = var_0:GetSubBoostVO()

		var_1.ResetCurrent(var_4_5)

		local var_4_6 = arg_3_0._dataProxy

		var_1.InitAllFleetUnitsWeaponCD(var_4_6)

		local var_4_7 = arg_3_0._dataProxy

		var_1.TirggerBattleStartBuffs(var_4_7)

		return
	end

	local var_3_2 = arg_3_0._dataProxy

	var_2.AutoStatistics(var_3_2, 0)

	local var_3_3 = arg_3_0._userFleet
	local var_3_4 = var_2.GetUnitList(var_3_3)

	ipairs = var_3_3

	for iter_3_0, iter_3_1 in var_3_3(var_3_4) do
		local var_3_5 = var_0.Battle.BattleBuffUnit.New(9040)

		iter_3_1:AddBuff(var_3_5)
		iter_3_1:RemoveBuff(8520)
	end

	local var_3_6 = arg_3_0._uiMediator

	var_3.SeaSurfaceShift(var_3_6, 45, 0, nil, var_3_1)

	return
end

function var_0_4.initWaveModule(arg_6_0)
	local function var_6_0(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_6_0._dataProxy

		var_3.SpawnMonster(var_7_0, arg_7_0, arg_7_1, arg_7_2, var_0.Battle.BattleConfig.FOE_CODE)

		return
	end

	local function var_6_1()
		if arg_6_0._vertifyFail then
			pg = var_0

			local var_8_0 = var_0.m02
			local var_8_1 = var_0.sendNotification

			GAME = var_2_10002

			var_8_1(var_8_0, var_2_10002.CHEATER_MARK, {
				reason = arg_6_0._vertifyFail
			})

			return
		end

		local var_8_2 = arg_6_0._dataProxy

		var_0.TriggerFinishBattle(var_8_2)

		local var_8_3 = arg_6_0._dataProxy

		var_0.CalcSubRoutineScore(var_8_3)

		local var_8_4 = arg_6_0._state

		var_0.BattleEnd(var_8_4)

		return
	end

	arg_6_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(var_6_0, nil, var_6_1, nil)

	return
end

function var_0_4.onUpdateCountDown(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._dataProxy

	if var_2.GetCountDown(var_9_0) <= 0 then
		local var_9_1 = arg_9_0._dataProxy

		var_2.EnemyEscape(var_9_1)

		local var_9_2 = arg_9_0._dataProxy

		var_2.CalcSubRountineTimeUp(var_9_2)

		local var_9_3 = arg_9_0._state

		var_2.BattleTimeUp(var_9_3)
	end

	return
end

function var_0_4.onShutDownPlayer(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.Dispatcher
	local var_10_1 = var_2.GetUniqueID(var_10_0)
	local var_10_2 = arg_10_0._dataProxy

	var_4.ShutdownPlayerUnit(var_10_2, var_10_1)

	return
end

function var_0_4.onPlayerShutDown(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._state

	if var_2.GetState(var_11_0) ~= arg_11_0._state.BATTLE_STATE_FIGHT then
		return
	end

	local var_11_1 = arg_11_1.Data.unit
	local var_11_2 = arg_11_0._userFleet

	if #var_3.GetSubBench(var_11_2) > 0 then
		local var_11_3 = arg_11_0._userFleet

		var_3.ShiftManualSub(var_11_3)
	else
		local var_11_4 = arg_11_0._dataProxy

		var_3.TriggerFinishBattle(var_11_4)

		local var_11_5 = arg_11_0._dataProxy

		var_3.CalcSubRountineElimate(var_11_5)

		local var_11_6 = arg_11_0._state

		var_3.BattleEnd(var_11_6)
	end

	return
end

return
