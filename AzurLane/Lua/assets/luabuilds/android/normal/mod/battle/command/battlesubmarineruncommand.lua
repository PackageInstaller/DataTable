ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent
local var_0_3 = var_0.Battle.BattleConst

class = var_0_10004

local var_0_4 = var_0_10004("BattleSubmarineRunCommand", var_0.Battle.BattleSingleDungeonCommand)

var_0.Battle.BattleSubmarineRunCommand = var_0_4
var_0_4.__name = "BattleSubmarineRunCommand"

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

		SYSTEM_SUBMARINE_RUN = var_2_10003

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
		iter_3_1:RemoveBuff(8520)
	end

	local var_3_5 = arg_3_0._uiMediator

	var_3.SeaSurfaceShift(var_3_5, 45, 0, nil, var_3_1)

	return
end

function var_0_4.onInitBattle(arg_6_0)
	var_0_4.super.onInitBattle(arg_6_0)

	local var_6_0 = arg_6_0._userFleet

	var_1.RegisterEventListener(var_6_0, arg_6_0, var_0_2.MANUAL_SUBMARINE_SHIFT, arg_6_0.onSubmarineShift)

	return
end

function var_0_4.initWaveModule(arg_7_0)
	local function var_7_0(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_7_0._dataProxy

		var_3.SpawnMonster(var_8_0, arg_8_0, arg_8_1, arg_8_2, var_0.Battle.BattleConfig.FOE_CODE)

		return
	end

	local function var_7_1()
		if arg_7_0._vertifyFail then
			pg = var_0

			local var_9_0 = var_0.m02
			local var_9_1 = var_0.sendNotification

			GAME = var_2_10002

			var_9_1(var_9_0, var_2_10002.CHEATER_MARK, {
				reason = arg_7_0._vertifyFail
			})

			return
		end

		local var_9_2 = arg_7_0._dataProxy

		var_0.TriggerFinishBattle(var_9_2)

		local var_9_3 = arg_7_0._dataProxy

		var_0.CalcSubRunScore(var_9_3)

		local var_9_4 = arg_7_0._state

		var_0.BattleEnd(var_9_4)

		return
	end

	arg_7_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(var_7_0, nil, var_7_1, nil)

	return
end

function var_0_4.onUpdateCountDown(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._dataProxy

	if var_2.GetCountDown(var_10_0) <= 0 then
		local var_10_1 = arg_10_0._dataProxy

		var_2.EnemyEscape(var_10_1)

		local var_10_2 = arg_10_0._dataProxy

		var_2.CalcSubRunTimeUp(var_10_2)

		local var_10_3 = arg_10_0._state

		var_2.BattleTimeUp(var_10_3)
	end

	return
end

function var_0_4.RemoveEvent(arg_11_0)
	local var_11_0 = arg_11_0._userFleet

	var_1.UnregisterEventListener(var_11_0, arg_11_0, var_0_2.MANUAL_SUBMARINE_SHIFT)
	var_0_4.super.RemoveEvent(arg_11_0)

	return
end

function var_0_4.UnregisterUnitEvent(arg_12_0, arg_12_1)
	var_0_4.super.UnregisterUnitEvent(arg_12_0, arg_12_1)
	arg_12_1:UnregisterEventListener(arg_12_0, var_0_1.ANTI_SUB_VIGILANCE_HATE_CHAIN)

	return
end

function var_0_4.onAddUnit(arg_13_0, arg_13_1)
	var_0_4.super.onAddUnit(arg_13_0, arg_13_1)

	local var_13_0 = arg_13_1.Data.type
	local var_13_1 = arg_13_1.Data.unit

	if var_13_0 ~= var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		var_13_1:RegisterEventListener(arg_13_0, var_0_1.ANTI_SUB_VIGILANCE_HATE_CHAIN, arg_13_0.onHateChain)
	end

	return
end

function var_0_4.onHateChain(arg_14_0, arg_14_1)
	pairs = var_1_10002

	for iter_14_0, iter_14_1 in var_1_10002(arg_14_0._unitDataList) do
		iter_14_1:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_ANTI_SUB_HATE_CHAIN)
	end

	return
end

function var_0_4.onWillDie(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.Dispatcher
	local var_15_1 = var_2.GetDeathReason(var_15_0)

	if var_2:GetIFF() == var_0.Battle.BattleConfig.FRIENDLY_CODE then
		local var_15_2 = arg_15_0._dataProxy

		var_5.DelScoreWhenPlayerDead(var_15_2, var_2)
	end

	if var_15_1 == var_0.Battle.BattleConst.UnitDeathReason.KILLED or var_15_1 == var_0.Battle.BattleConst.UnitDeathReason.DESTRUCT then
		pairs = var_5

		for iter_15_0, iter_15_1 in var_5(arg_15_0._unitDataList) do
			iter_15_1:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_TEAMMATE_SHIP_DYING, {
				unit = iter_15_1
			})
		end
	end

	local var_15_3 = var_2
	local var_15_4 = var_2.GetTemplate(var_15_3).type

	ShipType = var_15_3

	if var_15_4 == var_15_3.JinBi and var_15_1 == var_0.Battle.BattleConst.UnitDeathReason.KILLED then
		local var_15_5 = arg_15_0._dataProxy

		var_5.CalcKillingSupplyShip(var_15_5)
	end

	local var_15_6 = arg_15_0._dataProxy
	local var_15_7 = var_5.IsThereBoss(var_15_6)

	if var_2:IsBoss() and not var_15_7 then
		if var_15_1 == var_0.Battle.BattleConst.UnitDeathReason.DESTRUCT then
			local var_15_8 = arg_15_0._dataProxy

			var_6.AddScoreWhenBossDestruct(var_15_8)
		end

		local var_15_9 = arg_15_0._dataProxy

		var_6.KillAllEnemy(var_15_9)
	end

	return
end

function var_0_4.onSubmarineShift(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.Data.state
	local var_16_1

	if var_16_0 == var_0.Battle.OxyState.STATE_FREE_DIVE then
		var_16_1 = var_0.Battle.BattleConst.BuffEffectType.ON_SUBMARINE_FREE_DIVE
	elseif var_16_0 == var_0.Battle.OxyState.STATE_FREE_FLOAT then
		var_16_1 = var_0.Battle.BattleConst.BuffEffectType.ON_SUBMARINE_FREE_FLOAT
	end

	pairs = var_4

	for iter_16_0, iter_16_1 in var_4(arg_16_0._unitDataList) do
		iter_16_1:TriggerBuff(var_16_1)
	end

	return
end

function var_0_4.onShutDownPlayer(arg_17_0)
	local var_17_0 = arg_17_0._dataProxy

	var_1.TriggerFinishBattle(var_17_0)

	local var_17_1 = arg_17_0._dataProxy

	var_1.CalcSubRunDead(var_17_1)

	local var_17_2 = arg_17_0._state

	var_1.BattleEnd(var_17_2)

	return
end

return
