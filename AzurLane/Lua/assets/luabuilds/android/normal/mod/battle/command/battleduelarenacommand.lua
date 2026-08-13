ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent

class = var_0_10003

local var_0_3 = var_0_10003("BattleDuelArenaCommand", var_0.MVC.Command)

var_0.Battle.BattleDuelArenaCommand = var_0_3
var_0_3.__name = "BattleDuelArenaCommand"

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

	arg_2_0:InitProtocol()
	arg_2_0:AddEvent()

	return
end

function var_0_3.DoPrologue(arg_3_0)
	local var_3_0 = arg_3_0._dataProxy
	local var_3_1 = var_1.GetInitData(var_3_0)
	local var_3_2 = arg_3_0._dataProxy

	var_2.InitUserShipsData(var_3_2, var_3_1.RivalMainUnitList, var_3_1.RivalVanguardUnitList, var_0.Battle.BattleConfig.FOE_CODE, {})

	local var_3_3 = arg_3_0._userFleet

	var_2.SnapShot(var_3_3)

	local var_3_4 = arg_3_0._rivalFleet

	var_2.SnapShot(var_3_4)

	arg_3_0._rivalWeaponBot = var_0.Battle.BattleManualWeaponAutoBot.New(arg_3_0._rivalFleet)
	arg_3_0._rivalJoyStickBot = var_0.Battle.BattleJoyStickAutoBot.New(arg_3_0._dataProxy, arg_3_0._rivalFleet)

	local var_3_5 = arg_3_0._rivalJoyStickBot

	var_2.SwitchStrategy(var_3_5, arg_3_0._rivalJoyStickBot.RANDOM)

	local var_3_6 = arg_3_0._uiMediator
	local var_3_7 = var_2.InitDuelRateBar(var_3_6)

	getProxy = var_3_6
	PlayerProxy = var_4

	local var_3_8 = var_3_6(var_4)
	local var_3_9 = var_3.getData(var_3_8)

	var_3_7:SetFleetVO(arg_3_0._userFleet, {
		name = var_3_9.name,
		level = var_3_9.level
	})

	local var_3_10 = arg_3_0._dataProxy
	local var_3_11 = var_4.GetInitData(var_3_10).RivalVO

	var_3_7:SetFleetVO(arg_3_0._rivalFleet, {
		name = var_3_11.name,
		level = var_3_11.level
	})

	local var_3_12 = arg_3_0._dataProxy

	var_5.AutoStatistics(var_3_12, 1)

	local var_3_13 = arg_3_0._uiMediator

	var_5.OpeningEffect(var_3_13, function()
		local var_4_0 = arg_3_0._state

		var_0.ChangeState(var_4_0, var_0.Battle.BattleState.BATTLE_STATE_FIGHT)

		local var_4_1 = arg_3_0._weaponCommand

		var_0.ActiveBot(var_4_1, true, false)

		local var_4_2 = arg_3_0._rivalWeaponBot

		var_0.SetActive(var_4_2, true, false)

		local var_4_3 = arg_3_0._rivalJoyStickBot

		var_0.SetActive(var_4_3, true)

		local var_4_4 = arg_3_0._uiMediator

		var_0.InitCameraGestureSlider(var_4_4)

		local var_4_5 = arg_3_0._uiMediator

		var_0.ShowTimer(var_4_5)

		local var_4_6 = arg_3_0._uiMediator

		var_0.ShowDuelBar(var_4_6)

		local var_4_7 = arg_3_0._uiMediator

		var_0.EnableJoystick(var_4_7, false)

		local var_4_8 = arg_3_0._uiMediator

		var_0.EnableWeaponButton(var_4_8, false)

		return
	end)

	local var_3_14 = arg_3_0._dataProxy
	local var_3_15 = var_5.GetFleetList(var_3_14)

	pairs = var_3_14

	for iter_3_0, iter_3_1 in var_3_14(var_3_15) do
		iter_3_1:FleetWarcry()

		local var_3_16 = iter_3_1
		local var_3_17 = iter_3_1.GetUnitList(var_3_16)

		ipairs = var_3_16

		for iter_3_2, iter_3_3 in var_3_16(var_3_17) do
			local var_3_18 = iter_3_3:GetTemplate().type
			local var_3_19 = var_0.Battle.BattleDataFunction.GetArenaBuffByShipType(var_3_18)

			ipairs = var_19

			for iter_3_4, iter_3_5 in var_19(var_3_19) do
				local var_3_20 = var_0.Battle.BattleBuffUnit.New(iter_3_5)

				iter_3_3:AddBuff(var_3_20)
			end
		end
	end

	local var_3_21 = arg_3_0._uiMediator

	var_6.EnableWeaponButton(var_3_21, false)

	local var_3_22 = arg_3_0._dataProxy

	var_6.InitAllFleetUnitsWeaponCD(var_3_22)

	local var_3_23 = arg_3_0._dataProxy

	var_6.TirggerBattleStartBuffs(var_3_23)

	local var_3_24 = arg_3_0._userFleet
	local var_3_25 = var_6.GetUnitList(var_3_24)

	ipairs = var_3_24

	for iter_3_6, iter_3_7 in var_3_24(var_3_25) do
		local var_3_26 = var_0.Battle.BattleBuffUnit.New(var_0.Battle.BattleConfig.DULE_BALANCE_BUFF)

		iter_3_7:AddBuff(var_3_26)
	end

	return
end

function var_0_3.Update(arg_5_0)
	local var_5_0 = arg_5_0._rivalWeaponBot

	var_1.Update(var_5_0)

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
	arg_9_0:Clear()
	arg_9_0:RemoveEvent()
	var_0_3.super.Dispose(arg_9_0)

	return
end

function var_0_3.onInitBattle(arg_10_0)
	local var_10_0 = arg_10_0._state

	arg_10_0._weaponCommand = var_1.GetCommandByName(var_10_0, var_0.Battle.BattleControllerWeaponCommand.__name)

	local var_10_1 = arg_10_0._dataProxy

	arg_10_0._userFleet = var_1.GetFleetByIFF(var_10_1, var_0.Battle.BattleConfig.FRIENDLY_CODE)

	local var_10_2 = arg_10_0._dataProxy

	arg_10_0._rivalFleet = var_1.GetFleetByIFF(var_10_2, var_0.Battle.BattleConfig.FOE_CODE)

	return
end

function var_0_3.InitProtocol(arg_11_0)
	return
end

function var_0_3.AddEvent(arg_12_0)
	local var_12_0 = arg_12_0._dataProxy

	var_1.RegisterEventListener(var_12_0, arg_12_0, var_0_2.ADD_UNIT, arg_12_0.onAddUnit)

	local var_12_1 = arg_12_0._dataProxy

	var_1.RegisterEventListener(var_12_1, arg_12_0, var_0_2.REMOVE_UNIT, arg_12_0.onRemoveUnit)

	local var_12_2 = arg_12_0._dataProxy

	var_1.RegisterEventListener(var_12_2, arg_12_0, var_0_2.STAGE_DATA_INIT_FINISH, arg_12_0.onInitBattle)

	local var_12_3 = arg_12_0._dataProxy

	var_1.RegisterEventListener(var_12_3, arg_12_0, var_0_2.SHUT_DOWN_PLAYER, arg_12_0.onPlayerShutDown)

	local var_12_4 = arg_12_0._dataProxy

	var_1.RegisterEventListener(var_12_4, arg_12_0, var_0_2.UPDATE_COUNT_DOWN, arg_12_0.onUpdateCountDown)

	return
end

function var_0_3.RemoveEvent(arg_13_0)
	local var_13_0 = arg_13_0._dataProxy

	var_1.UnregisterEventListener(var_13_0, arg_13_0, var_0_2.ADD_UNIT)

	local var_13_1 = arg_13_0._dataProxy

	var_1.UnregisterEventListener(var_13_1, arg_13_0, var_0_2.REMOVE_UNIT)

	local var_13_2 = arg_13_0._dataProxy

	var_1.UnregisterEventListener(var_13_2, arg_13_0, var_0_2.STAGE_DATA_INIT_FINISH)

	local var_13_3 = arg_13_0._dataProxy

	var_1.UnregisterEventListener(var_13_3, arg_13_0, var_0_2.SHUT_DOWN_PLAYER)

	local var_13_4 = arg_13_0._dataProxy

	var_1.UnregisterEventListener(var_13_4, arg_13_0, var_0_2.UPDATE_COUNT_DOWN)

	return
end

function var_0_3.onAddUnit(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.Data.type
	local var_14_1 = arg_14_1.Data.unit

	arg_14_0:RegisterUnitEvent(var_14_1)

	arg_14_0._unitDataList[var_14_1:GetUniqueID()] = var_14_1

	return
end

function var_0_3.RegisterUnitEvent(arg_15_0, arg_15_1)
	arg_15_1:RegisterEventListener(arg_15_0, var_0_1.DYING, arg_15_0.onUnitDying)
	arg_15_1:RegisterEventListener(arg_15_0, var_0_1.UPDATE_HP, arg_15_0.onUpdateUnitHP)

	if arg_15_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_15_1:RegisterEventListener(arg_15_0, var_0_1.SHUT_DOWN_PLAYER, arg_15_0.onShutDownPlayer)
	end

	return
end

function var_0_3.UnregisterUnitEvent(arg_16_0, arg_16_1)
	arg_16_1:UnregisterEventListener(arg_16_0, var_0_1.DYING)
	arg_16_1:UnregisterEventListener(arg_16_0, var_0_1.UPDATE_HP)

	if arg_16_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_16_1:UnregisterEventListener(arg_16_0, var_0_1.SHUT_DOWN_PLAYER)
	end

	return
end

function var_0_3.onRemoveUnit(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.Data.UID

	if arg_17_0._unitDataList[var_17_0] == nil then
		return
	end

	arg_17_0:UnregisterUnitEvent(var_3)

	arg_17_0._unitDataList[var_17_0] = nil

	return
end

function var_0_3.onPlayerShutDown(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._state

	if var_2.GetState(var_18_0) ~= arg_18_0._state.BATTLE_STATE_FIGHT then
		return
	end

	if arg_18_0._failReason == nil then
		var_0.Battle.BattleState.GenerateVertifyData(1)

		local var_18_1, var_18_2 = var_0.Battle.BattleState.Vertify()

		if not var_18_1 then
			arg_18_0._failReason = 4 + var_18_2
		end
	end

	local var_18_3 = arg_18_0._userFleet

	if #var_2.GetUnitList(var_18_3) ~= 0 then
		local var_18_4 = arg_18_0._rivalFleet

		if #var_2.GetUnitList(var_18_4) == 0 then
			local var_18_5 = arg_18_0._dataProxy

			var_2.CalcDuelScoreAtEnd(var_18_5, arg_18_0._userFleet, arg_18_0._rivalFleet)

			if arg_18_0._failReason then
				pg = var_2

				local var_18_6 = var_2.m02
				local var_18_7 = var_2.sendNotification

				GAME = var_4

				var_18_7(var_18_6, var_4.CHEATER_MARK, {
					reason = arg_18_0._failReason
				})

				return
			end

			arg_18_0._failReason = nil

			local var_18_8 = arg_18_0._dataProxy

			var_2.TriggerFinishBattle(var_18_8)

			local var_18_9 = arg_18_0._state

			var_2.BattleEnd(var_18_9)
		end

		local var_18_10 = arg_18_0._userFleet
		local var_18_11 = #var_2.GetScoutList(var_18_10)
		local var_18_12 = arg_18_0._rivalFleet
		local var_18_13 = #var_3.GetScoutList(var_18_12)

		if var_18_11 == 0 and var_18_13 ~= 0 then
			local var_18_14 = arg_18_0._dataProxy

			var_4.ShiftFleetBound(var_18_14, arg_18_0._rivalFleet, var_0.Battle.BattleConfig.FRIENDLY_CODE)

			local var_18_15 = arg_18_0._rivalJoyStickBot

			var_4.UpdateFleetArea(var_18_15)

			local var_18_16 = arg_18_0._rivalJoyStickBot

			var_4.SwitchStrategy(var_18_16, var_0.Battle.BattleJoyStickAutoBot.COUNTER_MAIN)
		end

		if var_18_13 == 0 and var_18_11 ~= 0 then
			local var_18_17 = arg_18_0._dataProxy

			var_4.ShiftFleetBound(var_18_17, arg_18_0._userFleet, var_0.Battle.BattleConfig.FOE_CODE)

			local var_18_18 = arg_18_0._weaponCommand
			local var_18_19 = var_4.GetStickBot(var_18_18)

			var_4.UpdateFleetArea(var_18_19)

			local var_18_20 = arg_18_0._weaponCommand
			local var_18_21 = var_4.GetStickBot(var_18_20)

			var_4.SwitchStrategy(var_18_21, var_0.Battle.BattleJoyStickAutoBot.COUNTER_MAIN)
		end

		local var_18_22 = arg_18_1.Data.unit

		if not var_4.IsMainFleetUnit(var_18_22) and var_18_11 == 0 and var_18_13 == 0 then
			local var_18_23 = arg_18_0._userFleet
			local var_18_24 = var_5.GetMainList(var_18_23)
			local var_18_25 = arg_18_0._rivalFleet
			local var_18_26 = var_6.GetMainList(var_18_25)

			ipairs = var_18_25

			for iter_18_0, iter_18_1 in var_18_25(var_18_24) do
				local var_18_27 = var_0.Battle.BattleBuffUnit.New(var_0.Battle.BattleConfig.DUEL_MAIN_RAGE_BUFF)

				iter_18_1:AddBuff(var_18_27)
			end

			ipairs = var_7

			for iter_18_2, iter_18_3 in var_7(var_18_26) do
				local var_18_28 = var_0.Battle.BattleBuffUnit.New(var_0.Battle.BattleConfig.DUEL_MAIN_RAGE_BUFF)

				iter_18_3:AddBuff(var_18_28)
			end

			pg = var_7

			local var_18_29 = var_7.TipsMgr.GetInstance()
			local var_18_30 = var_7.ShowTips

			i18n = var_9

			var_18_30(var_18_29, var_9("battle_duel_main_rage"))
		end

		return
	end
end

function var_0_3.onUpdateCountDown(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._dataProxy

	if var_2.GetCountDown(var_19_0) <= 0 then
		local var_19_1 = arg_19_0._userFleet
		local var_19_2, var_19_3 = var_2.GetDamageRatioResult(var_19_1)
		local var_19_4 = arg_19_0._rivalFleet
		local var_19_5, var_19_6 = var_4.GetDamageRatioResult(var_19_4)
		local var_19_7 = arg_19_0._dataProxy

		var_6.TriggerFinishBattle(var_19_7)

		local var_19_8 = arg_19_0._dataProxy

		var_6.CalcDuelScoreAtTimesUp(var_19_8, var_19_2, var_19_5, var_19_3, var_19_6)

		local var_19_9 = arg_19_0._state

		var_6.BattleEnd(var_19_9)
	end

	return
end

function var_0_3.onUpdateUnitHP(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.Dispatcher

	if var_2.GetFleetVO(var_20_0) then
		local var_20_1 = arg_20_1.Data.validDHP

		var_3:UpdateFleetDamage(var_20_1)
	end

	return
end

function var_0_3.onUnitDying(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.Dispatcher
	local var_21_1 = var_2.GetUniqueID(var_21_0)

	if var_2:GetUnitType() ~= var_0.Battle.BattleConst.UnitType.MINION_UNIT then
		local var_21_2 = arg_21_0._dataProxy

		var_5.CalcBattleScoreWhenDead(var_21_2, var_2)
	end

	local var_21_3 = arg_21_0._dataProxy

	var_5.KillUnit(var_21_3, var_21_1)

	return
end

function var_0_3.onShutDownPlayer(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1.Dispatcher
	local var_22_1 = var_2.GetUniqueID(var_22_0)
	local var_22_2 = var_2:GetFleetVO()

	var_4.UpdateFleetOverDamage(var_22_2, var_2)

	local var_22_3 = arg_22_0._dataProxy

	var_5.ShutdownPlayerUnit(var_22_3, var_22_1)

	return
end

return
