ys = ys or {}

local var_0_2 = class("BattleDodgemCommand", ys.Battle.BattleSingleDungeonCommand)

ys.Battle.BattleDodgemCommand = var_0_2
var_0_2.__name = "BattleDodgemCommand"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.Initialize(arg_2_0)
	var_0_2.super.Initialize(arg_2_0)
	arg_2_0._dataProxy:DodgemCountInit()

	return
end

function var_0_2.DoPrologue(arg_3_0)
	pg.UIMgr.GetInstance():Marching()
	arg_3_0._uiMediator:SeaSurfaceShift(45, 0, nil, function()
		arg_3_0._uiMediator:OpeningEffect(function()
			arg_3_0._dataProxy:SetupDamageKamikazeShip(var_0.Battle.BattleFormulas.CalcDamageLockS2M)
			arg_3_0._dataProxy:SetupDamageCrush(var_0.Battle.BattleFormulas.UnilateralCrush)
			arg_3_0._uiMediator:ShowTimer()
			arg_3_0._state:ChangeState(var_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			arg_3_0._waveUpdater:Start()

			return
		end)
		arg_3_0._dataProxy:GetFleetByIFF(var_0.Battle.BattleConfig.FRIENDLY_CODE):FleetWarcry()

		return
	end)
	arg_3_0._uiMediator:ShowDodgemScoreBar()

	return
end

function var_0_2.initWaveModule(arg_6_0)
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
		arg_6_0._dataProxy:CalcDodgemScore()
		arg_6_0._state:BattleEnd()

		return
	end, nil)

	return
end

function var_0_2.onWillDie(arg_9_0, arg_9_1)
	arg_9_0._dataProxy:CalcDodgemCount(arg_9_1.Dispatcher)

	if arg_9_1.Dispatcher:GetTemplate().type == ShipType.JinBi and arg_9_1.Dispatcher:GetDeathReason() == var_0.Battle.BattleConst.UnitDeathReason.CRUSH then
		arg_9_1.Dispatcher:DispatchScorePoint((arg_9_0._dataProxy:GetScorePoint()))
	end

	return
end

return
