ys = ys or {}

local var_0_3 = class("BattleSubRoutineCommand", ys.Battle.BattleSubmarineRunCommand)

ys.Battle.BattleSubRoutineCommand = var_0_3
var_0_3.__name = "BattleSubRoutineCommand"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.Initialize(arg_2_0)
	var_0_3.super.Initialize(arg_2_0)
	arg_2_0._dataProxy:SubmarineRunInit()

	return
end

function var_0_3.DoPrologue(arg_3_0)
	pg.UIMgr.GetInstance():Marching()
	arg_3_0._dataProxy:AutoStatistics(0)

	for iter_3_0, iter_3_1 in ipairs((arg_3_0._userFleet:GetUnitList())) do
		iter_3_1:AddBuff((var_0.Battle.BattleBuffUnit.New(9040)))
		iter_3_1:RemoveBuff(8520)
	end

	arg_3_0._uiMediator:SeaSurfaceShift(45, 0, nil, function()
		arg_3_0._uiMediator:OpeningEffect(function()
			arg_3_0._uiMediator:ShowTimer()
			arg_3_0._state:ChangeState(var_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			arg_3_0._waveUpdater:Start()

			return
		end, SYSTEM_SUB_ROUTINE)

		local var_4_0 = arg_3_0._dataProxy:GetFleetByIFF(var_0.Battle.BattleConfig.FRIENDLY_CODE)

		var_4_0:FleetWarcry()
		var_4_0:ChangeSubmarineState(var_0.Battle.OxyState.STATE_FREE_DIVE)
		var_4_0:GetSubBoostVO():ResetCurrent()
		arg_3_0._dataProxy:InitAllFleetUnitsWeaponCD()
		arg_3_0._dataProxy:TirggerBattleStartBuffs()

		return
	end)

	return
end

function var_0_3.initWaveModule(arg_6_0)
	arg_6_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(function(arg_7_0, arg_7_1, arg_7_2)
		arg_6_0._dataProxy:SpawnMonster(arg_7_0, arg_7_1, arg_7_2, var_0.Battle.BattleConfig.FOE_CODE)

		return
	end, nil, function()
		if arg_6_0._vertifyFail then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = arg_6_0._vertifyFail
			})

			return
		end

		arg_6_0._dataProxy:TriggerFinishBattle()
		arg_6_0._dataProxy:CalcSubRoutineScore()
		arg_6_0._state:BattleEnd()

		return
	end, nil)

	return
end

function var_0_3.onUpdateCountDown(arg_9_0, arg_9_1)
	if arg_9_0._dataProxy:GetCountDown() <= 0 then
		arg_9_0._dataProxy:EnemyEscape()
		arg_9_0._dataProxy:CalcSubRountineTimeUp()
		arg_9_0._state:BattleTimeUp()
	end

	return
end

function var_0_3.onShutDownPlayer(arg_10_0, arg_10_1)
	arg_10_0._dataProxy:ShutdownPlayerUnit((arg_10_1.Dispatcher:GetUniqueID()))

	return
end

function var_0_3.onPlayerShutDown(arg_11_0, arg_11_1)
	if arg_11_0._state:GetState() ~= arg_11_0._state.BATTLE_STATE_FIGHT then
		return
	end

	if #arg_11_0._userFleet:GetSubBench() > 0 then
		arg_11_0._userFleet:ShiftManualSub()
	else
		arg_11_0._dataProxy:TriggerFinishBattle()
		arg_11_0._dataProxy:CalcSubRountineElimate()
		arg_11_0._state:BattleEnd()
	end

	return
end

return
