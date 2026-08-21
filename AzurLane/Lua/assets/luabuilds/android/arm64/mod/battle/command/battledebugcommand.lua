ys = ys or {}

local var_0_0 = ys.Battle.BattleUnitEvent
local var_0_1 = ys.Battle.BattleEvent
local var_0_2 = class("BattleDebugCommand", ys.MVC.Command)

ys.Battle.BattleDebugCommand = var_0_2
var_0_2.__name = "BattleDebugCommand"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.Initialize(arg_2_0)
	arg_2_0:Init()
	var_0_2.super.Initialize(arg_2_0)

	arg_2_0._dataProxy = arg_2_0._state:GetProxyByName(var_0.Battle.BattleDataProxy.__name)
	arg_2_0._uiMediator = arg_2_0._state:GetMediatorByName(var_0.Battle.BattleUIMediator.__name)

	arg_2_0:AddEvent()

	return
end

function var_0_2.DoPrologue(arg_3_0)
	(function()
		arg_3_0._uiMediator:OpeningEffect(function()
			arg_3_0._uiMediator:ShowAutoBtn()
			arg_3_0._uiMediator:ShowTimer()
			arg_3_0._state:ChangeState(var_0.Battle.BattleState.BATTLE_STATE_FIGHT)

			return
		end, SYSTEM_DEBUG)
		arg_3_0._dataProxy:InitAllFleetUnitsWeaponCD()
		arg_3_0._dataProxy:TirggerBattleStartBuffs()

		return
	end)()

	return
end

function var_0_2.Init(arg_6_0)
	arg_6_0._unitDataList = {}

	return
end

function var_0_2.Clear(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._unitDataList) do
		arg_7_0:UnregisterUnitEvent(iter_7_1)

		arg_7_0._unitDataList[iter_7_0] = nil
	end

	return
end

function var_0_2.Reinitialize(arg_8_0)
	arg_8_0._state:Deactive()
	arg_8_0:Clear()
	arg_8_0:Init()

	return
end

function var_0_2.Dispose(arg_9_0)
	var_0.Battle.BattleDataProxy.Update = var_0.Battle.BattleDebugConsole.ProxyUpdateNormal
	var_0.Battle.BattleDataProxy.UpdateAutoComponent = var_0.Battle.BattleDebugConsole.ProxyUpdateAutoComponentNormal

	arg_9_0:Clear()
	arg_9_0:RemoveEvent()
	var_0_2.super.Dispose(arg_9_0)

	return
end

function var_0_2.AddEvent(arg_10_0)
	arg_10_0._dataProxy:RegisterEventListener(arg_10_0, var_0_1.STAGE_DATA_INIT_FINISH, arg_10_0.onInitBattle)
	arg_10_0._dataProxy:RegisterEventListener(arg_10_0, var_0_1.ADD_UNIT, arg_10_0.onAddUnit)
	arg_10_0._dataProxy:RegisterEventListener(arg_10_0, var_0_1.REMOVE_UNIT, arg_10_0.onRemoveUnit)
	arg_10_0._dataProxy:RegisterEventListener(arg_10_0, var_0_1.SHUT_DOWN_PLAYER, arg_10_0.onPlayerShutDown)

	return
end

function var_0_2.RemoveEvent(arg_11_0)
	arg_11_0._dataProxy:UnregisterEventListener(arg_11_0, var_0_1.STAGE_DATA_INIT_FINISH)
	arg_11_0._dataProxy:UnregisterEventListener(arg_11_0, var_0_1.ADD_UNIT)
	arg_11_0._dataProxy:UnregisterEventListener(arg_11_0, var_0_1.REMOVE_UNIT)
	arg_11_0._dataProxy:UnregisterEventListener(arg_11_0, var_0_1.SHUT_DOWN_PLAYER)

	return
end

function var_0_2.onInitBattle(arg_12_0)
	arg_12_0._userFleet = arg_12_0._dataProxy:GetFleetByIFF(var_0.Battle.BattleConfig.FRIENDLY_CODE)

	return
end

function var_0_2.onAddUnit(arg_13_0, arg_13_1)
	arg_13_0:RegisterUnitEvent(arg_13_1.Data.unit)

	arg_13_0._unitDataList[arg_13_1.Data.unit:GetUniqueID()] = arg_13_1.Data.unit

	if arg_13_1.Data.type ~= var_0.Battle.BattleConst.UnitType.ENEMY_UNIT and arg_13_1.Data.type ~= var_0.Battle.BattleConst.UnitType.BOSS_UNIT and arg_13_1.Data.type ~= var_0.Battle.BattleConst.UnitType.MINION_UNIT and arg_13_1.Data.type ~= var_0.Battle.BattleConst.UnitType.NPC_UNIT and arg_13_1.Data.type == var_0.Battle.BattleConst.UnitType.BOSS_UNIT then
		-- block empty
	end

	return
end

function var_0_2.RegisterUnitEvent(arg_14_0, arg_14_1)
	arg_14_1:RegisterEventListener(arg_14_0, var_0_0.WILL_DIE, arg_14_0.onWillDie)
	arg_14_1:RegisterEventListener(arg_14_0, var_0_0.DYING, arg_14_0.onUnitDying)

	if arg_14_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_14_1:RegisterEventListener(arg_14_0, var_0_0.SHUT_DOWN_PLAYER, arg_14_0.onShutDownPlayer)
	end

	return
end

function var_0_2.UnregisterUnitEvent(arg_15_0, arg_15_1)
	arg_15_1:UnregisterEventListener(arg_15_0, var_0_0.WILL_DIE)
	arg_15_1:UnregisterEventListener(arg_15_0, var_0_0.DYING)

	if arg_15_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_15_1:UnregisterEventListener(arg_15_0, var_0_0.SHUT_DOWN_PLAYER)
	end

	return
end

function var_0_2.onRemoveUnit(arg_16_0, arg_16_1)
	if arg_16_0._unitDataList[arg_16_1.Data.UID] == nil then
		return
	end

	arg_16_0:UnregisterUnitEvent(arg_16_0._unitDataList[arg_16_1.Data.UID])

	arg_16_0._unitDataList[arg_16_1.Data.UID] = nil

	return
end

function var_0_2.onPlayerShutDown(arg_17_0, arg_17_1)
	if arg_17_1.Data.unit == arg_17_0._userFleet:GetMainList() == 0 then
		arg_17_0._dataProxy:KillAllAirStrike()
		arg_17_0._dataProxy:KillAllEnemy()
		arg_17_0._dataProxy:CLSBullet(var_0.Battle.BattleConfig.FRIENDLY_CODE)
		arg_17_0._dataProxy:CLSBullet(var_0.Battle.BattleConfig.FOE_CODE)

		for iter_17_0, iter_17_1 in ipairs(arg_17_0._dataProxy:GetInitData().MainUnitList) do
			arg_17_0._dataProxy:SpawnMain(iter_17_1, var_0.Battle.BattleConfig.FRIENDLY_CODE)
		end
	end

	if #arg_17_0._userFleet:GetScoutList() == 0 then
		arg_17_0._dataProxy:KillAllAirStrike()
		arg_17_0._dataProxy:KillAllEnemy()
		arg_17_0._dataProxy:CLSBullet(var_0.Battle.BattleConfig.FRIENDLY_CODE)
		arg_17_0._dataProxy:CLSBullet(var_0.Battle.BattleConfig.FOE_CODE)

		for iter_17_2, iter_17_3 in ipairs(arg_17_0._dataProxy:GetInitData().VanguardUnitList) do
			arg_17_0._dataProxy:SpawnVanguard(iter_17_3, var_0.Battle.BattleConfig.FRIENDLY_CODE)
		end
	end

	return
end

function var_0_2.onUnitDying(arg_18_0, arg_18_1)
	arg_18_0._dataProxy:KillUnit((arg_18_1.Dispatcher:GetUniqueID()))

	return
end

function var_0_2.onWillDie(arg_19_0, arg_19_1)
	arg_19_0._dataProxy:CalcBattleScoreWhenDead(arg_19_1.Dispatcher)

	if arg_19_1.Dispatcher:IsBoss() and not arg_19_0._dataProxy:IsThereBoss() then
		arg_19_0._dataProxy:KillAllEnemy()
	end

	return
end

function var_0_2.onShutDownPlayer(arg_20_0, arg_20_1)
	arg_20_0._dataProxy:ShutdownPlayerUnit((arg_20_1.Dispatcher:GetUniqueID()))

	return
end

return
