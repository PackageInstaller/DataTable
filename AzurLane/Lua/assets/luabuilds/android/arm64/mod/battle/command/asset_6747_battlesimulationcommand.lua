ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent

class = var_0_10003

local var_0_3 = var_0_10003("BattleSimulationCommand", var_0.MVC.Command)

var_0.Battle.BattleSimulationCommand = var_0_3
var_0_3.__name = "BattleSimulationCommand"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.ConfigBattleData(arg_2_0, arg_2_1)
	arg_2_0._battleInitData = arg_2_1

	return
end

function var_0_3.Initialize(arg_3_0)
	arg_3_0:Init()
	var_0_3.super.Initialize(arg_3_0)

	local var_3_0 = arg_3_0._state

	arg_3_0._dataProxy = var_1.GetProxyByName(var_3_0, var_0.Battle.BattleDataProxy.__name)

	local var_3_1 = arg_3_0._state

	arg_3_0._uiMediator = var_1.GetMediatorByName(var_3_1, var_0.Battle.BattleUIMediator.__name)

	arg_3_0:InitProtocol()
	arg_3_0:AddEvent()

	return
end

function var_0_3.DoPrologue(arg_4_0)
	local var_4_0 = arg_4_0._dataProxy

	var_1.InitUserShipsData(var_4_0, arg_4_0._battleInitData.RivalMainUnitList, arg_4_0._battleInitData.RivalVanguardUnitList, var_0.Battle.BattleConfig.FOE_CODE, {})

	local var_4_1 = arg_4_0._userFleet

	var_1.SnapShot(var_4_1)

	local var_4_2 = arg_4_0._rivalFleet

	var_1.SnapShot(var_4_2)

	arg_4_0._rivalWeaponBot = var_0.Battle.BattleManualWeaponAutoBot.New(arg_4_0._rivalFleet)
	arg_4_0._rivalJoyStickBot = var_0.Battle.BattleJoyStickAutoBot.New(arg_4_0._dataProxy, arg_4_0._rivalFleet)

	local var_4_3 = arg_4_0._uiMediator

	arg_4_0._buffView = var_1.InitSimulationBuffCounting(var_4_3)

	local var_4_4 = arg_4_0._uiMediator

	var_1.OpeningEffect(var_4_4, function()
		local var_5_0 = arg_4_0._state

		var_0.ChangeState(var_5_0, var_0.Battle.BattleState.BATTLE_STATE_FIGHT)

		local var_5_1 = arg_4_0._uiMediator

		var_0.ShowAutoBtn(var_5_1)

		local var_5_2 = arg_4_0._rivalWeaponBot

		var_0.SetActive(var_5_2, true, false)

		local var_5_3 = arg_4_0._rivalJoyStickBot

		var_0.SetActive(var_5_3, true)

		local var_5_4 = arg_4_0._uiMediator

		var_0.ShowTimer(var_5_4)

		local var_5_5 = arg_4_0._uiMediator

		var_0.ShowSimulationView(var_5_5)

		return
	end)

	local var_4_5 = arg_4_0._userFleet

	var_1.FleetWarcry(var_4_5)

	local var_4_6 = arg_4_0._dataProxy

	var_1.InitAllFleetUnitsWeaponCD(var_4_6)

	local var_4_7 = arg_4_0._dataProxy

	var_1.TirggerBattleStartBuffs(var_4_7)

	local var_4_8 = arg_4_0._userFleet
	local var_4_9 = var_1.GetUnitList(var_4_8)

	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(var_4_9) do
		local var_4_10 = var_0.Battle.BattleBuffUnit.New(var_0.Battle.BattleConfig.SIMULATION_BALANCE_BUFF)

		iter_4_1:AddBuff(var_4_10)
	end

	local var_4_11 = arg_4_0._rivalFleet
	local var_4_12 = #var_2.GetScoutList(var_4_11)
	local var_4_13 = arg_4_0._rivalFleet
	local var_4_14 = var_3.GetMainList(var_4_13)
	local var_4_15

	if var_4_12 == 0 then
		arg_4_0:rivalMainUnitPhase()
	elseif var_4_12 > 0 then
		local var_4_16 = var_0.Battle.BattleConfig.SIMULATION_ADVANTAGE_BUFF

		arg_4_0._rivalDisadvatage = false
		ipairs = var_5

		for iter_4_2, iter_4_3 in var_5(var_4_14) do
			local var_4_17 = var_0.Battle.BattleBuffUnit.New(var_4_16)

			iter_4_3:AddBuff(var_4_17)
		end
	end

	arg_4_0:startBuffCount()

	local var_4_18 = arg_4_0._dataProxy
	local var_4_19 = var_5.RivalInit
	local var_4_20 = arg_4_0._rivalFleet

	var_4_19(var_4_18, var_8.GetUnitList(var_4_20))

	return
end

function var_0_3.Update(arg_6_0)
	local var_6_0 = arg_6_0._rivalWeaponBot

	var_1.Update(var_6_0)

	return
end

function var_0_3.Init(arg_7_0)
	arg_7_0._unitDataList = {}

	return
end

function var_0_3.Clear(arg_8_0)
	pairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001(arg_8_0._unitDataList) do
		arg_8_0:UnregisterUnitEvent(iter_8_1)

		arg_8_0._unitDataList[iter_8_0] = nil
	end

	return
end

function var_0_3.Reinitialize(arg_9_0)
	local var_9_0 = arg_9_0._state

	var_1.Deactive(var_9_0)
	arg_9_0:Clear()
	arg_9_0:Init()

	return
end

function var_0_3.Dispose(arg_10_0)
	arg_10_0:Clear()
	arg_10_0:RemoveEvent()
	var_0_3.super.Dispose(arg_10_0)

	return
end

function var_0_3.onInitBattle(arg_11_0)
	local var_11_0 = arg_11_0._state

	arg_11_0._weaponCommand = var_1.GetCommandByName(var_11_0, var_0.Battle.BattleControllerWeaponCommand.__name)

	local var_11_1 = arg_11_0._dataProxy

	arg_11_0._userFleet = var_1.GetFleetByIFF(var_11_1, var_0.Battle.BattleConfig.FRIENDLY_CODE)

	local var_11_2 = arg_11_0._dataProxy

	arg_11_0._rivalFleet = var_1.GetFleetByIFF(var_11_2, var_0.Battle.BattleConfig.FOE_CODE)

	return
end

function var_0_3.InitProtocol(arg_12_0)
	return
end

function var_0_3.AddEvent(arg_13_0)
	local var_13_0 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_0, arg_13_0, var_0_2.ADD_UNIT, arg_13_0.onAddUnit)

	local var_13_1 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_1, arg_13_0, var_0_2.REMOVE_UNIT, arg_13_0.onRemoveUnit)

	local var_13_2 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_2, arg_13_0, var_0_2.STAGE_DATA_INIT_FINISH, arg_13_0.onInitBattle)

	local var_13_3 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_3, arg_13_0, var_0_2.SHUT_DOWN_PLAYER, arg_13_0.onPlayerShutDown)

	local var_13_4 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_4, arg_13_0, var_0_2.UPDATE_COUNT_DOWN, arg_13_0.onUpdateCountDown)

	return
end

function var_0_3.RemoveEvent(arg_14_0)
	local var_14_0 = arg_14_0._dataProxy

	var_1.UnregisterEventListener(var_14_0, arg_14_0, var_0_2.ADD_UNIT)

	local var_14_1 = arg_14_0._dataProxy

	var_1.UnregisterEventListener(var_14_1, arg_14_0, var_0_2.REMOVE_UNIT)

	local var_14_2 = arg_14_0._dataProxy

	var_1.UnregisterEventListener(var_14_2, arg_14_0, var_0_2.STAGE_DATA_INIT_FINISH)

	local var_14_3 = arg_14_0._dataProxy

	var_1.UnregisterEventListener(var_14_3, arg_14_0, var_0_2.SHUT_DOWN_PLAYER)

	local var_14_4 = arg_14_0._dataProxy

	var_1.UnregisterEventListener(var_14_4, arg_14_0, var_0_2.UPDATE_COUNT_DOWN)

	return
end

function var_0_3.onAddUnit(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.Data.type
	local var_15_1 = arg_15_1.Data.unit

	arg_15_0:RegisterUnitEvent(var_15_1)

	arg_15_0._unitDataList[var_15_1:GetUniqueID()] = var_15_1

	return
end

function var_0_3.RegisterUnitEvent(arg_16_0, arg_16_1)
	arg_16_1:RegisterEventListener(arg_16_0, var_0_1.DYING, arg_16_0.onUnitDying)
	arg_16_1:RegisterEventListener(arg_16_0, var_0_1.UPDATE_HP, arg_16_0.onUpdateUnitHP)

	if arg_16_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_16_1:RegisterEventListener(arg_16_0, var_0_1.SHUT_DOWN_PLAYER, arg_16_0.onShutDownPlayer)
	end

	return
end

function var_0_3.UnregisterUnitEvent(arg_17_0, arg_17_1)
	arg_17_1:UnregisterEventListener(arg_17_0, var_0_1.DYING)
	arg_17_1:UnregisterEventListener(arg_17_0, var_0_1.UPDATE_HP)

	if arg_17_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_17_1:UnregisterEventListener(arg_17_0, var_0_1.SHUT_DOWN_PLAYER)
	end

	return
end

function var_0_3.onRemoveUnit(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.Data.UID

	if arg_18_0._unitDataList[var_18_0] == nil then
		return
	end

	arg_18_0:UnregisterUnitEvent(var_3)

	arg_18_0._unitDataList[var_18_0] = nil

	return
end

function var_0_3.onPlayerShutDown(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._state

	if var_2.GetState(var_19_0) ~= arg_19_0._state.BATTLE_STATE_FIGHT then
		return
	end

	if arg_19_0._failReason == nil then
		var_0.Battle.BattleState.GenerateVertifyData(1)

		local var_19_1, var_19_2 = var_0.Battle.BattleState.Vertify()

		if not var_19_1 then
			arg_19_0._failReason = 4 + var_19_2
		end
	end

	local var_19_3 = arg_19_0._rivalFleet

	if #var_2.GetUnitList(var_19_3) == 0 then
		local var_19_4 = arg_19_0._dataProxy

		var_2.CalcSimulationScoreAtEnd(var_19_4, arg_19_0._userFleet, arg_19_0._rivalFleet)

		if arg_19_0._failReason then
			pg = var_2

			local var_19_5 = var_2.m02
			local var_19_6 = var_2.sendNotification

			GAME = var_5

			var_19_6(var_19_5, var_5.CHEATER_MARK, {
				reason = arg_19_0._failReason
			})

			return
		end

		arg_19_0._failReason = nil

		local var_19_7 = arg_19_0._dataProxy

		var_2.TriggerFinishBattle(var_19_7)

		local var_19_8 = arg_19_0._state

		var_2.BattleEnd(var_19_8)
	end

	local var_19_9 = arg_19_1.Data.unit
	local var_19_10 = arg_19_0._userFleet

	if var_19_9 == var_3.GetFlagShip(var_19_10) then
		local var_19_11 = arg_19_0._dataProxy

		var_3.TriggerFinishBattle(var_19_11)

		local var_19_12 = arg_19_0._dataProxy

		var_3.CalcSimulationScoreAtEnd(var_19_12, arg_19_0._userFleet, arg_19_0._rivalFleet)

		local var_19_13 = arg_19_0._state

		var_3.BattleEnd(var_19_13)

		return
	end

	local var_19_14 = arg_19_0._userFleet

	if #var_3.GetScoutList(var_19_14) == 0 then
		local var_19_15 = arg_19_0._dataProxy

		var_4.TriggerFinishBattle(var_19_15)

		local var_19_16 = arg_19_0._dataProxy

		var_4.CalcSimulationScoreAtEnd(var_19_16, arg_19_0._userFleet, arg_19_0._rivalFleet)

		local var_19_17 = arg_19_0._state

		var_4.BattleEnd(var_19_17)
	end

	local var_19_18 = arg_19_0._rivalFleet

	if #var_4.GetScoutList(var_19_18) == 0 and not arg_19_0._rivalDisadvatage then
		arg_19_0:rivalMainUnitPhase()
	end

	return
end

function var_0_3.rivalMainUnitPhase(arg_20_0)
	arg_20_0:startBuffCount()

	arg_20_0._rivalDisadvatage = true

	local var_20_0 = arg_20_0._rivalJoyStickBot

	var_1.SetActive(var_20_0, false)

	local var_20_1 = arg_20_0._rivalFleet

	var_1.FreeMainUnit(var_20_1, var_0.Battle.BattleConfig.SIMULATION_FREE_BUFF)

	local var_20_2 = arg_20_0._rivalFleet
	local var_20_3 = var_1.GetMainList(var_20_2)

	ipairs = var_1_10002

	for iter_20_0, iter_20_1 in var_1_10002(var_20_3) do
		ipairs = var_1_10007

		for iter_20_2, iter_20_3 in var_1_10007(var_0.Battle.BattleConfig.SIMULATION_ADVANTAGE_CANCEL_LIST) do
			iter_20_1:RemoveBuff(iter_20_3)
		end

		var_1_10007 = var_0.Battle.BattleBuffUnit.New(var_0.Battle.BattleConfig.SIMULATION_DISADVANTAGE_BUFF)

		iter_20_1:AddBuff(var_1_10007)
	end

	return
end

function var_0_3.onUpdateCountDown(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._dataProxy
	local var_21_1 = var_2.GetCountDown(var_21_0)

	if arg_21_0._buffStartTime then
		if var_0.Battle.BattleConfig.SIMULATION_RIVAL_RAGE_TOTAL_COUNT - (arg_21_0._buffStartTime - var_21_1) <= 0 then
			pg = var_4

			local var_21_2 = var_4.TipsMgr.GetInstance()
			local var_21_3 = var_4.ShowTips

			i18n = var_1_10007

			var_21_3(var_21_2, var_1_10007("simulation_enhancing"))

			arg_21_0._buffStartTime = nil

			local var_21_4 = arg_21_0._buffView

			var_4.SetEnhancedText(var_21_4)
		else
			local var_21_5 = arg_21_0._buffView

			var_4.SetCountDownText(var_21_5, var_3)
		end
	end

	if var_21_1 <= 0 then
		local var_21_6 = arg_21_0._userFleet
		local var_21_7, var_21_8 = var_3.GetDamageRatioResult(var_21_6)
		local var_21_9 = arg_21_0._rivalFleet
		local var_21_10, var_21_11 = var_5.GetDamageRatioResult(var_21_9)
		local var_21_12 = arg_21_0._dataProxy

		var_7.TriggerFinishBattle(var_21_12)

		local var_21_13 = arg_21_0._dataProxy

		var_7.CalcSimulationScoreAtTimesUp(var_21_13, var_21_7, var_21_10, var_21_8, var_21_11, arg_21_0._rivalFleet)

		local var_21_14 = arg_21_0._state

		var_7.BattleEnd(var_21_14)
	end

	return
end

function var_0_3.onUpdateUnitHP(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1.Dispatcher

	if var_2.GetFleetVO(var_22_0) then
		local var_22_1 = arg_22_1.Data.validDHP

		var_3:UpdateFleetDamage(var_22_1)
	end

	return
end

function var_0_3.onUnitDying(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.Dispatcher
	local var_23_1 = var_2.GetUniqueID(var_23_0)
	local var_23_2 = arg_23_0._dataProxy

	var_4.CalcBattleScoreWhenDead(var_23_2, var_2)

	local var_23_3 = arg_23_0._dataProxy

	var_4.KillUnit(var_23_3, var_23_1)

	return
end

function var_0_3.onShutDownPlayer(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.Dispatcher
	local var_24_1 = var_2.GetUniqueID(var_24_0)
	local var_24_2 = var_2:GetFleetVO()

	var_4.UpdateFleetOverDamage(var_24_2, var_2)

	local var_24_3 = arg_24_0._dataProxy

	var_5.ShutdownPlayerUnit(var_24_3, var_24_1)

	return
end

function var_0_3.startBuffCount(arg_25_0)
	local var_25_0 = arg_25_0._dataProxy

	arg_25_0._buffStartTime = var_1.GetCountDown(var_25_0)

	return
end

return
