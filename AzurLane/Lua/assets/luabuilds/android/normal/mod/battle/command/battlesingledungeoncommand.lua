ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent

class = var_0_10003

local var_0_3 = var_0_10003("BattleSingleDungeonCommand", var_0.MVC.Command)

var_0.Battle.BattleSingleDungeonCommand = var_0_3
var_0_3.__name = "BattleSingleDungeonCommand"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.Initialize(arg_2_0)
	var_0_3.super.Initialize(arg_2_0)

	local var_2_0 = arg_2_0._state

	arg_2_0._dataProxy = var_1.GetProxyByName(var_2_0, var_0.Battle.BattleDataProxy.__name)

	local var_2_1 = arg_2_0._state

	arg_2_0._uiMediator = var_1.GetUIMediator(var_2_1)

	arg_2_0:Init()
	arg_2_0:InitProtocol()
	arg_2_0:AddEvent()

	arg_2_0._count = 0

	return
end

function var_0_3.DoPrologue(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.Marching(var_3_0)

	local function var_3_1()
		local var_4_0 = arg_3_0._uiMediator

		var_0.OpeningEffect(var_4_0, function()
			local var_5_0 = arg_3_0._uiMediator

			var_0.ShowAutoBtn(var_5_0)

			local var_5_1 = arg_3_0._uiMediator

			var_0.ShowTimer(var_5_1)

			local var_5_2 = arg_3_0._state
			local var_5_3 = var_0.GetCommandByName(var_5_2, var_0.Battle.BattleControllerWeaponCommand.__name)

			var_0.TryAutoSub(var_5_3)

			local var_5_4 = arg_3_0._state

			var_1.ChangeState(var_5_4, var_0.Battle.BattleState.BATTLE_STATE_FIGHT)

			local var_5_5 = arg_3_0._waveUpdater

			var_1.Start(var_5_5)

			local var_5_6 = arg_3_0._dataProxy

			if var_1.GetInitData(var_5_6).hideAllButtons then
				local var_5_7 = arg_3_0._dataProxy

				var_1.DispatchEvent(var_5_7, var_0.Event.New(var_0.Battle.BattleEvent.HIDE_INTERACTABLE_BUTTONS, {
					isActive = false
				}))
			end

			return
		end)

		local var_4_1 = arg_3_0._dataProxy
		local var_4_2 = var_0.GetFleetByIFF(var_4_1, var_0.Battle.BattleConfig.FRIENDLY_CODE)

		var_0.FleetWarcry(var_4_2)

		local var_4_3 = arg_3_0._dataProxy

		var_1.InitAllFleetUnitsWeaponCD(var_4_3)

		local var_4_4 = arg_3_0._dataProxy

		var_1.TirggerBattleStartBuffs(var_4_4)

		local var_4_5 = arg_3_0._dataProxy

		var_1.ChapterSupportBarrage(var_4_5, var_0.Battle.BattleConfig.FRIENDLY_CODE, var_0.Battle.BattleConfig.SubSupportDelay)

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

function var_0_3.Clear(arg_7_0)
	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0._unitDataList) do
		arg_7_0:UnregisterUnitEvent(iter_7_1)

		arg_7_0._unitDataList[iter_7_0] = nil
	end

	local var_7_0 = arg_7_0._waveUpdater

	var_1.Clear(var_7_0)

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

function var_0_3.SetVertifyFail(arg_10_0, arg_10_1)
	if not arg_10_0._vertifyFail then
		arg_10_0._vertifyFail = arg_10_1
	end

	return
end

function var_0_3.onInitBattle(arg_11_0)
	local var_11_0 = arg_11_0._dataProxy

	arg_11_0._userFleet = var_1.GetFleetByIFF(var_11_0, var_0.Battle.BattleConfig.FRIENDLY_CODE)

	local var_11_1 = arg_11_0._waveUpdater
	local var_11_2 = var_1.SetWavesData
	local var_11_3 = arg_11_0._dataProxy

	var_11_2(var_11_1, var_3.GetStageInfo(var_11_3))

	return
end

function var_0_3.initWaveModule(arg_12_0)
	local function var_12_0(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_12_0._dataProxy

		var_3.SpawnMonster(var_13_0, arg_13_0, arg_13_1, arg_13_2, var_0.Battle.BattleConfig.FOE_CODE)

		return
	end

	local function var_12_1(arg_14_0)
		local var_14_0 = arg_12_0._dataProxy

		var_1.SpawnAirFighter(var_14_0, arg_14_0)

		return
	end

	local function var_12_2()
		if arg_12_0._vertifyFail then
			pg = var_0

			local var_15_0 = var_0.m02
			local var_15_1 = var_0.sendNotification

			GAME = var_2_10002

			var_15_1(var_15_0, var_2_10002.CHEATER_MARK, {
				reason = arg_12_0._vertifyFail
			})

			return
		end

		local var_15_2 = arg_12_0._dataProxy

		var_0.TriggerFinishBattle(var_15_2)

		local var_15_3 = arg_12_0

		var_0.CalcStatistic(var_15_3)

		local var_15_4 = arg_12_0._state

		var_0.BattleEnd(var_15_4)

		return
	end

	local function var_12_3(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
		local var_16_0 = arg_12_0._dataProxy

		var_5.SpawnCubeArea(var_16_0, var_0.Battle.BattleConst.AOEField.SURFACE, -1, arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)

		return
	end

	arg_12_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(var_12_0, var_12_1, var_12_2, var_12_3)

	return
end

function var_0_3.InitProtocol(arg_17_0)
	return
end

function var_0_3.AddEvent(arg_18_0)
	local var_18_0 = arg_18_0._dataProxy

	var_1.RegisterEventListener(var_18_0, arg_18_0, var_0_2.ADD_UNIT, arg_18_0.onAddUnit)

	local var_18_1 = arg_18_0._dataProxy

	var_1.RegisterEventListener(var_18_1, arg_18_0, var_0_2.REMOVE_UNIT, arg_18_0.onRemoveUnit)

	local var_18_2 = arg_18_0._dataProxy

	var_1.RegisterEventListener(var_18_2, arg_18_0, var_0_2.STAGE_DATA_INIT_FINISH, arg_18_0.onInitBattle)

	local var_18_3 = arg_18_0._dataProxy

	var_1.RegisterEventListener(var_18_3, arg_18_0, var_0_2.SHUT_DOWN_PLAYER, arg_18_0.onPlayerShutDown)

	local var_18_4 = arg_18_0._dataProxy

	var_1.RegisterEventListener(var_18_4, arg_18_0, var_0_2.UPDATE_COUNT_DOWN, arg_18_0.onUpdateCountDown)

	return
end

function var_0_3.RemoveEvent(arg_19_0)
	local var_19_0 = arg_19_0._dataProxy

	var_1.UnregisterEventListener(var_19_0, arg_19_0, var_0_2.ADD_UNIT)

	local var_19_1 = arg_19_0._dataProxy

	var_1.UnregisterEventListener(var_19_1, arg_19_0, var_0_2.REMOVE_UNIT)

	local var_19_2 = arg_19_0._dataProxy

	var_1.UnregisterEventListener(var_19_2, arg_19_0, var_0_2.STAGE_DATA_INIT_FINISH)

	local var_19_3 = arg_19_0._dataProxy

	var_1.UnregisterEventListener(var_19_3, arg_19_0, var_0_2.SHUT_DOWN_PLAYER)

	local var_19_4 = arg_19_0._dataProxy

	var_1.UnregisterEventListener(var_19_4, arg_19_0, var_0_2.UPDATE_COUNT_DOWN)

	return
end

function var_0_3.onAddUnit(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.Data.type
	local var_20_1 = arg_20_1.Data.unit

	arg_20_0:RegisterUnitEvent(var_20_1)

	arg_20_0._unitDataList[var_20_1:GetUniqueID()] = var_20_1

	if var_20_0 == var_0.Battle.BattleConst.UnitType.ENEMY_UNIT or var_20_0 == var_0.Battle.BattleConst.UnitType.BOSS_UNIT then
		local var_20_2 = arg_20_0._waveUpdater

		var_4.AddMonster(var_20_2, var_20_1)
	end

	return
end

function var_0_3.RegisterUnitEvent(arg_21_0, arg_21_1)
	if arg_21_1:GetUnitType() ~= var_0.Battle.BattleConst.UnitType.MINION_UNIT then
		arg_21_1:RegisterEventListener(arg_21_0, var_0_1.WILL_DIE, arg_21_0.onWillDie)
	end

	arg_21_1:RegisterEventListener(arg_21_0, var_0_1.DYING, arg_21_0.onUnitDying)

	if var_2 == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_21_1:RegisterEventListener(arg_21_0, var_0_1.SHUT_DOWN_PLAYER, arg_21_0.onShutDownPlayer)
	end

	return
end

function var_0_3.UnregisterUnitEvent(arg_22_0, arg_22_1)
	arg_22_1:UnregisterEventListener(arg_22_0, var_0_1.WILL_DIE)
	arg_22_1:UnregisterEventListener(arg_22_0, var_0_1.DYING)

	if arg_22_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_22_1:UnregisterEventListener(arg_22_0, var_0_1.SHUT_DOWN_PLAYER)
	end

	return
end

function var_0_3.onRemoveUnit(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.Data.UID
	local var_23_1 = arg_23_0._waveUpdater

	var_3.RemoveMonster(var_23_1, var_23_0)

	if arg_23_0._unitDataList[var_23_0] == nil then
		return
	end

	arg_23_0:UnregisterUnitEvent(var_3)

	arg_23_0._unitDataList[var_23_0] = nil

	return
end

function var_0_3.onPlayerShutDown(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._state

	if var_2.GetState(var_24_0) ~= arg_24_0._state.BATTLE_STATE_FIGHT then
		return
	end

	local var_24_1 = arg_24_1.Data.unit
	local var_24_2 = arg_24_0._userFleet

	if var_24_1 == var_3.GetFlagShip(var_24_2) then
		local var_24_3 = arg_24_0._dataProxy
		local var_24_4 = var_3.GetInitData(var_24_3).battleType

		SYSTEM_PROLOGUE = var_24_3

		if var_24_4 ~= var_24_3 then
			local var_24_5 = arg_24_0._dataProxy
			local var_24_6 = var_3.GetInitData(var_24_5).battleType

			SYSTEM_PERFORM = var_24_5

			if var_24_6 ~= var_24_5 then
				local var_24_7 = arg_24_0._dataProxy

				var_3.TriggerFinishBattle(var_24_7)
				arg_24_0:CalcStatistic()

				local var_24_8 = arg_24_0._state

				var_3.BattleEnd(var_24_8)

				return
			end
		end
	end

	local var_24_9 = arg_24_0._userFleet

	if #var_3.GetScoutList(var_24_9) == 0 then
		local var_24_10 = arg_24_0._dataProxy

		var_3.TriggerFinishBattle(var_24_10)
		arg_24_0:CalcStatistic()

		local var_24_11 = arg_24_0._state

		var_3.BattleEnd(var_24_11)
	end

	return
end

function var_0_3.onUpdateCountDown(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0._dataProxy

	if var_2.GetCountDown(var_25_0) <= 0 then
		local var_25_1 = arg_25_0._dataProxy

		var_2.EnemyEscape(var_25_1)
		arg_25_0:CalcStatistic()

		local var_25_2 = arg_25_0._state

		var_2.BattleTimeUp(var_25_2)
	end

	return
end

function var_0_3.onUnitDying(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.Dispatcher
	local var_26_1 = var_2.GetUniqueID(var_26_0)
	local var_26_2 = arg_26_0._dataProxy

	var_4.KillUnit(var_26_2, var_26_1)

	return
end

function var_0_3.onWillDie(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1.Dispatcher
	local var_27_1 = var_0.Battle.BattleConst.UnitDeathReason

	if var_27_0:GetDeathReason() == var_27_1.LEAVE then
		if var_27_0:GetIFF() == var_0.Battle.BattleConfig.FRIENDLY_CODE then
			local var_27_2 = arg_27_0._dataProxy

			var_5.CalcBPWhenPlayerLeave(var_27_2, var_27_0)
		end
	elseif var_4 == var_27_1.DESTRUCT then
		local var_27_3 = arg_27_0._dataProxy

		var_5.CalcBattleScoreWhenDead(var_27_3, var_27_0)

		if var_27_0:IsBoss() then
			local var_27_4 = arg_27_0._dataProxy

			var_5.AddScoreWhenBossDestruct(var_27_4)
		end
	else
		local var_27_5 = arg_27_0._dataProxy

		var_5.CalcBattleScoreWhenDead(var_27_5, var_27_0)
	end

	local var_27_6 = arg_27_0._dataProxy
	local var_27_7 = var_5.IsThereBoss(var_27_6)

	if var_27_0:IsBoss() and not var_27_7 then
		local var_27_8 = arg_27_0._dataProxy

		var_6.KillAllEnemy(var_27_8)
	end

	return
end

function var_0_3.onShutDownPlayer(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1.Dispatcher
	local var_28_1 = var_2.GetUniqueID(var_28_0)
	local var_28_2 = arg_28_0._dataProxy

	var_4.ShutdownPlayerUnit(var_28_2, var_28_1)

	return
end

function var_0_3.GetMaxRestHPRateBossRate(arg_29_0)
	local var_29_0 = arg_29_0._waveUpdater
	local var_29_1 = var_1.GetAllBossWave(var_29_0)

	ipairs = var_29_0

	for iter_29_0, iter_29_1 in var_29_0(var_29_1) do
		if iter_29_1:GetState() == iter_29_1.STATE_DEACTIVE then
			return 10000
		end
	end

	local var_29_2 = 0

	pairs = var_3

	local var_29_3 = arg_29_0._dataProxy

	for iter_29_2, iter_29_3 in var_3(var_4.GetUnitList(var_29_3)) do
		if iter_29_3:IsBoss() and iter_29_3:IsAlive() then
			math = var_8
			var_29_2 = var_8.max(var_29_2, iter_29_3:GetHPRate())
		end
	end

	return var_29_2 * 16
end

function var_0_3.CalcStatistic(arg_30_0)
	local var_30_0 = arg_30_0._dataProxy

	var_1.CalcSingleDungeonScoreAtEnd(var_30_0, arg_30_0._userFleet)

	local var_30_1 = arg_30_0:GetMaxRestHPRateBossRate()
	local var_30_2 = arg_30_0._dataProxy

	var_2.CalcMaxRestHPRateBossRate(var_30_2, var_30_1)

	return
end

return
