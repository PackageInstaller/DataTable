ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent

class = var_0_10003

local var_0_3 = var_0_10003("BattleScenarioSubStrikeCommand", var_0.Battle.BattleSingleDungeonCommand)

var_0.Battle.BattleScenarioSubStrikeCommand = var_0_3
var_0_3.__name = "BattleScenarioSubStrikeCommand"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.DoPrologue(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.Marching(var_2_0)

	local function var_2_1()
		local var_3_0 = arg_2_0._uiMediator

		var_0.OpeningEffect(var_3_0, function()
			local var_4_0 = arg_2_0._uiMediator

			var_0.ShowTimer(var_4_0)

			local var_4_1 = arg_2_0._state

			var_0.ChangeState(var_4_1, var_0.Battle.BattleState.BATTLE_STATE_FIGHT)

			local var_4_2 = arg_2_0._waveUpdater

			var_0.Start(var_4_2)

			local var_4_3 = arg_2_0._dataProxy

			if var_0.GetInitData(var_4_3).hideAllButtons then
				local var_4_4 = arg_2_0._dataProxy

				var_0.DispatchEvent(var_4_4, var_0.Event.New(var_0.Battle.BattleEvent.HIDE_INTERACTABLE_BUTTONS, {
					isActive = false
				}))
			end

			local var_4_5 = arg_2_0._uiMediator

			var_0.InitCameraGestureSlider(var_4_5)

			local var_4_6 = arg_2_0._uiMediator

			var_0.EnableJoystick(var_4_6, false)

			local var_4_7 = arg_2_0._uiMediator

			var_0.EnableWeaponButton(var_4_7, false)

			return
		end)

		local var_3_1 = arg_2_0._dataProxy

		var_0.SubmarineStrike(var_3_1, var_0.Battle.BattleConfig.FRIENDLY_CODE)

		return
	end

	local var_2_2 = arg_2_0._uiMediator

	var_2.SeaSurfaceShift(var_2_2, 45, 0, nil, var_2_1)

	return
end

function var_0_3.initWaveModule(arg_5_0)
	local function var_5_0(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_5_0._dataProxy

		var_3.SpawnMonster(var_6_0, arg_6_0, arg_6_1, arg_6_2, var_0.Battle.BattleConfig.FOE_CODE)

		return
	end

	local function var_5_1(arg_7_0)
		local var_7_0 = arg_5_0._dataProxy

		var_1.SpawnAirFighter(var_7_0, arg_7_0)

		return
	end

	local function var_5_2()
		if arg_5_0._vertifyFail then
			pg = var_0

			local var_8_0 = var_0.m02
			local var_8_1 = var_0.sendNotification

			GAME = var_2_10003

			var_8_1(var_8_0, var_2_10003.CHEATER_MARK, {
				reason = arg_5_0._vertifyFail
			})

			return
		end

		local var_8_2 = arg_5_0._dataProxy

		var_0.TriggerFinishBattle(var_8_2)

		local var_8_3 = arg_5_0

		var_0.CalcStatistic(var_8_3)

		local var_8_4 = arg_5_0._state

		var_0.BattleEnd(var_8_4)

		return
	end

	local function var_5_3(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
		local var_9_0 = arg_5_0._dataProxy

		var_5.SpawnCubeArea(var_9_0, var_0.Battle.BattleConst.AOEField.SURFACE, -1, arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)

		return
	end

	arg_5_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(var_5_0, var_5_1, var_5_2, var_5_3)

	return
end

function var_0_3.onAddUnit(arg_10_0, arg_10_1)
	var_0_3.super.onAddUnit(arg_10_0, arg_10_1)

	if arg_10_1.Data.type == var_0.Battle.BattleConst.UnitType.BOSS_UNIT then
		local var_10_0 = arg_10_1.Data.unit
		local var_10_1 = arg_10_0._dataProxy

		var_3.AddScenarioSubStrikeBoss(var_10_1, var_10_0)
	end

	return
end

function var_0_3.onPlayerShutDown(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._state

	if var_2.GetState(var_11_0) ~= arg_11_0._state.BATTLE_STATE_FIGHT then
		return
	end

	local var_11_1 = arg_11_0._userFleet

	if #var_2.GetSubList(var_11_1) == 0 then
		local var_11_2 = arg_11_0._dataProxy

		var_2.TriggerFinishBattle(var_11_2)
		arg_11_0:CalcStatistic()

		local var_11_3 = arg_11_0._state

		var_2.BattleEnd(var_11_3)
	end

	return
end

function var_0_3.onUpdateCountDown(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._dataProxy

	if var_2.GetCountDown(var_12_0) <= 0 then
		local var_12_1 = arg_12_0._dataProxy

		var_2.EnemyEscape(var_12_1)
		arg_12_0:CalcStatistic()

		local var_12_2 = arg_12_0._state

		var_2.BattleTimeUp(var_12_2)
	end

	return
end

function var_0_3.onWillDie(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.Dispatcher
	local var_13_1 = var_0.Battle.BattleConst.UnitDeathReason

	if var_13_0:GetDeathReason() == var_13_1.LEAVE then
		if var_13_0:GetIFF() == var_0.Battle.BattleConfig.FRIENDLY_CODE then
			local var_13_2 = arg_13_0._dataProxy

			var_5.CalcBPWhenPlayerLeave(var_13_2, var_13_0)
		end
	else
		local var_13_3 = arg_13_0._dataProxy

		var_5.CalcBattleScoreWhenDead(var_13_3, var_13_0)
	end

	local var_13_4 = arg_13_0._dataProxy
	local var_13_5 = var_5.IsThereBoss(var_13_4)

	if var_13_0:IsBoss() and not var_13_5 then
		local var_13_6 = arg_13_0._dataProxy

		var_6.KillAllEnemy(var_13_6)
	end

	return
end

function var_0_3.CalcBattleEnd(arg_14_0)
	local var_14_0 = arg_14_0._dataProxy

	var_1.TriggerFinishBattle(var_14_0)
	arg_14_0:CalcStatistic()

	local var_14_1 = arg_14_0._state

	var_1.BattleEnd(var_14_1)

	return
end

function var_0_3.CalcStatistic(arg_15_0)
	local var_15_0 = arg_15_0._dataProxy

	var_1.CalcScenarioSubStrikeScoreAtEnd(var_15_0)

	return
end

return
