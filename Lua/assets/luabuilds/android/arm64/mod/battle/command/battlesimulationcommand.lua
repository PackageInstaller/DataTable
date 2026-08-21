ys = ys or {}

local var_0_0 = ys.Battle.BattleUnitEvent
local var_0_1 = ys.Battle.BattleEvent
local var_0_2 = class("BattleSimulationCommand", ys.MVC.Command)

ys.Battle.BattleSimulationCommand = var_0_2
var_0_2.__name = "BattleSimulationCommand"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.ConfigBattleData(arg_2_0, arg_2_1)
	arg_2_0._battleInitData = arg_2_1

	return
end

function var_0_2.Initialize(arg_3_0)
	arg_3_0:Init()
	var_0_2.super.Initialize(arg_3_0)

	arg_3_0._dataProxy = arg_3_0._state:GetProxyByName(var_0.Battle.BattleDataProxy.__name)
	arg_3_0._uiMediator = arg_3_0._state:GetMediatorByName(var_0.Battle.BattleUIMediator.__name)

	arg_3_0:InitProtocol()
	arg_3_0:AddEvent()

	return
end

function var_0_2.DoPrologue(arg_4_0)
	arg_4_0._dataProxy:InitUserShipsData(arg_4_0._battleInitData.RivalMainUnitList, arg_4_0._battleInitData.RivalVanguardUnitList, var_0.Battle.BattleConfig.FOE_CODE, {})
	arg_4_0._userFleet:SnapShot()
	arg_4_0._rivalFleet:SnapShot()

	arg_4_0._rivalWeaponBot = var_0.Battle.BattleManualWeaponAutoBot.New(arg_4_0._rivalFleet)
	arg_4_0._rivalJoyStickBot = var_0.Battle.BattleJoyStickAutoBot.New(arg_4_0._dataProxy, arg_4_0._rivalFleet)
	arg_4_0._buffView = arg_4_0._uiMediator:InitSimulationBuffCounting()

	arg_4_0._uiMediator:OpeningEffect(function()
		arg_4_0._state:ChangeState(var_0.Battle.BattleState.BATTLE_STATE_FIGHT)
		arg_4_0._uiMediator:ShowAutoBtn()
		arg_4_0._rivalWeaponBot:SetActive(true, false)
		arg_4_0._rivalJoyStickBot:SetActive(true)
		arg_4_0._uiMediator:ShowTimer()
		arg_4_0._uiMediator:ShowSimulationView()

		return
	end)
	arg_4_0._userFleet:FleetWarcry()
	arg_4_0._dataProxy:InitAllFleetUnitsWeaponCD()
	arg_4_0._dataProxy:TirggerBattleStartBuffs()

	for iter_4_0, iter_4_1 in ipairs((arg_4_0._userFleet:GetUnitList())) do
		iter_4_1:AddBuff((var_0.Battle.BattleBuffUnit.New(var_0.Battle.BattleConfig.SIMULATION_BALANCE_BUFF)))
	end

	local var_4_0 = #arg_4_0._rivalFleet:GetScoutList()

	if var_4_0 == 0 then
		arg_4_0:rivalMainUnitPhase()
	elseif var_4_0 > 0 then
		arg_4_0._rivalDisadvatage = false

		for iter_4_2, iter_4_3 in ipairs((arg_4_0._rivalFleet:GetMainList())) do
			iter_4_3:AddBuff((var_0.Battle.BattleBuffUnit.New(var_0.Battle.BattleConfig.SIMULATION_ADVANTAGE_BUFF)))
		end
	end

	arg_4_0:startBuffCount()
	arg_4_0._dataProxy:RivalInit(arg_4_0._rivalFleet:GetUnitList())

	return
end

function var_0_2.Update(arg_6_0)
	arg_6_0._rivalWeaponBot:Update()

	return
end

function var_0_2.Init(arg_7_0)
	arg_7_0._unitDataList = {}

	return
end

function var_0_2.Clear(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._unitDataList) do
		arg_8_0:UnregisterUnitEvent(iter_8_1)

		arg_8_0._unitDataList[iter_8_0] = nil
	end

	return
end

function var_0_2.Reinitialize(arg_9_0)
	arg_9_0._state:Deactive()
	arg_9_0:Clear()
	arg_9_0:Init()

	return
end

function var_0_2.Dispose(arg_10_0)
	arg_10_0:Clear()
	arg_10_0:RemoveEvent()
	var_0_2.super.Dispose(arg_10_0)

	return
end

function var_0_2.onInitBattle(arg_11_0)
	arg_11_0._weaponCommand = arg_11_0._state:GetCommandByName(var_0.Battle.BattleControllerWeaponCommand.__name)
	arg_11_0._userFleet = arg_11_0._dataProxy:GetFleetByIFF(var_0.Battle.BattleConfig.FRIENDLY_CODE)
	arg_11_0._rivalFleet = arg_11_0._dataProxy:GetFleetByIFF(var_0.Battle.BattleConfig.FOE_CODE)

	return
end

function var_0_2.InitProtocol(arg_12_0)
	return
end

function var_0_2.AddEvent(arg_13_0)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_1.ADD_UNIT, arg_13_0.onAddUnit)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_1.REMOVE_UNIT, arg_13_0.onRemoveUnit)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_1.STAGE_DATA_INIT_FINISH, arg_13_0.onInitBattle)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_1.SHUT_DOWN_PLAYER, arg_13_0.onPlayerShutDown)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_1.UPDATE_COUNT_DOWN, arg_13_0.onUpdateCountDown)

	return
end

function var_0_2.RemoveEvent(arg_14_0)
	arg_14_0._dataProxy:UnregisterEventListener(arg_14_0, var_0_1.ADD_UNIT)
	arg_14_0._dataProxy:UnregisterEventListener(arg_14_0, var_0_1.REMOVE_UNIT)
	arg_14_0._dataProxy:UnregisterEventListener(arg_14_0, var_0_1.STAGE_DATA_INIT_FINISH)
	arg_14_0._dataProxy:UnregisterEventListener(arg_14_0, var_0_1.SHUT_DOWN_PLAYER)
	arg_14_0._dataProxy:UnregisterEventListener(arg_14_0, var_0_1.UPDATE_COUNT_DOWN)

	return
end

function var_0_2.onAddUnit(arg_15_0, arg_15_1)
	arg_15_0:RegisterUnitEvent(arg_15_1.Data.unit)

	arg_15_0._unitDataList[arg_15_1.Data.unit:GetUniqueID()] = arg_15_1.Data.unit

	return
end

function var_0_2.RegisterUnitEvent(arg_16_0, arg_16_1)
	arg_16_1:RegisterEventListener(arg_16_0, var_0_0.DYING, arg_16_0.onUnitDying)
	arg_16_1:RegisterEventListener(arg_16_0, var_0_0.UPDATE_HP, arg_16_0.onUpdateUnitHP)

	if arg_16_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_16_1:RegisterEventListener(arg_16_0, var_0_0.SHUT_DOWN_PLAYER, arg_16_0.onShutDownPlayer)
	end

	return
end

function var_0_2.UnregisterUnitEvent(arg_17_0, arg_17_1)
	arg_17_1:UnregisterEventListener(arg_17_0, var_0_0.DYING)
	arg_17_1:UnregisterEventListener(arg_17_0, var_0_0.UPDATE_HP)

	if arg_17_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_17_1:UnregisterEventListener(arg_17_0, var_0_0.SHUT_DOWN_PLAYER)
	end

	return
end

function var_0_2.onRemoveUnit(arg_18_0, arg_18_1)
	if arg_18_0._unitDataList[arg_18_1.Data.UID] == nil then
		return
	end

	arg_18_0:UnregisterUnitEvent(arg_18_0._unitDataList[arg_18_1.Data.UID])

	arg_18_0._unitDataList[arg_18_1.Data.UID] = nil

	return
end

function var_0_2.onPlayerShutDown(arg_19_0, arg_19_1)
	if arg_19_0._state:GetState() ~= arg_19_0._state.BATTLE_STATE_FIGHT then
		return
	end

	if arg_19_0._failReason == nil then
		var_0.Battle.BattleState.GenerateVertifyData(1)

		local var_19_0, var_19_1 = var_0.Battle.BattleState.Vertify()

		if not var_19_0 then
			arg_19_0._failReason = 4 + var_19_1
		end
	end

	if #arg_19_0._rivalFleet:GetUnitList() == 0 then
		arg_19_0._dataProxy:CalcSimulationScoreAtEnd(arg_19_0._userFleet, arg_19_0._rivalFleet)

		if arg_19_0._failReason then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = arg_19_0._failReason
			})

			return
		end

		arg_19_0._failReason = nil

		arg_19_0._dataProxy:TriggerFinishBattle()
		arg_19_0._state:BattleEnd()
	end

	if arg_19_1.Data.unit == arg_19_0._userFleet:GetFlagShip() then
		arg_19_0._dataProxy:TriggerFinishBattle()
		arg_19_0._dataProxy:CalcSimulationScoreAtEnd(arg_19_0._userFleet, arg_19_0._rivalFleet)
		arg_19_0._state:BattleEnd()

		return
	end

	if #arg_19_0._userFleet:GetScoutList() == 0 then
		arg_19_0._dataProxy:TriggerFinishBattle()
		arg_19_0._dataProxy:CalcSimulationScoreAtEnd(arg_19_0._userFleet, arg_19_0._rivalFleet)
		arg_19_0._state:BattleEnd()
	end

	if #arg_19_0._rivalFleet:GetScoutList() == 0 and not arg_19_0._rivalDisadvatage then
		arg_19_0:rivalMainUnitPhase()
	end

	return
end

function var_0_2.rivalMainUnitPhase(arg_20_0)
	arg_20_0:startBuffCount()

	arg_20_0._rivalDisadvatage = true

	arg_20_0._rivalJoyStickBot:SetActive(false)
	arg_20_0._rivalFleet:FreeMainUnit(var_0.Battle.BattleConfig.SIMULATION_FREE_BUFF)

	for iter_20_0, iter_20_1 in ipairs((arg_20_0._rivalFleet:GetMainList())) do
		for iter_20_2, iter_20_3 in ipairs(var_0.Battle.BattleConfig.SIMULATION_ADVANTAGE_CANCEL_LIST) do
			iter_20_1:RemoveBuff(iter_20_3)
		end

		iter_20_1:AddBuff((var_0.Battle.BattleBuffUnit.New(var_0.Battle.BattleConfig.SIMULATION_DISADVANTAGE_BUFF)))
	end

	return
end

function var_0_2.onUpdateCountDown(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._dataProxy:GetCountDown()

	if arg_21_0._buffStartTime then
		if var_0.Battle.BattleConfig.SIMULATION_RIVAL_RAGE_TOTAL_COUNT - (arg_21_0._buffStartTime - var_21_0) <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("simulation_enhancing"))

			arg_21_0._buffStartTime = nil

			arg_21_0._buffView:SetEnhancedText()
		else
			arg_21_0._buffView:SetCountDownText(var_0.Battle.BattleConfig.SIMULATION_RIVAL_RAGE_TOTAL_COUNT - (arg_21_0._buffStartTime - var_21_0))
		end
	end

	if var_21_0 <= 0 then
		local var_21_1, var_21_2 = arg_21_0._userFleet:GetDamageRatioResult()
		local var_21_3, var_21_4 = arg_21_0._rivalFleet:GetDamageRatioResult()

		arg_21_0._dataProxy:TriggerFinishBattle()
		arg_21_0._dataProxy:CalcSimulationScoreAtTimesUp(var_21_1, var_21_3, var_21_2, var_21_4, arg_21_0._rivalFleet)
		arg_21_0._state:BattleEnd()
	end

	return
end

function var_0_2.onUpdateUnitHP(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1.Dispatcher:GetFleetVO()

	if var_22_0 then
		var_22_0:UpdateFleetDamage(arg_22_1.Data.validDHP)
	end

	return
end

function var_0_2.onUnitDying(arg_23_0, arg_23_1)
	arg_23_0._dataProxy:CalcBattleScoreWhenDead(arg_23_1.Dispatcher)
	arg_23_0._dataProxy:KillUnit((arg_23_1.Dispatcher:GetUniqueID()))

	return
end

function var_0_2.onShutDownPlayer(arg_24_0, arg_24_1)
	arg_24_1.Dispatcher:GetFleetVO():UpdateFleetOverDamage(arg_24_1.Dispatcher)
	arg_24_0._dataProxy:ShutdownPlayerUnit((arg_24_1.Dispatcher:GetUniqueID()))

	return
end

function var_0_2.startBuffCount(arg_25_0)
	arg_25_0._buffStartTime = arg_25_0._dataProxy:GetCountDown()

	return
end

return
