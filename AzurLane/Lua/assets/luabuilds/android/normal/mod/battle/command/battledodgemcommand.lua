ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent

class = var_0_10003

local var_0_3 = var_0_10003("BattleDodgemCommand", var_0.Battle.BattleSingleDungeonCommand)

var_0.Battle.BattleDodgemCommand = var_0_3
var_0_3.__name = "BattleDodgemCommand"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.Initialize(arg_2_0)
	var_0_3.super.Initialize(arg_2_0)

	local var_2_0 = arg_2_0._dataProxy

	var_1.DodgemCountInit(var_2_0)

	return
end

function var_0_3.DoPrologue(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.Marching(var_3_0)

	local function var_3_1()
		local var_4_0 = arg_3_0._uiMediator

		var_0.OpeningEffect(var_4_0, function()
			local var_5_0 = arg_3_0._dataProxy

			var_0.SetupDamageKamikazeShip(var_5_0, var_0.Battle.BattleFormulas.CalcDamageLockS2M)

			local var_5_1 = arg_3_0._dataProxy

			var_0.SetupDamageCrush(var_5_1, var_0.Battle.BattleFormulas.UnilateralCrush)

			local var_5_2 = arg_3_0._uiMediator

			var_0.ShowTimer(var_5_2)

			local var_5_3 = arg_3_0._state

			var_0.ChangeState(var_5_3, var_0.Battle.BattleState.BATTLE_STATE_FIGHT)

			local var_5_4 = arg_3_0._waveUpdater

			var_0.Start(var_5_4)

			return
		end)

		local var_4_1 = arg_3_0._dataProxy
		local var_4_2 = var_0.GetFleetByIFF(var_4_1, var_0.Battle.BattleConfig.FRIENDLY_CODE)

		var_0.FleetWarcry(var_4_2)

		return
	end

	local var_3_2 = arg_3_0._uiMediator

	var_2.SeaSurfaceShift(var_3_2, 45, 0, nil, var_3_1)

	local var_3_3 = arg_3_0._uiMediator

	var_2.ShowDodgemScoreBar(var_3_3)

	return
end

function var_0_3.initWaveModule(arg_6_0)
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

		var_0.CalcDodgemScore(var_8_3)

		local var_8_4 = arg_6_0._state

		var_0.BattleEnd(var_8_4)

		return
	end

	arg_6_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(var_6_0, nil, var_6_1, nil)

	return
end

function var_0_3.onWillDie(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.Dispatcher
	local var_9_1 = arg_9_0._dataProxy

	var_3.CalcDodgemCount(var_9_1, var_9_0)

	local var_9_2 = var_9_0:GetDeathReason()
	local var_9_3 = var_9_0
	local var_9_4 = var_9_0.GetTemplate(var_9_3).type

	ShipType = var_9_3

	if var_9_4 == var_9_3.JinBi and var_9_2 == var_0.Battle.BattleConst.UnitDeathReason.CRUSH then
		local var_9_5 = arg_9_0._dataProxy
		local var_9_6 = var_5.GetScorePoint(var_9_5)

		var_9_0:DispatchScorePoint(var_9_6)
	end

	return
end

return
