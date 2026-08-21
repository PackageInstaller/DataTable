ys = ys or {}

local var_0_0 = ys.Battle.BattleUnitEvent
local var_0_1 = ys.Battle.BattleEvent
local var_0_3 = class("BattleSubmarineRunCommand", ys.Battle.BattleSingleDungeonCommand)

ys.Battle.BattleSubmarineRunCommand = var_0_3
var_0_3.__name = "BattleSubmarineRunCommand"

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
		iter_3_1:RemoveBuff(8520)
	end

	arg_3_0._uiMediator:SeaSurfaceShift(45, 0, nil, function()
		arg_3_0._uiMediator:OpeningEffect(function()
			arg_3_0._uiMediator:ShowTimer()
			arg_3_0._state:ChangeState(var_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			arg_3_0._waveUpdater:Start()

			return
		end, SYSTEM_SUBMARINE_RUN)

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

function var_0_3.onInitBattle(arg_6_0)
	var_0_3.super.onInitBattle(arg_6_0)
	arg_6_0._userFleet:RegisterEventListener(arg_6_0, var_0_1.MANUAL_SUBMARINE_SHIFT, arg_6_0.onSubmarineShift)

	return
end

function var_0_3.initWaveModule(arg_7_0)
	arg_7_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(function(arg_8_0, arg_8_1, arg_8_2)
		arg_7_0._dataProxy:SpawnMonster(arg_8_0, arg_8_1, arg_8_2, var_0.Battle.BattleConfig.FOE_CODE)

		return
	end, nil, function()
		if arg_7_0._vertifyFail then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = arg_7_0._vertifyFail
			})

			return
		end

		arg_7_0._dataProxy:TriggerFinishBattle()
		arg_7_0._dataProxy:CalcSubRunScore()
		arg_7_0._state:BattleEnd()

		return
	end, nil)

	return
end

function var_0_3.onUpdateCountDown(arg_10_0, arg_10_1)
	if arg_10_0._dataProxy:GetCountDown() <= 0 then
		arg_10_0._dataProxy:EnemyEscape()
		arg_10_0._dataProxy:CalcSubRunTimeUp()
		arg_10_0._state:BattleTimeUp()
	end

	return
end

function var_0_3.RemoveEvent(arg_11_0)
	arg_11_0._userFleet:UnregisterEventListener(arg_11_0, var_0_1.MANUAL_SUBMARINE_SHIFT)
	var_0_3.super.RemoveEvent(arg_11_0)

	return
end

function var_0_3.UnregisterUnitEvent(arg_12_0, arg_12_1)
	var_0_3.super.UnregisterUnitEvent(arg_12_0, arg_12_1)
	arg_12_1:UnregisterEventListener(arg_12_0, var_0_0.ANTI_SUB_VIGILANCE_HATE_CHAIN)

	return
end

function var_0_3.onAddUnit(arg_13_0, arg_13_1)
	var_0_3.super.onAddUnit(arg_13_0, arg_13_1)

	if arg_13_1.Data.type ~= var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_13_1.Data.unit:RegisterEventListener(arg_13_0, var_0_0.ANTI_SUB_VIGILANCE_HATE_CHAIN, arg_13_0.onHateChain)
	end

	return
end

function var_0_3.onHateChain(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._unitDataList) do
		iter_14_1:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_ANTI_SUB_HATE_CHAIN)
	end

	return
end

function var_0_3.onWillDie(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.Dispatcher:GetDeathReason()

	if arg_15_1.Dispatcher:GetIFF() == var_0.Battle.BattleConfig.FRIENDLY_CODE then
		arg_15_0._dataProxy:DelScoreWhenPlayerDead(arg_15_1.Dispatcher)
	end

	if var_15_0 == var_0.Battle.BattleConst.UnitDeathReason.KILLED or var_15_0 == var_0.Battle.BattleConst.UnitDeathReason.DESTRUCT then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._unitDataList) do
			iter_15_1:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_TEAMMATE_SHIP_DYING, {
				unit = iter_15_1
			})
		end
	end

	if arg_15_1.Dispatcher:GetTemplate().type == ShipType.JinBi and var_15_0 == var_0.Battle.BattleConst.UnitDeathReason.KILLED then
		arg_15_0._dataProxy:CalcKillingSupplyShip()
	end

	local var_15_1 = arg_15_0._dataProxy:IsThereBoss()

	if arg_15_1.Dispatcher:IsBoss() and not var_15_1 then
		if var_15_0 == var_0.Battle.BattleConst.UnitDeathReason.DESTRUCT then
			arg_15_0._dataProxy:AddScoreWhenBossDestruct()
		end

		arg_15_0._dataProxy:KillAllEnemy()
	end

	return
end

function var_0_3.onSubmarineShift(arg_16_0, arg_16_1)
	local var_16_0

	if arg_16_1.Data.state == var_0.Battle.OxyState.STATE_FREE_DIVE then
		var_16_0 = var_0.Battle.BattleConst.BuffEffectType.ON_SUBMARINE_FREE_DIVE
	elseif arg_16_1.Data.state == var_0.Battle.OxyState.STATE_FREE_FLOAT then
		var_16_0 = var_0.Battle.BattleConst.BuffEffectType.ON_SUBMARINE_FREE_FLOAT
	end

	for iter_16_0, iter_16_1 in pairs(arg_16_0._unitDataList) do
		iter_16_1:TriggerBuff(var_16_0)
	end

	return
end

function var_0_3.onShutDownPlayer(arg_17_0)
	arg_17_0._dataProxy:TriggerFinishBattle()
	arg_17_0._dataProxy:CalcSubRunDead()
	arg_17_0._state:BattleEnd()

	return
end

return
