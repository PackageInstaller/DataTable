ys = ys or {}

local var_0_0 = ys.Battle.BattleUnitEvent
local var_0_1 = ys.Battle.BattleEvent
local var_0_2 = class("BattleCardPuzzleCommand", ys.MVC.Command)

ys.Battle.BattleCardPuzzleCommand = var_0_2
var_0_2.__name = "BattleCardPuzzleCommand"

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
	pg.UIMgr.GetInstance():Marching()
	arg_3_0._uiMediator:SeaSurfaceShift(45, 0, nil, function()
		arg_3_0._uiMediator:OpeningEffect(function()
			arg_3_0._dataProxy:SetupCalculateDamage(var_0.Battle.BattleCardPuzzleFormulas.CreateContextCalculateDamage)
			arg_3_0._state:ChangeState(var_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			arg_3_0._waveUpdater:Start()

			return
		end, SYSTEM_CARDPUZZLE)
		arg_3_0._dataProxy:InitAllFleetUnitsWeaponCD()
		arg_3_0._dataProxy:TirggerBattleStartBuffs()
		arg_3_0._dataProxy:StartCardPuzzle()

		arg_3_0._joystickBot = var_0.Battle.CardPuzzleJoyStickAutoBot.New(arg_3_0._dataProxy, (arg_3_0._dataProxy:GetFleetByIFF(var_0.Battle.BattleConfig.FRIENDLY_CODE)))

		arg_3_0._joystickBot:SetActive(true)
		arg_3_0._state:EnableJoystick(false)

		return
	end)

	return
end

function var_0_2.Init(arg_6_0)
	arg_6_0._unitDataList = {}

	arg_6_0:initWaveModule()

	return
end

function var_0_2.initWaveModule(arg_7_0)
	arg_7_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(function(arg_8_0, arg_8_1, arg_8_2)
		arg_7_0._dataProxy:SpawnMonster(arg_8_0, arg_8_1, arg_8_2, var_0.Battle.BattleConfig.FOE_CODE)

		return
	end, function(arg_9_0)
		arg_7_0._dataProxy:SpawnAirFighter(arg_9_0)

		return
	end, function()
		if arg_7_0._vertifyFail then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = arg_7_0._vertifyFail
			})

			return
		end

		arg_7_0:CalcStatistic()
		arg_7_0._state:BattleEnd()

		return
	end, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
		arg_7_0._dataProxy:SpawnCubeArea(var_0.Battle.BattleConst.AOEField.SURFACE, -1, arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)

		return
	end)

	return
end

function var_0_2.Clear(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._unitDataList) do
		arg_12_0:UnregisterUnitEvent(iter_12_1)

		arg_12_0._unitDataList[iter_12_0] = nil
	end

	arg_12_0._waveUpdater:Clear()

	return
end

function var_0_2.Reinitialize(arg_13_0)
	arg_13_0._state:Deactive()
	arg_13_0:Clear()
	arg_13_0:Init()

	return
end

function var_0_2.Dispose(arg_14_0)
	var_0.Battle.BattleDataProxy.Update = var_0.Battle.BattleDebugConsole.ProxyUpdateNormal
	var_0.Battle.BattleDataProxy.UpdateAutoComponent = var_0.Battle.BattleDebugConsole.ProxyUpdateAutoComponentNormal

	arg_14_0._joystickBot:Dispose()
	arg_14_0:Clear()
	arg_14_0:RemoveEvent()
	var_0_2.super.Dispose(arg_14_0)

	return
end

function var_0_2.AddEvent(arg_15_0)
	arg_15_0._dataProxy:RegisterEventListener(arg_15_0, var_0_1.STAGE_DATA_INIT_FINISH, arg_15_0.onInitBattle)
	arg_15_0._dataProxy:RegisterEventListener(arg_15_0, var_0_1.ADD_UNIT, arg_15_0.onAddUnit)
	arg_15_0._dataProxy:RegisterEventListener(arg_15_0, var_0_1.REMOVE_UNIT, arg_15_0.onRemoveUnit)
	arg_15_0._dataProxy:RegisterEventListener(arg_15_0, var_0_1.SHUT_DOWN_PLAYER, arg_15_0.onPlayerShutDown)

	return
end

function var_0_2.RemoveEvent(arg_16_0)
	arg_16_0._dataProxy:UnregisterEventListener(arg_16_0, var_0_1.STAGE_DATA_INIT_FINISH)
	arg_16_0._dataProxy:UnregisterEventListener(arg_16_0, var_0_1.ADD_UNIT)
	arg_16_0._dataProxy:UnregisterEventListener(arg_16_0, var_0_1.REMOVE_UNIT)
	arg_16_0._dataProxy:UnregisterEventListener(arg_16_0, var_0_1.SHUT_DOWN_PLAYER)

	return
end

function var_0_2.onInitBattle(arg_17_0)
	arg_17_0._userFleet = arg_17_0._dataProxy:GetFleetByIFF(var_0.Battle.BattleConfig.FRIENDLY_CODE)

	arg_17_0._waveUpdater:SetWavesData(arg_17_0._dataProxy:GetStageInfo())

	return
end

function var_0_2.onAddUnit(arg_18_0, arg_18_1)
	arg_18_0:RegisterUnitEvent(arg_18_1.Data.unit)

	arg_18_0._unitDataList[arg_18_1.Data.unit:GetUniqueID()] = arg_18_1.Data.unit

	if arg_18_1.Data.type == var_0.Battle.BattleConst.UnitType.ENEMY_UNIT or arg_18_1.Data.type == var_0.Battle.BattleConst.UnitType.BOSS_UNIT then
		arg_18_0._waveUpdater:AddMonster(arg_18_1.Data.unit)
	end

	return
end

function var_0_2.RegisterUnitEvent(arg_19_0, arg_19_1)
	arg_19_1:RegisterEventListener(arg_19_0, var_0_0.WILL_DIE, arg_19_0.onWillDie)
	arg_19_1:RegisterEventListener(arg_19_0, var_0_0.DYING, arg_19_0.onUnitDying)

	if arg_19_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_19_1:RegisterEventListener(arg_19_0, var_0_0.SHUT_DOWN_PLAYER, arg_19_0.onShutDownPlayer)
	end

	return
end

function var_0_2.UnregisterUnitEvent(arg_20_0, arg_20_1)
	arg_20_1:UnregisterEventListener(arg_20_0, var_0_0.WILL_DIE)
	arg_20_1:UnregisterEventListener(arg_20_0, var_0_0.DYING)

	if arg_20_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_20_1:UnregisterEventListener(arg_20_0, var_0_0.SHUT_DOWN_PLAYER)
	end

	return
end

function var_0_2.onRemoveUnit(arg_21_0, arg_21_1)
	arg_21_0._waveUpdater:RemoveMonster(arg_21_1.Data.UID)

	if arg_21_0._unitDataList[arg_21_1.Data.UID] == nil then
		return
	end

	arg_21_0:UnregisterUnitEvent(arg_21_0._unitDataList[arg_21_1.Data.UID])

	arg_21_0._unitDataList[arg_21_1.Data.UID] = nil

	return
end

function var_0_2.onPlayerShutDown(arg_22_0, arg_22_1)
	arg_22_0:CalcStatistic()
	arg_22_0._state:BattleEnd()

	return
end

function var_0_2.onUnitDying(arg_23_0, arg_23_1)
	arg_23_0._dataProxy:KillUnit((arg_23_1.Dispatcher:GetUniqueID()))

	return
end

function var_0_2.onWillDie(arg_24_0, arg_24_1)
	arg_24_0._dataProxy:CalcBattleScoreWhenDead(arg_24_1.Dispatcher)

	if arg_24_1.Dispatcher:IsBoss() and not arg_24_0._dataProxy:IsThereBoss() then
		arg_24_0._dataProxy:KillAllEnemy()
	end

	return
end

function var_0_2.onShutDownPlayer(arg_25_0, arg_25_1)
	arg_25_0._dataProxy:ShutdownPlayerUnit((arg_25_1.Dispatcher:GetUniqueID()))

	return
end

function var_0_2.CalcStatistic(arg_26_0)
	arg_26_0._dataProxy:CalcCardPuzzleScoreAtEnd(arg_26_0._userFleet)

	return
end

return
