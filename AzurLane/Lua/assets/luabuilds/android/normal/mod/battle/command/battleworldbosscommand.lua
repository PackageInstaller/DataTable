ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent

class = var_0_10003

local var_0_3 = var_0_10003("BattleWorldBossCommand", var_0.Battle.BattleSingleDungeonCommand)

var_0.Battle.BattleWorldBossCommand = var_0_3
var_0_3.__name = "BattleWorldBossCommand"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.initWaveModule(arg_2_0)
	local function var_2_0(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_2_0._dataProxy

		var_3.SpawnMonster(var_3_0, arg_3_0, arg_3_1, arg_3_2, var_0.Battle.BattleConfig.FOE_CODE)

		return
	end

	local function var_2_1(arg_4_0)
		local var_4_0 = arg_2_0._dataProxy

		var_1.SpawnAirFighter(var_4_0, arg_4_0)

		return
	end

	local function var_2_2()
		if arg_2_0._vertifyFail then
			pg = var_0

			local var_5_0 = var_0.m02
			local var_5_1 = var_0.sendNotification

			GAME = var_2_10002

			var_5_1(var_5_0, var_2_10002.CHEATER_MARK, {
				reason = arg_2_0._vertifyFail
			})

			return
		end

		local var_5_2 = arg_2_0._dataProxy

		var_0.TriggerFinishBattle(var_5_2)

		local var_5_3 = arg_2_0

		var_0.CalcStatistic(var_5_3)

		local var_5_4 = arg_2_0

		var_0.calcDamageData(var_5_4)

		local var_5_5 = arg_2_0._state

		var_0.BattleEnd(var_5_5)

		return
	end

	local function var_2_3(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		local var_6_0 = arg_2_0._dataProxy

		var_5.SpawnCubeArea(var_6_0, var_0.Battle.BattleConst.AOEField.SURFACE, -1, arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)

		return
	end

	arg_2_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(var_2_0, var_2_1, var_2_2, var_2_3)

	return
end

function var_0_3.onInitBattle(arg_7_0)
	var_0_3.super.onInitBattle(arg_7_0)

	local var_7_0 = arg_7_0._dataProxy
	local var_7_1 = var_1.GetInitData(var_7_0)

	arg_7_0._specificEnemyList = var_0.Battle.BattleDataFunction.GetSpecificWorldJointEnemyList(var_7_1.ActID, var_7_1.bossConfigId, var_7_1.bossLevel)

	return
end

function var_0_3.onAddUnit(arg_8_0, arg_8_1)
	var_0_3.super.onAddUnit(arg_8_0, arg_8_1)

	local var_8_0 = arg_8_1.Data.unit

	table = var_3

	if var_3.contains(arg_8_0._specificEnemyList, var_8_0:GetTemplateID()) then
		local var_8_1 = arg_8_0._dataProxy

		var_3.InitSpecificEnemyStatistics(var_8_1, var_8_0)
	end

	return
end

function var_0_3.onPlayerShutDown(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._state

	if var_2.GetState(var_9_0) ~= arg_9_0._state.BATTLE_STATE_FIGHT then
		return
	end

	local var_9_1 = arg_9_1.Data.unit
	local var_9_2 = arg_9_0._userFleet

	if var_9_1 == var_3.GetFlagShip(var_9_2) then
		local var_9_3 = arg_9_0._dataProxy
		local var_9_4 = var_3.GetInitData(var_9_3).battleType

		SYSTEM_PROLOGUE = var_9_3

		if var_9_4 ~= var_9_3 then
			local var_9_5 = arg_9_0._dataProxy
			local var_9_6 = var_3.GetInitData(var_9_5).battleType

			SYSTEM_PERFORM = var_9_5

			if var_9_6 ~= var_9_5 then
				local var_9_7 = arg_9_0._dataProxy

				var_3.TriggerFinishBattle(var_9_7)
				arg_9_0:CalcStatistic()
				arg_9_0:calcDamageData()

				local var_9_8 = arg_9_0._state

				var_3.BattleEnd(var_9_8)

				return
			end
		end
	end

	local var_9_9 = arg_9_0._userFleet

	if #var_3.GetScoutList(var_9_9) == 0 then
		local var_9_10 = arg_9_0._dataProxy

		var_3.TriggerFinishBattle(var_9_10)
		arg_9_0:CalcStatistic()
		arg_9_0:calcDamageData()

		local var_9_11 = arg_9_0._state

		var_3.BattleEnd(var_9_11)
	end

	return
end

function var_0_3.onUpdateCountDown(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._dataProxy

	if var_2.GetCountDown(var_10_0) <= 0 then
		local var_10_1 = arg_10_0._dataProxy

		var_2.EnemyEscape(var_10_1)
		arg_10_0:CalcStatistic()
		arg_10_0:calcDamageData()

		local var_10_2 = arg_10_0._state

		var_2.BattleTimeUp(var_10_2)
	end

	return
end

function var_0_3.calcDamageData(arg_11_0)
	local var_11_0 = arg_11_0._dataProxy
	local var_11_1 = var_1.GetInitData(var_11_0)
	local var_11_2 = arg_11_0._dataProxy

	var_2.CalcWorldBossDamageInfo(var_11_2, var_11_1.ActID, var_11_1.bossConfigId, var_11_1.bossLevel)

	return
end

return
