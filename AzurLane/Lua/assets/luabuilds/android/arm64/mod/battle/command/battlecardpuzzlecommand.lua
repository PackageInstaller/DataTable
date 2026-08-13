ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent

class = var_0_10003

local var_0_3 = var_0_10003("BattleCardPuzzleCommand", var_0.MVC.Command)

var_0.Battle.BattleCardPuzzleCommand = var_0_3
var_0_3.__name = "BattleCardPuzzleCommand"

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
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.Marching(var_3_0)

	local function var_3_1()
		local var_4_0 = arg_3_0._uiMediator
		local var_4_1 = var_0.OpeningEffect

		local function var_4_2()
			local var_5_0 = arg_3_0._dataProxy

			var_0.SetupCalculateDamage(var_5_0, var_0.Battle.BattleCardPuzzleFormulas.CreateContextCalculateDamage)

			local var_5_1 = arg_3_0._state

			var_0.ChangeState(var_5_1, var_0.Battle.BattleState.BATTLE_STATE_FIGHT)

			local var_5_2 = arg_3_0._waveUpdater

			var_0.Start(var_5_2)

			return
		end

		SYSTEM_CARDPUZZLE = var_2_10004

		var_4_1(var_4_0, var_4_2, var_2_10004)

		local var_4_3 = arg_3_0._dataProxy

		var_0.InitAllFleetUnitsWeaponCD(var_4_3)

		local var_4_4 = arg_3_0._dataProxy

		var_0.TirggerBattleStartBuffs(var_4_4)

		local var_4_5 = arg_3_0._dataProxy

		var_0.StartCardPuzzle(var_4_5)

		local var_4_6 = arg_3_0._dataProxy
		local var_4_7 = var_0.GetFleetByIFF(var_4_6, var_0.Battle.BattleConfig.FRIENDLY_CODE)

		arg_3_0._joystickBot = var_0.Battle.CardPuzzleJoyStickAutoBot.New(arg_3_0._dataProxy, var_4_7)

		local var_4_8 = arg_3_0._joystickBot

		var_1.SetActive(var_4_8, true)

		local var_4_9 = arg_3_0._state

		var_1.EnableJoystick(var_4_9, false)

		return
	end

	local var_3_2 = arg_3_0._uiMediator

	var_2.SeaSurfaceShift(var_3_2, 45, 0, nil, var_3_1)

	return
end

function var_0_3.Init(arg_6_0)
	arg_6_0._unitDataList = {}

	arg_6_0:initWaveModule()

	return
end

function var_0_3.initWaveModule(arg_7_0)
	local function var_7_0(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_7_0._dataProxy

		var_3.SpawnMonster(var_8_0, arg_8_0, arg_8_1, arg_8_2, var_0.Battle.BattleConfig.FOE_CODE)

		return
	end

	local function var_7_1(arg_9_0)
		local var_9_0 = arg_7_0._dataProxy

		var_1.SpawnAirFighter(var_9_0, arg_9_0)

		return
	end

	local function var_7_2()
		if arg_7_0._vertifyFail then
			pg = var_0

			local var_10_0 = var_0.m02
			local var_10_1 = var_0.sendNotification

			GAME = var_2_10003

			var_10_1(var_10_0, var_2_10003.CHEATER_MARK, {
				reason = arg_7_0._vertifyFail
			})

			return
		end

		local var_10_2 = arg_7_0

		var_0.CalcStatistic(var_10_2)

		local var_10_3 = arg_7_0._state

		var_0.BattleEnd(var_10_3)

		return
	end

	local function var_7_3(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
		local var_11_0 = arg_7_0._dataProxy

		var_5.SpawnCubeArea(var_11_0, var_0.Battle.BattleConst.AOEField.SURFACE, -1, arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)

		return
	end

	arg_7_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(var_7_0, var_7_1, var_7_2, var_7_3)

	return
end

function var_0_3.Clear(arg_12_0)
	pairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0._unitDataList) do
		arg_12_0:UnregisterUnitEvent(iter_12_1)

		arg_12_0._unitDataList[iter_12_0] = nil
	end

	local var_12_0 = arg_12_0._waveUpdater

	var_1.Clear(var_12_0)

	return
end

function var_0_3.Reinitialize(arg_13_0)
	local var_13_0 = arg_13_0._state

	var_1.Deactive(var_13_0)
	arg_13_0:Clear()
	arg_13_0:Init()

	return
end

function var_0_3.Dispose(arg_14_0)
	var_0.Battle.BattleDataProxy.Update = var_0.Battle.BattleDebugConsole.ProxyUpdateNormal
	var_0.Battle.BattleDataProxy.UpdateAutoComponent = var_0.Battle.BattleDebugConsole.ProxyUpdateAutoComponentNormal

	local var_14_0 = arg_14_0._joystickBot

	var_1.Dispose(var_14_0)
	arg_14_0:Clear()
	arg_14_0:RemoveEvent()
	var_0_3.super.Dispose(arg_14_0)

	return
end

function var_0_3.AddEvent(arg_15_0)
	local var_15_0 = arg_15_0._dataProxy

	var_1.RegisterEventListener(var_15_0, arg_15_0, var_0_2.STAGE_DATA_INIT_FINISH, arg_15_0.onInitBattle)

	local var_15_1 = arg_15_0._dataProxy

	var_1.RegisterEventListener(var_15_1, arg_15_0, var_0_2.ADD_UNIT, arg_15_0.onAddUnit)

	local var_15_2 = arg_15_0._dataProxy

	var_1.RegisterEventListener(var_15_2, arg_15_0, var_0_2.REMOVE_UNIT, arg_15_0.onRemoveUnit)

	local var_15_3 = arg_15_0._dataProxy

	var_1.RegisterEventListener(var_15_3, arg_15_0, var_0_2.SHUT_DOWN_PLAYER, arg_15_0.onPlayerShutDown)

	return
end

function var_0_3.RemoveEvent(arg_16_0)
	local var_16_0 = arg_16_0._dataProxy

	var_1.UnregisterEventListener(var_16_0, arg_16_0, var_0_2.STAGE_DATA_INIT_FINISH)

	local var_16_1 = arg_16_0._dataProxy

	var_1.UnregisterEventListener(var_16_1, arg_16_0, var_0_2.ADD_UNIT)

	local var_16_2 = arg_16_0._dataProxy

	var_1.UnregisterEventListener(var_16_2, arg_16_0, var_0_2.REMOVE_UNIT)

	local var_16_3 = arg_16_0._dataProxy

	var_1.UnregisterEventListener(var_16_3, arg_16_0, var_0_2.SHUT_DOWN_PLAYER)

	return
end

function var_0_3.onInitBattle(arg_17_0)
	local var_17_0 = arg_17_0._dataProxy

	arg_17_0._userFleet = var_1.GetFleetByIFF(var_17_0, var_0.Battle.BattleConfig.FRIENDLY_CODE)

	local var_17_1 = arg_17_0._waveUpdater
	local var_17_2 = var_1.SetWavesData
	local var_17_3 = arg_17_0._dataProxy

	var_17_2(var_17_1, var_4.GetStageInfo(var_17_3))

	return
end

function var_0_3.onAddUnit(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.Data.type
	local var_18_1 = arg_18_1.Data.unit

	arg_18_0:RegisterUnitEvent(var_18_1)

	arg_18_0._unitDataList[var_18_1:GetUniqueID()] = var_18_1

	if var_18_0 == var_0.Battle.BattleConst.UnitType.ENEMY_UNIT or var_18_0 == var_0.Battle.BattleConst.UnitType.BOSS_UNIT then
		local var_18_2 = arg_18_0._waveUpdater

		var_4.AddMonster(var_18_2, var_18_1)
	end

	return
end

function var_0_3.RegisterUnitEvent(arg_19_0, arg_19_1)
	arg_19_1:RegisterEventListener(arg_19_0, var_0_1.WILL_DIE, arg_19_0.onWillDie)
	arg_19_1:RegisterEventListener(arg_19_0, var_0_1.DYING, arg_19_0.onUnitDying)

	if arg_19_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_19_1:RegisterEventListener(arg_19_0, var_0_1.SHUT_DOWN_PLAYER, arg_19_0.onShutDownPlayer)
	end

	return
end

function var_0_3.UnregisterUnitEvent(arg_20_0, arg_20_1)
	arg_20_1:UnregisterEventListener(arg_20_0, var_0_1.WILL_DIE)
	arg_20_1:UnregisterEventListener(arg_20_0, var_0_1.DYING)

	if arg_20_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_20_1:UnregisterEventListener(arg_20_0, var_0_1.SHUT_DOWN_PLAYER)
	end

	return
end

function var_0_3.onRemoveUnit(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.Data.UID
	local var_21_1 = arg_21_0._waveUpdater

	var_3.RemoveMonster(var_21_1, var_21_0)

	if arg_21_0._unitDataList[var_21_0] == nil then
		return
	end

	arg_21_0:UnregisterUnitEvent(var_3)

	arg_21_0._unitDataList[var_21_0] = nil

	return
end

function var_0_3.onPlayerShutDown(arg_22_0, arg_22_1)
	arg_22_0:CalcStatistic()

	local var_22_0 = arg_22_0._state

	var_2.BattleEnd(var_22_0)

	return
end

function var_0_3.onUnitDying(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.Dispatcher
	local var_23_1 = var_2.GetUniqueID(var_23_0)
	local var_23_2 = arg_23_0._dataProxy

	var_4.KillUnit(var_23_2, var_23_1)

	return
end

function var_0_3.onWillDie(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.Dispatcher
	local var_24_1 = arg_24_0._dataProxy

	var_3.CalcBattleScoreWhenDead(var_24_1, var_24_0)

	local var_24_2 = arg_24_0._dataProxy
	local var_24_3 = var_3.IsThereBoss(var_24_2)

	if var_24_0:IsBoss() and not var_24_3 then
		local var_24_4 = arg_24_0._dataProxy

		var_4.KillAllEnemy(var_24_4)
	end

	return
end

function var_0_3.onShutDownPlayer(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1.Dispatcher
	local var_25_1 = var_2.GetUniqueID(var_25_0)
	local var_25_2 = arg_25_0._dataProxy

	var_4.ShutdownPlayerUnit(var_25_2, var_25_1)

	return
end

function var_0_3.CalcStatistic(arg_26_0)
	local var_26_0 = arg_26_0._dataProxy

	var_1.CalcCardPuzzleScoreAtEnd(var_26_0, arg_26_0._userFleet)

	return
end

return
