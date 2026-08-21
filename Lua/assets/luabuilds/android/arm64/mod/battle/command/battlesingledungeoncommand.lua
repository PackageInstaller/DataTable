ys = ys or {}

local var_0_0 = ys.Battle.BattleUnitEvent
local var_0_1 = ys.Battle.BattleEvent
local var_0_2 = class("BattleSingleDungeonCommand", ys.MVC.Command)

ys.Battle.BattleSingleDungeonCommand = var_0_2
var_0_2.__name = "BattleSingleDungeonCommand"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.Initialize(arg_2_0)
	var_0_2.super.Initialize(arg_2_0)

	arg_2_0._dataProxy = arg_2_0._state:GetProxyByName(var_0.Battle.BattleDataProxy.__name)
	arg_2_0._uiMediator = arg_2_0._state:GetUIMediator()

	arg_2_0:Init()
	arg_2_0:InitProtocol()
	arg_2_0:AddEvent()

	arg_2_0._count = 0

	return
end

function var_0_2.DoPrologue(arg_3_0)
	pg.UIMgr.GetInstance():Marching()
	arg_3_0._uiMediator:SeaSurfaceShift(45, 0, nil, function()
		arg_3_0._uiMediator:OpeningEffect(function()
			arg_3_0._uiMediator:ShowAutoBtn()
			arg_3_0._uiMediator:ShowTimer()
			arg_3_0._state:GetCommandByName(var_0.Battle.BattleControllerWeaponCommand.__name):TryAutoSub()
			arg_3_0._state:ChangeState(var_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			arg_3_0._waveUpdater:Start()

			if arg_3_0._dataProxy:GetInitData().hideAllButtons then
				arg_3_0._dataProxy:DispatchEvent(var_0.Event.New(var_0.Battle.BattleEvent.HIDE_INTERACTABLE_BUTTONS, {
					isActive = false
				}))
			end

			return
		end)
		arg_3_0._dataProxy:GetFleetByIFF(var_0.Battle.BattleConfig.FRIENDLY_CODE):FleetWarcry()
		arg_3_0._dataProxy:InitAllFleetUnitsWeaponCD()
		arg_3_0._dataProxy:TirggerBattleStartBuffs()
		arg_3_0._dataProxy:ChapterSupportBarrage(var_0.Battle.BattleConfig.FRIENDLY_CODE, var_0.Battle.BattleConfig.SubSupportDelay)

		return
	end)

	return
end

function var_0_2.Init(arg_6_0)
	arg_6_0._unitDataList = {}

	arg_6_0:initWaveModule()

	return
end

function var_0_2.Clear(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._unitDataList) do
		arg_7_0:UnregisterUnitEvent(iter_7_1)

		arg_7_0._unitDataList[iter_7_0] = nil
	end

	arg_7_0._waveUpdater:Clear()

	return
end

function var_0_2.Reinitialize(arg_8_0)
	arg_8_0._state:Deactive()
	arg_8_0:Clear()
	arg_8_0:Init()

	return
end

function var_0_2.Dispose(arg_9_0)
	arg_9_0:Clear()
	arg_9_0:RemoveEvent()
	var_0_2.super.Dispose(arg_9_0)

	return
end

function var_0_2.SetVertifyFail(arg_10_0, arg_10_1)
	arg_10_0._vertifyFail = arg_10_0._vertifyFail or arg_10_1

	return
end

function var_0_2.onInitBattle(arg_11_0)
	arg_11_0._userFleet = arg_11_0._dataProxy:GetFleetByIFF(var_0.Battle.BattleConfig.FRIENDLY_CODE)

	arg_11_0._waveUpdater:SetWavesData(arg_11_0._dataProxy:GetStageInfo())

	return
end

function var_0_2.initWaveModule(arg_12_0)
	arg_12_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(function(arg_13_0, arg_13_1, arg_13_2)
		arg_12_0._dataProxy:SpawnMonster(arg_13_0, arg_13_1, arg_13_2, var_0.Battle.BattleConfig.FOE_CODE)

		return
	end, function(arg_14_0)
		arg_12_0._dataProxy:SpawnAirFighter(arg_14_0)

		return
	end, function()
		if arg_12_0._vertifyFail then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = arg_12_0._vertifyFail
			})

			return
		end

		arg_12_0._dataProxy:TriggerFinishBattle()
		arg_12_0:CalcStatistic()
		arg_12_0._state:BattleEnd()

		return
	end, function(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
		arg_12_0._dataProxy:SpawnCubeArea(var_0.Battle.BattleConst.AOEField.SURFACE, -1, arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)

		return
	end)

	return
end

function var_0_2.InitProtocol(arg_17_0)
	return
end

function var_0_2.AddEvent(arg_18_0)
	arg_18_0._dataProxy:RegisterEventListener(arg_18_0, var_0_1.ADD_UNIT, arg_18_0.onAddUnit)
	arg_18_0._dataProxy:RegisterEventListener(arg_18_0, var_0_1.REMOVE_UNIT, arg_18_0.onRemoveUnit)
	arg_18_0._dataProxy:RegisterEventListener(arg_18_0, var_0_1.STAGE_DATA_INIT_FINISH, arg_18_0.onInitBattle)
	arg_18_0._dataProxy:RegisterEventListener(arg_18_0, var_0_1.SHUT_DOWN_PLAYER, arg_18_0.onPlayerShutDown)
	arg_18_0._dataProxy:RegisterEventListener(arg_18_0, var_0_1.UPDATE_COUNT_DOWN, arg_18_0.onUpdateCountDown)

	return
end

function var_0_2.RemoveEvent(arg_19_0)
	arg_19_0._dataProxy:UnregisterEventListener(arg_19_0, var_0_1.ADD_UNIT)
	arg_19_0._dataProxy:UnregisterEventListener(arg_19_0, var_0_1.REMOVE_UNIT)
	arg_19_0._dataProxy:UnregisterEventListener(arg_19_0, var_0_1.STAGE_DATA_INIT_FINISH)
	arg_19_0._dataProxy:UnregisterEventListener(arg_19_0, var_0_1.SHUT_DOWN_PLAYER)
	arg_19_0._dataProxy:UnregisterEventListener(arg_19_0, var_0_1.UPDATE_COUNT_DOWN)

	return
end

function var_0_2.onAddUnit(arg_20_0, arg_20_1)
	arg_20_0:RegisterUnitEvent(arg_20_1.Data.unit)

	arg_20_0._unitDataList[arg_20_1.Data.unit:GetUniqueID()] = arg_20_1.Data.unit

	if arg_20_1.Data.type == var_0.Battle.BattleConst.UnitType.ENEMY_UNIT or arg_20_1.Data.type == var_0.Battle.BattleConst.UnitType.BOSS_UNIT then
		arg_20_0._waveUpdater:AddMonster(arg_20_1.Data.unit)
	end

	return
end

function var_0_2.RegisterUnitEvent(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1:GetUnitType()

	if var_21_0 ~= var_0.Battle.BattleConst.UnitType.MINION_UNIT then
		arg_21_1:RegisterEventListener(arg_21_0, var_0_0.WILL_DIE, arg_21_0.onWillDie)
	end

	arg_21_1:RegisterEventListener(arg_21_0, var_0_0.DYING, arg_21_0.onUnitDying)

	if var_21_0 == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_21_1:RegisterEventListener(arg_21_0, var_0_0.SHUT_DOWN_PLAYER, arg_21_0.onShutDownPlayer)
	end

	return
end

function var_0_2.UnregisterUnitEvent(arg_22_0, arg_22_1)
	arg_22_1:UnregisterEventListener(arg_22_0, var_0_0.WILL_DIE)
	arg_22_1:UnregisterEventListener(arg_22_0, var_0_0.DYING)

	if arg_22_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_22_1:UnregisterEventListener(arg_22_0, var_0_0.SHUT_DOWN_PLAYER)
	end

	return
end

function var_0_2.onRemoveUnit(arg_23_0, arg_23_1)
	arg_23_0._waveUpdater:RemoveMonster(arg_23_1.Data.UID)

	if arg_23_0._unitDataList[arg_23_1.Data.UID] == nil then
		return
	end

	arg_23_0:UnregisterUnitEvent(arg_23_0._unitDataList[arg_23_1.Data.UID])

	arg_23_0._unitDataList[arg_23_1.Data.UID] = nil

	return
end

function var_0_2.onPlayerShutDown(arg_24_0, arg_24_1)
	if arg_24_0._state:GetState() ~= arg_24_0._state.BATTLE_STATE_FIGHT then
		return
	end

	if arg_24_1.Data.unit == arg_24_0._userFleet:GetFlagShip() and arg_24_0._dataProxy:GetInitData().battleType ~= SYSTEM_PROLOGUE and arg_24_0._dataProxy:GetInitData().battleType ~= SYSTEM_PERFORM then
		arg_24_0._dataProxy:TriggerFinishBattle()
		arg_24_0:CalcStatistic()
		arg_24_0._state:BattleEnd()

		return
	end

	if #arg_24_0._userFleet:GetScoutList() == 0 then
		arg_24_0._dataProxy:TriggerFinishBattle()
		arg_24_0:CalcStatistic()
		arg_24_0._state:BattleEnd()
	end

	return
end

function var_0_2.onUpdateCountDown(arg_25_0, arg_25_1)
	if arg_25_0._dataProxy:GetCountDown() <= 0 then
		arg_25_0._dataProxy:EnemyEscape()
		arg_25_0:CalcStatistic()
		arg_25_0._state:BattleTimeUp()
	end

	return
end

function var_0_2.onUnitDying(arg_26_0, arg_26_1)
	arg_26_0._dataProxy:KillUnit((arg_26_1.Dispatcher:GetUniqueID()))

	return
end

function var_0_2.onWillDie(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1.Dispatcher:GetDeathReason()

	if var_27_0 == var_0.Battle.BattleConst.UnitDeathReason.LEAVE then
		if arg_27_1.Dispatcher:GetIFF() == var_0.Battle.BattleConfig.FRIENDLY_CODE then
			arg_27_0._dataProxy:CalcBPWhenPlayerLeave(arg_27_1.Dispatcher)
		end
	elseif var_27_0 == var_0.Battle.BattleConst.UnitDeathReason.DESTRUCT then
		arg_27_0._dataProxy:CalcBattleScoreWhenDead(arg_27_1.Dispatcher)

		if arg_27_1.Dispatcher:IsBoss() then
			arg_27_0._dataProxy:AddScoreWhenBossDestruct()
		end
	else
		arg_27_0._dataProxy:CalcBattleScoreWhenDead(arg_27_1.Dispatcher)
	end

	local var_27_1 = arg_27_0._dataProxy:IsThereBoss()

	if arg_27_1.Dispatcher:IsBoss() and not var_27_1 then
		arg_27_0._dataProxy:KillAllEnemy()
	end

	return
end

function var_0_2.onShutDownPlayer(arg_28_0, arg_28_1)
	arg_28_0._dataProxy:ShutdownPlayerUnit((arg_28_1.Dispatcher:GetUniqueID()))

	return
end

function var_0_2.GetMaxRestHPRateBossRate(arg_29_0)
	for iter_29_0, iter_29_1 in ipairs((arg_29_0._waveUpdater:GetAllBossWave())) do
		if iter_29_1:GetState() == iter_29_1.STATE_DEACTIVE then
			return 10000
		end
	end

	local var_29_0 = 0

	for iter_29_2, iter_29_3 in pairs(arg_29_0._dataProxy:GetUnitList()) do
		if iter_29_3:IsBoss() and iter_29_3:IsAlive() then
			var_29_0 = math.max(var_29_0, iter_29_3:GetHPRate())
		end
	end

	return var_29_0 * 16
end

function var_0_2.CalcStatistic(arg_30_0)
	arg_30_0._dataProxy:CalcSingleDungeonScoreAtEnd(arg_30_0._userFleet)
	arg_30_0._dataProxy:CalcMaxRestHPRateBossRate((arg_30_0:GetMaxRestHPRateBossRate()))

	return
end

return
