ys = ys or {}

local var_0_2 = class("BattleScenarioSubStrikeCommand", ys.Battle.BattleSingleDungeonCommand)

ys.Battle.BattleScenarioSubStrikeCommand = var_0_2
var_0_2.__name = "BattleScenarioSubStrikeCommand"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.DoPrologue(arg_2_0)
	pg.UIMgr.GetInstance():Marching()
	arg_2_0._uiMediator:SeaSurfaceShift(45, 0, nil, function()
		arg_2_0._uiMediator:OpeningEffect(function()
			arg_2_0._uiMediator:ShowTimer()
			arg_2_0._state:ChangeState(var_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			arg_2_0._waveUpdater:Start()

			if arg_2_0._dataProxy:GetInitData().hideAllButtons then
				arg_2_0._dataProxy:DispatchEvent(var_0.Event.New(var_0.Battle.BattleEvent.HIDE_INTERACTABLE_BUTTONS, {
					isActive = false
				}))
			end

			arg_2_0._uiMediator:InitCameraGestureSlider()
			arg_2_0._uiMediator:EnableJoystick(false)
			arg_2_0._uiMediator:EnableWeaponButton(false)

			return
		end)
		arg_2_0._dataProxy:SubmarineStrike(var_0.Battle.BattleConfig.FRIENDLY_CODE)

		return
	end)

	return
end

function var_0_2.initWaveModule(arg_5_0)
	arg_5_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(function(arg_6_0, arg_6_1, arg_6_2)
		arg_5_0._dataProxy:SpawnMonster(arg_6_0, arg_6_1, arg_6_2, var_0.Battle.BattleConfig.FOE_CODE)

		return
	end, function(arg_7_0)
		arg_5_0._dataProxy:SpawnAirFighter(arg_7_0)

		return
	end, function()
		if arg_5_0._vertifyFail then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = arg_5_0._vertifyFail
			})

			return
		end

		arg_5_0._dataProxy:TriggerFinishBattle()
		arg_5_0:CalcStatistic()
		arg_5_0._state:BattleEnd()

		return
	end, function(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
		arg_5_0._dataProxy:SpawnCubeArea(var_0.Battle.BattleConst.AOEField.SURFACE, -1, arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)

		return
	end)

	return
end

function var_0_2.onAddUnit(arg_10_0, arg_10_1)
	var_0_2.super.onAddUnit(arg_10_0, arg_10_1)

	if arg_10_1.Data.type == var_0.Battle.BattleConst.UnitType.BOSS_UNIT then
		arg_10_0._dataProxy:AddScenarioSubStrikeBoss(arg_10_1.Data.unit)
	end

	return
end

function var_0_2.onPlayerShutDown(arg_11_0, arg_11_1)
	if arg_11_0._state:GetState() ~= arg_11_0._state.BATTLE_STATE_FIGHT then
		return
	end

	if #arg_11_0._userFleet:GetSubList() == 0 then
		arg_11_0._dataProxy:TriggerFinishBattle()
		arg_11_0:CalcStatistic()
		arg_11_0._state:BattleEnd()
	end

	return
end

function var_0_2.onUpdateCountDown(arg_12_0, arg_12_1)
	if arg_12_0._dataProxy:GetCountDown() <= 0 then
		arg_12_0._dataProxy:EnemyEscape()
		arg_12_0:CalcStatistic()
		arg_12_0._state:BattleTimeUp()
	end

	return
end

function var_0_2.onWillDie(arg_13_0, arg_13_1)
	if arg_13_1.Dispatcher:GetDeathReason() == var_0.Battle.BattleConst.UnitDeathReason.LEAVE then
		if arg_13_1.Dispatcher:GetIFF() == var_0.Battle.BattleConfig.FRIENDLY_CODE then
			arg_13_0._dataProxy:CalcBPWhenPlayerLeave(arg_13_1.Dispatcher)
		end
	else
		arg_13_0._dataProxy:CalcBattleScoreWhenDead(arg_13_1.Dispatcher)
	end

	local var_13_0 = arg_13_0._dataProxy:IsThereBoss()

	if arg_13_1.Dispatcher:IsBoss() and not var_13_0 then
		arg_13_0._dataProxy:KillAllEnemy()
	end

	return
end

function var_0_2.CalcBattleEnd(arg_14_0)
	arg_14_0._dataProxy:TriggerFinishBattle()
	arg_14_0:CalcStatistic()
	arg_14_0._state:BattleEnd()

	return
end

function var_0_2.CalcStatistic(arg_15_0)
	arg_15_0._dataProxy:CalcScenarioSubStrikeScoreAtEnd()

	return
end

return
