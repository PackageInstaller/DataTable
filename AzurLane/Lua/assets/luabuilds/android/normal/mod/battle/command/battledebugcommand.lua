ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent

class = var_0_10003

local var_0_3 = var_0_10003("BattleDebugCommand", var_0.MVC.Command)

var_0.Battle.BattleDebugCommand = var_0_3
var_0_3.__name = "BattleDebugCommand"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.Initialize(arg_2_0)
	arg_2_0:Init()
	var_0_3.super.Initialize(arg_2_0)

	local var_2_0 = arg_2_0._state

	arg_2_0._dataProxy = var_1.GetProxyByName(var_2_0, var_0.Battle.BattleDataProxy.__name)

	local var_2_1 = arg_2_0._state

	arg_2_0._uiMediator = var_1.GetMediatorByName(var_2_1, var_0.Battle.BattleUIMediator.__name)

	arg_2_0:AddEvent()

	return
end

function var_0_3.DoPrologue(arg_3_0)
	(function()
		local var_4_0 = arg_3_0._uiMediator
		local var_4_1 = var_0.OpeningEffect

		local function var_4_2()
			local var_5_0 = arg_3_0._uiMediator

			var_0.ShowAutoBtn(var_5_0)

			local var_5_1 = arg_3_0._uiMediator

			var_0.ShowTimer(var_5_1)

			local var_5_2 = arg_3_0._state

			var_0.ChangeState(var_5_2, var_0.Battle.BattleState.BATTLE_STATE_FIGHT)

			return
		end

		SYSTEM_DEBUG = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003)

		local var_4_3 = arg_3_0._dataProxy

		var_0.InitAllFleetUnitsWeaponCD(var_4_3)

		local var_4_4 = arg_3_0._dataProxy

		var_0.TirggerBattleStartBuffs(var_4_4)

		return
	end)()

	return
end

function var_0_3.Init(arg_6_0)
	arg_6_0._unitDataList = {}

	return
end

function var_0_3.Clear(arg_7_0)
	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0._unitDataList) do
		arg_7_0:UnregisterUnitEvent(iter_7_1)

		arg_7_0._unitDataList[iter_7_0] = nil
	end

	return
end

function var_0_3.Reinitialize(arg_8_0)
	local var_8_0 = arg_8_0._state

	var_1.Deactive(var_8_0)
	arg_8_0:Clear()
	arg_8_0:Init()

	return
end

function var_0_3.Dispose(arg_9_0)
	var_0.Battle.BattleDataProxy.Update = var_0.Battle.BattleDebugConsole.ProxyUpdateNormal
	var_0.Battle.BattleDataProxy.UpdateAutoComponent = var_0.Battle.BattleDebugConsole.ProxyUpdateAutoComponentNormal

	arg_9_0:Clear()
	arg_9_0:RemoveEvent()
	var_0_3.super.Dispose(arg_9_0)

	return
end

function var_0_3.AddEvent(arg_10_0)
	local var_10_0 = arg_10_0._dataProxy

	var_1.RegisterEventListener(var_10_0, arg_10_0, var_0_2.STAGE_DATA_INIT_FINISH, arg_10_0.onInitBattle)

	local var_10_1 = arg_10_0._dataProxy

	var_1.RegisterEventListener(var_10_1, arg_10_0, var_0_2.ADD_UNIT, arg_10_0.onAddUnit)

	local var_10_2 = arg_10_0._dataProxy

	var_1.RegisterEventListener(var_10_2, arg_10_0, var_0_2.REMOVE_UNIT, arg_10_0.onRemoveUnit)

	local var_10_3 = arg_10_0._dataProxy

	var_1.RegisterEventListener(var_10_3, arg_10_0, var_0_2.SHUT_DOWN_PLAYER, arg_10_0.onPlayerShutDown)

	return
end

function var_0_3.RemoveEvent(arg_11_0)
	local var_11_0 = arg_11_0._dataProxy

	var_1.UnregisterEventListener(var_11_0, arg_11_0, var_0_2.STAGE_DATA_INIT_FINISH)

	local var_11_1 = arg_11_0._dataProxy

	var_1.UnregisterEventListener(var_11_1, arg_11_0, var_0_2.ADD_UNIT)

	local var_11_2 = arg_11_0._dataProxy

	var_1.UnregisterEventListener(var_11_2, arg_11_0, var_0_2.REMOVE_UNIT)

	local var_11_3 = arg_11_0._dataProxy

	var_1.UnregisterEventListener(var_11_3, arg_11_0, var_0_2.SHUT_DOWN_PLAYER)

	return
end

function var_0_3.onInitBattle(arg_12_0)
	local var_12_0 = arg_12_0._dataProxy

	arg_12_0._userFleet = var_1.GetFleetByIFF(var_12_0, var_0.Battle.BattleConfig.FRIENDLY_CODE)

	return
end

function var_0_3.onAddUnit(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.Data.type
	local var_13_1 = arg_13_1.Data.unit

	arg_13_0:RegisterUnitEvent(var_13_1)

	arg_13_0._unitDataList[var_13_1:GetUniqueID()] = var_13_1

	if var_13_0 ~= var_0.Battle.BattleConst.UnitType.ENEMY_UNIT and var_13_0 ~= var_0.Battle.BattleConst.UnitType.BOSS_UNIT and var_13_0 ~= var_0.Battle.BattleConst.UnitType.MINION_UNIT and var_13_0 ~= var_0.Battle.BattleConst.UnitType.NPC_UNIT and var_13_0 == var_0.Battle.BattleConst.UnitType.BOSS_UNIT then
		-- block empty
	end

	return
end

function var_0_3.RegisterUnitEvent(arg_14_0, arg_14_1)
	arg_14_1:RegisterEventListener(arg_14_0, var_0_1.WILL_DIE, arg_14_0.onWillDie)
	arg_14_1:RegisterEventListener(arg_14_0, var_0_1.DYING, arg_14_0.onUnitDying)

	if arg_14_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_14_1:RegisterEventListener(arg_14_0, var_0_1.SHUT_DOWN_PLAYER, arg_14_0.onShutDownPlayer)
	end

	return
end

function var_0_3.UnregisterUnitEvent(arg_15_0, arg_15_1)
	arg_15_1:UnregisterEventListener(arg_15_0, var_0_1.WILL_DIE)
	arg_15_1:UnregisterEventListener(arg_15_0, var_0_1.DYING)

	if arg_15_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_15_1:UnregisterEventListener(arg_15_0, var_0_1.SHUT_DOWN_PLAYER)
	end

	return
end

function var_0_3.onRemoveUnit(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.Data.UID

	if arg_16_0._unitDataList[var_16_0] == nil then
		return
	end

	arg_16_0:UnregisterUnitEvent(var_3)

	arg_16_0._unitDataList[var_16_0] = nil

	return
end

function var_0_3.onPlayerShutDown(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.Data.unit
	local var_17_1 = arg_17_0._userFleet

	if var_17_0 == var_3.GetMainList(var_17_1) == 0 then
		local var_17_2 = arg_17_0._dataProxy

		var_3.KillAllAirStrike(var_17_2)

		local var_17_3 = arg_17_0._dataProxy

		var_3.KillAllEnemy(var_17_3)

		local var_17_4 = arg_17_0._dataProxy

		var_3.CLSBullet(var_17_4, var_0.Battle.BattleConfig.FRIENDLY_CODE)

		local var_17_5 = arg_17_0._dataProxy

		var_3.CLSBullet(var_17_5, var_0.Battle.BattleConfig.FOE_CODE)

		local var_17_6 = arg_17_0._dataProxy
		local var_17_7 = var_3.GetInitData(var_17_6).MainUnitList

		ipairs = var_17_6

		for iter_17_0, iter_17_1 in var_17_6(var_17_7) do
			local var_17_8 = arg_17_0._dataProxy

			var_9.SpawnMain(var_17_8, iter_17_1, var_0.Battle.BattleConfig.FRIENDLY_CODE)
		end
	end

	local var_17_9 = arg_17_0._userFleet

	if #var_3.GetScoutList(var_17_9) == 0 then
		local var_17_10 = arg_17_0._dataProxy

		var_3.KillAllAirStrike(var_17_10)

		local var_17_11 = arg_17_0._dataProxy

		var_3.KillAllEnemy(var_17_11)

		local var_17_12 = arg_17_0._dataProxy

		var_3.CLSBullet(var_17_12, var_0.Battle.BattleConfig.FRIENDLY_CODE)

		local var_17_13 = arg_17_0._dataProxy

		var_3.CLSBullet(var_17_13, var_0.Battle.BattleConfig.FOE_CODE)

		local var_17_14 = arg_17_0._dataProxy
		local var_17_15 = var_3.GetInitData(var_17_14).VanguardUnitList

		ipairs = var_17_14

		for iter_17_2, iter_17_3 in var_17_14(var_17_15) do
			local var_17_16 = arg_17_0._dataProxy

			var_9.SpawnVanguard(var_17_16, iter_17_3, var_0.Battle.BattleConfig.FRIENDLY_CODE)
		end
	end

	return
end

function var_0_3.onUnitDying(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.Dispatcher
	local var_18_1 = var_2.GetUniqueID(var_18_0)
	local var_18_2 = arg_18_0._dataProxy

	var_4.KillUnit(var_18_2, var_18_1)

	return
end

function var_0_3.onWillDie(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.Dispatcher
	local var_19_1 = arg_19_0._dataProxy

	var_3.CalcBattleScoreWhenDead(var_19_1, var_19_0)

	local var_19_2 = arg_19_0._dataProxy
	local var_19_3 = var_3.IsThereBoss(var_19_2)

	if var_19_0:IsBoss() and not var_19_3 then
		local var_19_4 = arg_19_0._dataProxy

		var_4.KillAllEnemy(var_19_4)
	end

	return
end

function var_0_3.onShutDownPlayer(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.Dispatcher
	local var_20_1 = var_2.GetUniqueID(var_20_0)
	local var_20_2 = arg_20_0._dataProxy

	var_4.ShutdownPlayerUnit(var_20_2, var_20_1)

	return
end

return
