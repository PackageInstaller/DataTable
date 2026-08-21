ys = ys or {}

local var_0_2 = class("BattleWorldBossCommand", ys.Battle.BattleSingleDungeonCommand)

ys.Battle.BattleWorldBossCommand = var_0_2
var_0_2.__name = "BattleWorldBossCommand"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.initWaveModule(arg_2_0)
	arg_2_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(function(arg_3_0, arg_3_1, arg_3_2)
		arg_2_0._dataProxy:SpawnMonster(arg_3_0, arg_3_1, arg_3_2, var_0.Battle.BattleConfig.FOE_CODE)

		return
	end, function(arg_4_0)
		arg_2_0._dataProxy:SpawnAirFighter(arg_4_0)

		return
	end, function()
		if arg_2_0._vertifyFail then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = arg_2_0._vertifyFail
			})

			return
		end

		arg_2_0._dataProxy:TriggerFinishBattle()
		arg_2_0:CalcStatistic()
		arg_2_0:calcDamageData()
		arg_2_0._state:BattleEnd()

		return
	end, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		arg_2_0._dataProxy:SpawnCubeArea(var_0.Battle.BattleConst.AOEField.SURFACE, -1, arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)

		return
	end)

	return
end

function var_0_2.onInitBattle(arg_7_0)
	var_0_2.super.onInitBattle(arg_7_0)

	local var_7_0 = arg_7_0._dataProxy:GetInitData()

	arg_7_0._specificEnemyList = var_0.Battle.BattleDataFunction.GetSpecificWorldJointEnemyList(var_7_0.ActID, var_7_0.bossConfigId, var_7_0.bossLevel)

	return
end

function var_0_2.onAddUnit(arg_8_0, arg_8_1)
	var_0_2.super.onAddUnit(arg_8_0, arg_8_1)

	if table.contains(arg_8_0._specificEnemyList, arg_8_1.Data.unit:GetTemplateID()) then
		arg_8_0._dataProxy:InitSpecificEnemyStatistics(arg_8_1.Data.unit)
	end

	return
end

function var_0_2.onPlayerShutDown(arg_9_0, arg_9_1)
	if arg_9_0._state:GetState() ~= arg_9_0._state.BATTLE_STATE_FIGHT then
		return
	end

	if arg_9_1.Data.unit == arg_9_0._userFleet:GetFlagShip() and arg_9_0._dataProxy:GetInitData().battleType ~= SYSTEM_PROLOGUE and arg_9_0._dataProxy:GetInitData().battleType ~= SYSTEM_PERFORM then
		arg_9_0._dataProxy:TriggerFinishBattle()
		arg_9_0:CalcStatistic()
		arg_9_0:calcDamageData()
		arg_9_0._state:BattleEnd()

		return
	end

	if #arg_9_0._userFleet:GetScoutList() == 0 then
		arg_9_0._dataProxy:TriggerFinishBattle()
		arg_9_0:CalcStatistic()
		arg_9_0:calcDamageData()
		arg_9_0._state:BattleEnd()
	end

	return
end

function var_0_2.onUpdateCountDown(arg_10_0, arg_10_1)
	if arg_10_0._dataProxy:GetCountDown() <= 0 then
		arg_10_0._dataProxy:EnemyEscape()
		arg_10_0:CalcStatistic()
		arg_10_0:calcDamageData()
		arg_10_0._state:BattleTimeUp()
	end

	return
end

function var_0_2.calcDamageData(arg_11_0)
	local var_11_0 = arg_11_0._dataProxy:GetInitData()

	arg_11_0._dataProxy:CalcWorldBossDamageInfo(var_11_0.ActID, var_11_0.bossConfigId, var_11_0.bossLevel)

	return
end

return
