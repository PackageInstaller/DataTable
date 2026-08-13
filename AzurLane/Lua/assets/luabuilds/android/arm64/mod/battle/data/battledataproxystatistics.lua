ys = var_0_10000

local var_0_0 = var_0_10000.Battle.BattleDataProxy

ys = var_0_10001

local var_0_1 = var_0_10001.Battle.BattleEvent

ys = var_0_10002

local var_0_2 = var_0_10002.Battle.BattleFormulas

ys = var_0_10003

local var_0_3 = var_0_10003.Battle.BattleConst

ys = var_0_10004

local var_0_4 = var_0_10004.Battle.BattleConfig

ys = var_0_10005

local var_0_5 = var_0_10005.Battle.BattleDataFunction

ys = var_0_10006

local var_0_6 = var_0_10006.Battle.BattleAttr

ys = var_0_10007

local var_0_7 = var_0_10007.Battle.BattleVariable

function var_0_0.StatisticsInit(arg_1_0, arg_1_1)
	arg_1_0._statistics = {}
	arg_1_0._statistics._battleScore = var_0_3.BattleScore.D
	arg_1_0._statistics.kill_id_list = {}
	arg_1_0._statistics._totalTime = 0
	arg_1_0._statistics._deadCount = 0
	arg_1_0._statistics._boss_destruct = 0
	arg_1_0._statistics._botPercentage = 0
	arg_1_0._statistics._maxBossHP = 0

	local var_1_0 = arg_1_0._statistics

	var_1_0._enemyInfoList = {}
	ipairs = var_1_0

	for iter_1_0, iter_1_1 in var_1_0(arg_1_1) do
		local var_1_1 = {
			id = iter_1_1:GetAttrByName("id")
		}

		var_1_1.damage = 0
		var_1_1.output = 0
		var_1_1.kill_count = 0
		var_1_1.bp = 0
		var_1_1.max_hp = iter_1_1:GetAttrByName("maxHP")
		var_1_1.maxDamageOnce = 0
		var_1_1.gearScore = iter_1_1:GetGearScore()
		arg_1_0._statistics[var_1_1.id] = var_1_1
	end

	arg_1_0._statistics._autoCount = 0

	return
end

function var_0_0.InitAidUnitStatistics(arg_2_0, arg_2_1)
	local var_2_0 = {
		id = arg_2_1:GetAttrByName("id")
	}

	var_2_0.damage = 0
	var_2_0.output = 0
	var_2_0.kill_count = 0
	var_2_0.bp = 0
	var_2_0.max_hp = arg_2_1:GetAttrByName("maxHP")
	var_2_0.maxDamageOnce = 0
	var_2_0.gearScore = arg_2_1:GetGearScore()
	arg_2_0._statistics[var_2_0.id] = var_2_0
	arg_2_0._statistics.submarineAid = true

	return
end

function var_0_0.InitSpecificEnemyStatistics(arg_3_0, arg_3_1)
	local var_3_0 = {
		id = arg_3_1:GetAttrByName("id")
	}

	var_3_0.damage = 0
	var_3_0.output = 0
	var_3_0.kill_count = 0
	var_3_0.bp = 0
	var_3_0.max_hp = arg_3_1:GetAttrByName("maxHP")
	var_3_0.init_hp = arg_3_1:GetCurrentHP()
	var_3_0.maxDamageOnce = 0
	var_3_0.gearScore = arg_3_1:GetGearScore()
	arg_3_0._statistics[var_3_0.id] = var_3_0

	return
end

function var_0_0.RivalInit(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._statistics

	var_4_0._rivalInfo = {}
	ipairs = var_4_0

	for iter_4_0, iter_4_1 in var_4_0(arg_4_1) do
		local var_4_1 = iter_4_1:GetAttrByName("id")

		arg_4_0._statistics._rivalInfo[var_4_1] = {}
		arg_4_0._statistics._rivalInfo[var_4_1].id = var_4_1
	end

	return
end

function var_0_0.DodgemCountInit(arg_5_0)
	arg_5_0._dodgemStatistics = {}
	arg_5_0._dodgemStatistics.kill = 0
	arg_5_0._dodgemStatistics.combo = 0
	arg_5_0._dodgemStatistics.miss = 0
	arg_5_0._dodgemStatistics.fail = 0
	arg_5_0._dodgemStatistics.score = 0
	arg_5_0._dodgemStatistics.maxCombo = 0

	return
end

function var_0_0.SubmarineRunInit(arg_6_0)
	arg_6_0._subRunStatistics = {}
	arg_6_0._subRunStatistics.score = 0

	return
end

function var_0_0.SetFlagShipID(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0._statistics._flagShipID = arg_7_1:GetAttrByName("id")
	end

	return
end

function var_0_0.DamageStatistics(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_0._statistics[arg_8_1] then
		arg_8_0._statistics[arg_8_1].output = arg_8_0._statistics[arg_8_1].output + arg_8_3

		local var_8_0 = arg_8_0._statistics[arg_8_1]

		math = var_5
		var_8_0.maxDamageOnce = var_5.max(arg_8_0._statistics[arg_8_1].maxDamageOnce, arg_8_3)
	end

	if arg_8_0._statistics[arg_8_2] then
		arg_8_0._statistics[arg_8_2].damage = arg_8_0._statistics[arg_8_2].damage + arg_8_3
	end

	return
end

function var_0_0.KillCountStatistics(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._statistics[arg_9_1] then
		arg_9_0._statistics[arg_9_1].kill_count = arg_9_0._statistics[arg_9_1].kill_count + 1
	end

	return
end

function var_0_0.HPRatioStatistics(arg_10_0)
	pairs = var_1_10001

	for iter_10_0, iter_10_1 in var_1_10001(arg_10_0._fleetList) do
		iter_10_1:UndoFusion()
	end

	local var_10_0 = arg_10_0._fleetList[1]
	local var_10_1 = var_1.GetUnitList(var_10_0)

	ipairs = var_2

	for iter_10_2, iter_10_3 in var_2(var_10_1) do
		local var_10_2 = arg_10_0._statistics[iter_10_3:GetAttrByName("id")]

		math = var_8
		var_10_2.bp = var_8.ceil(iter_10_3:GetHPRate() * 16)
	end

	return
end

function var_0_0.BotPercentage(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._currentStageData.timeCount - arg_11_0._countDown
	local var_11_1 = arg_11_0._statistics

	Mathf = var_1_10004

	local var_11_2 = var_1_10004.Clamp

	math = var_1_10006
	var_11_1._botPercentage = var_11_2(var_1_10006.floor(arg_11_1 / var_11_0 * 100), 0, 100)

	return
end

function var_0_0.CalcBattleScoreWhenDead(arg_12_0, arg_12_1)
	if arg_12_1:GetIFF() == var_0_4.FRIENDLY_CODE then
		table = var_3

		local var_12_0 = var_3.contains

		ShipType = var_1_10005

		if not var_12_0(var_1_10005.SubShipType, arg_12_1:GetTemplate().type) then
			arg_12_0:DelScoreWhenPlayerDead(arg_12_1)
		end
	elseif var_2 == var_0_4.FOE_CODE then
		arg_12_0:AddScoreWhenEnemyDead(arg_12_1)
	end

	return
end

function var_0_0.AddScoreWhenBossDestruct(arg_13_0)
	arg_13_0._statistics._boss_destruct = arg_13_0._statistics._boss_destruct + 1

	return
end

function var_0_0.AddScoreWhenEnemyDead(arg_14_0, arg_14_1)
	if arg_14_1:GetDeathReason() == var_0_3.UnitDeathReason.KILLED then
		arg_14_0._statistics.kill_id_list[#arg_14_0._statistics.kill_id_list + 1] = arg_14_1:GetTemplateID()
	end

	return
end

function var_0_0.DelScoreWhenPlayerDead(arg_15_0, arg_15_1)
	arg_15_0._statistics._deadCount = arg_15_0._statistics._deadCount + 1

	return
end

function var_0_0.CalcBPWhenPlayerLeave(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._statistics[arg_16_1:GetAttrByName("id")]

	math = var_3
	var_16_0.bp = var_3.ceil(arg_16_1:GetHPRate() * 16)

	return
end

function var_0_0.isTimeOut(arg_17_0)
	return arg_17_0._currentStageData.timeCount - arg_17_0._countDown >= 180
end

function var_0_0.CalcCardPuzzleScoreAtEnd(arg_18_0, arg_18_1)
	arg_18_0._statistics._deadUnit = true
	arg_18_0._statistics._badTime = true

	local var_18_0 = arg_18_1:GetCardPuzzleComponent()
	local var_18_1 = var_2.GetCurrentCommonHP(var_18_0)
	local var_18_2 = arg_18_0._statistics
	local var_18_3

	if not (var_18_1 > 0) or not var_0_3.BattleScore.S then
		var_18_3 = var_0_3.BattleScore.D
	end

	var_18_2._battleScore = var_18_3
	arg_18_0._statistics._cardPuzzleStatistics = {}
	arg_18_0._statistics._cardPuzzleStatistics.common_hp_rest = var_18_1

	local var_18_4 = arg_18_0._currentStageData.timeCount - arg_18_0._countDown

	arg_18_0._statistics._totalTime = var_18_4

	arg_18_0:AirFightInit()

	return
end

function var_0_0.CalcSingleDungeonScoreAtEnd(arg_19_0, arg_19_1)
	arg_19_0._statistics._deadUnit = true
	arg_19_0._statistics._badTime = true

	local var_19_0 = arg_19_0._currentStageData.timeCount - arg_19_0._countDown

	arg_19_0._statistics._totalTime = var_19_0

	local var_19_1 = arg_19_0._expeditionTmp.limit_type
	local var_19_2 = arg_19_0._expeditionTmp.sink_limit
	local var_19_3 = arg_19_0._expeditionTmp.time_limit

	if var_19_2 > arg_19_0._statistics._deadCount then
		arg_19_0._statistics._deadUnit = false
	end

	local var_19_4 = arg_19_1:GetFlagShip()
	local var_19_5 = arg_19_1:GetScoutList()

	if var_19_1 == 2 then
		if not var_19_4:IsAlive() or #var_19_5 <= 0 then
			arg_19_0._statistics._battleScore = var_0_3.BattleScore.D
			arg_19_0._statistics._boss_destruct = 1
		else
			arg_19_0._statistics._battleScore = var_0_3.BattleScore.S
		end
	elseif arg_19_0._countDown <= 0 then
		arg_19_0._statistics._battleScore = var_0_3.BattleScore.C
		arg_19_0._statistics._boss_destruct = 1
	elseif var_19_4 and not var_19_4:IsAlive() then
		arg_19_0._statistics._battleScore = var_0_3.BattleScore.D
		arg_19_0._statistics._boss_destruct = 1
		arg_19_0._statistics._scoreMark = var_0_3.DEAD_FLAG
	elseif #var_19_5 <= 0 then
		arg_19_0._statistics._battleScore = var_0_3.BattleScore.D
		arg_19_0._statistics._boss_destruct = 1
	else
		local var_19_6 = 0

		if arg_19_0._statistics._deadUnit then
			var_19_6 = var_19_6 + 1
		end

		if var_19_3 < var_19_0 then
			var_19_6 = var_19_6 + 1
		else
			arg_19_0._statistics._badTime = false
		end

		if arg_19_0._statistics._boss_destruct > 0 then
			var_19_6 = var_19_6 + 1
		end

		if var_19_6 >= 2 then
			arg_19_0._statistics._battleScore = var_0_3.BattleScore.B
		elseif var_19_6 == 1 then
			arg_19_0._statistics._battleScore = var_0_3.BattleScore.A
		elseif var_19_6 == 0 then
			arg_19_0._statistics._battleScore = var_0_3.BattleScore.S
		end
	end

	arg_19_0._statistics._timeout = arg_19_0:isTimeOut()

	if arg_19_0._battleInitData.CMDArgs then
		arg_19_0:CalcSpecificEnemyInfo({
			arg_19_0._battleInitData.CMDArgs
		})
	end

	return
end

function var_0_0.CalcMaxRestHPRateBossRate(arg_20_0, arg_20_1)
	arg_20_0._statistics._maxBossHP = arg_20_1

	return
end

function var_0_0.CalcDuelScoreAtTimesUp(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	arg_21_0._statistics._deadUnit = true
	arg_21_0._statistics._badTime = true
	arg_21_0._statistics._timeout = false

	local var_21_0 = arg_21_0._currentStageData.timeCount - arg_21_0._countDown

	arg_21_0._statistics._totalTime = var_21_0

	if arg_21_0._expeditionTmp.sink_limit > arg_21_0._statistics._deadCount then
		arg_21_0._statistics._deadUnit = false
	end

	if arg_21_2 < arg_21_1 then
		arg_21_0._statistics._battleScore = var_0_3.BattleScore.S
	elseif arg_21_1 < arg_21_2 then
		arg_21_0._statistics._battleScore = var_0_3.BattleScore.D
	elseif arg_21_4 <= arg_21_3 then
		arg_21_0._statistics._battleScore = var_0_3.BattleScore.S
	elseif arg_21_3 < arg_21_4 then
		arg_21_0._statistics._battleScore = var_0_3.BattleScore.D
	end

	return
end

function var_0_0.CalcDuelScoreAtEnd(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0._statistics._deadUnit = true
	arg_22_0._statistics._badTime = true

	local var_22_0 = arg_22_0._currentStageData.timeCount - arg_22_0._countDown

	arg_22_0._statistics._totalTime = var_22_0

	local var_22_1 = #arg_22_1:GetUnitList()
	local var_22_2 = #arg_22_2:GetUnitList()
	local var_22_3 = arg_22_0._expeditionTmp.sink_limit
	local var_22_4 = arg_22_0._expeditionTmp.time_limit

	if var_22_3 > arg_22_0._statistics._deadCount then
		arg_22_0._statistics._deadUnit = false
	end

	if var_22_1 == 0 then
		arg_22_0._statistics._battleScore = var_0_3.BattleScore.D
	elseif var_22_2 == 0 then
		arg_22_0._statistics._battleScore = var_0_3.BattleScore.S
	end

	arg_22_0._statistics._timeout = arg_22_0:isTimeOut()

	return
end

function var_0_0.CalcSimulationScoreAtEnd(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._statistics._deadUnit = true
	arg_23_0._statistics._badTime = true

	local var_23_0 = arg_23_0._currentStageData.timeCount - arg_23_0._countDown

	arg_23_0._statistics._totalTime = var_23_0

	local var_23_1 = #arg_23_1:GetUnitList()
	local var_23_2 = arg_23_1:GetMaxCount()
	local var_23_3 = #arg_23_1:GetScoutList()
	local var_23_4 = #arg_23_2:GetUnitList()
	local var_23_5 = arg_23_0._expeditionTmp.sink_limit
	local var_23_6 = arg_23_0._expeditionTmp.time_limit

	if arg_23_0._statistics._deadCount <= 0 then
		arg_23_0._statistics._deadUnit = false
	end

	local var_23_7 = arg_23_1:GetFlagShip()

	if not var_10.IsAlive(var_23_7) then
		arg_23_0._statistics._battleScore = var_0_3.BattleScore.D
		arg_23_0._statistics._scoreMark = var_0_3.DEAD_FLAG
	elseif var_23_3 == 0 then
		arg_23_0._statistics._battleScore = var_0_3.BattleScore.D
	elseif var_23_4 == 0 then
		arg_23_0._statistics._battleScore = var_0_3.BattleScore.S
	end

	arg_23_0._statistics._timeout = arg_23_0:isTimeOut()

	arg_23_0:overwriteRivalStatistics(arg_23_2)

	return
end

function var_0_0.CalcSimulationScoreAtTimesUp(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	arg_24_0._statistics._deadUnit = true
	arg_24_0._statistics._badTime = true
	arg_24_0._statistics._timeout = false

	local var_24_0 = arg_24_0._currentStageData.timeCount - arg_24_0._countDown

	arg_24_0._statistics._totalTime = var_24_0

	if arg_24_0._statistics._deadCount <= 0 then
		arg_24_0._statistics._deadUnit = false
	end

	arg_24_0._statistics._battleScore = var_0_3.BattleScore.D

	arg_24_0:overwriteRivalStatistics(arg_24_5)

	return
end

function var_0_0.overwriteRivalStatistics(arg_25_0, arg_25_1)
	pairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_0._statistics._rivalInfo) do
		local var_25_0 = false

		ipairs = var_1_10008

		for iter_25_2, iter_25_3 in var_1_10008(arg_25_1:GetUnitList()) do
			if iter_25_3:GetAttrByName("id") == iter_25_0 then
				math = var_13
				iter_25_1.bp = var_13.ceil(iter_25_3:GetHPRate() * 16)
				var_25_0 = true

				break
			end
		end

		if not var_25_0 then
			iter_25_1.bp = 0
		end
	end

	return
end

function var_0_0.CalcChallengeScore(arg_26_0, arg_26_1)
	if arg_26_1 then
		arg_26_0._statistics._battleScore = var_0_3.BattleScore.S
	else
		arg_26_0._statistics._battleScore = var_0_3.BattleScore.D
	end

	arg_26_0._statistics._totalTime = arg_26_0._totalTime

	return
end

function var_0_0.CalcDodgemCount(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1
	local var_27_1 = arg_27_1.GetDeathReason(var_27_0)
	local var_27_2 = arg_27_1:GetTemplate().type

	ys = var_27_0

	local var_27_3

	if var_27_1 == var_27_0.Battle.BattleConst.UnitDeathReason.CRUSH then
		var_27_3 = arg_27_0._dodgemStatistics
		var_27_3.kill = arg_27_0._dodgemStatistics.kill + 1
		ShipType = var_27_3

		if var_27_2 == var_27_3.JinBi then
			var_27_3 = arg_27_0._dodgemStatistics
			var_27_3.combo = arg_27_0._dodgemStatistics.combo + 1
			var_27_3 = arg_27_0._dodgemStatistics
			math = var_5
			var_27_3.maxCombo = var_5.max(arg_27_0._dodgemStatistics.maxCombo, arg_27_0._dodgemStatistics.combo)
			var_27_3 = arg_27_0._dodgemStatistics.score
			var_1_10007 = arg_27_0
			var_27_3 = var_27_3 + arg_27_0.GetScorePoint(var_1_10007)
			arg_27_0._dodgemStatistics.score = var_27_3
			var_1_10007 = arg_27_0

			local var_27_4 = arg_27_0.DispatchEvent

			ys = var_8

			var_27_4(var_1_10007, var_8.Event.New(var_0_1.UPDATE_DODGEM_SCORE, {
				totalScore = var_27_3
			}))
		else
			ShipType = var_27_3

			if var_27_2 == var_27_3.ZiBao then
				var_27_3 = arg_27_0._dodgemStatistics
				var_27_3.fail = arg_27_0._dodgemStatistics.fail + 1
				var_27_3 = arg_27_0._dodgemStatistics
				var_27_3.combo = 0
			end
		end

		local var_27_5 = arg_27_0

		var_27_3 = arg_27_0.DispatchEvent
		ys = var_1_10007

		var_27_3(var_27_5, var_1_10007.Event.New(var_0_1.UPDATE_DODGEM_COMBO, {
			combo = arg_27_0._dodgemStatistics.combo
		}))
	else
		ShipType = var_27_3

		if var_27_2 == var_27_3.JinBi then
			arg_27_0._dodgemStatistics.miss = arg_27_0._dodgemStatistics.miss + 1
		end
	end

	return
end

function var_0_0.GetScorePoint(arg_28_0)
	local var_28_0

	if arg_28_0._dodgemStatistics.combo == 1 then
		var_28_0 = 1
	elseif arg_28_0._dodgemStatistics.combo == 2 then
		var_28_0 = 2
	elseif arg_28_0._dodgemStatistics.combo > 2 then
		var_28_0 = 3
	end

	return var_28_0
end

function var_0_0.CalcDodgemScore(arg_29_0)
	if arg_29_0._dodgemStatistics.score >= var_0_4.BATTLE_DODGEM_PASS_SCORE then
		arg_29_0._statistics._battleScore = var_0_3.BattleScore.S
	else
		arg_29_0._statistics._battleScore = var_0_3.BattleScore.B
	end

	arg_29_0._statistics.dodgemResult = arg_29_0._dodgemStatistics

	return
end

function var_0_0.CalcActBossDamageInfo(arg_30_0, arg_30_1)
	local var_30_0 = var_0_5.GetSpecificEnemyList(arg_30_1, arg_30_0._expeditionID)

	arg_30_0:CalcSpecificEnemyInfo(var_30_0)

	return
end

function var_0_0.CalcWorldBossDamageInfo(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = var_0_5.GetSpecificWorldJointEnemyList(arg_31_1, arg_31_2, arg_31_3)

	arg_31_0:CalcSpecificEnemyInfo(var_31_0)

	return
end

function var_0_0.CalcGuildBossEnemyInfo(arg_32_0, arg_32_1)
	local var_32_0 = var_0_5.GetSpecificGuildBossEnemyList(arg_32_1, arg_32_0._expeditionID)

	arg_32_0:CalcSpecificEnemyInfo(var_32_0)

	return
end

function var_0_0.CalcSpecificEnemyInfo(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0._statistics

	var_33_0.specificDamage = 0
	ipairs = var_33_0

	for iter_33_0, iter_33_1 in var_33_0(arg_33_1) do
		if arg_33_0._statistics["enemy_" .. iter_33_1] then
			local var_33_1 = arg_33_0._statistics["enemy_" .. iter_33_1].damage

			table = var_8

			if var_8.contains(arg_33_0._statistics.kill_id_list, iter_33_1) then
				var_33_1 = arg_33_0._statistics["enemy_" .. iter_33_1].init_hp
			end

			arg_33_0._statistics.specificDamage = arg_33_0._statistics.specificDamage + var_33_1

			local var_33_2 = {
				id = iter_33_1,
				damage = var_33_1,
				totalHp = arg_33_0._statistics["enemy_" .. iter_33_1].max_hp
			}

			table = var_9

			var_9.insert(arg_33_0._statistics._enemyInfoList, var_33_2)
		end
	end

	return
end

function var_0_0.CalcKillingSupplyShip(arg_34_0)
	arg_34_0._subRunStatistics.score = arg_34_0._subRunStatistics.score + 1

	return
end

function var_0_0.CalcSubRunTimeUp(arg_35_0)
	arg_35_0._statistics._battleScore = var_0_3.BattleScore.B
	arg_35_0._statistics.subRunResult = arg_35_0._subRunStatistics

	return
end

function var_0_0.CalcSubRunScore(arg_36_0)
	arg_36_0._statistics._battleScore = var_0_3.BattleScore.S
	arg_36_0._statistics.subRunResult = arg_36_0._subRunStatistics

	return
end

function var_0_0.CalcSubRunDead(arg_37_0)
	arg_37_0._statistics._battleScore = var_0_3.BattleScore.D
	arg_37_0._statistics.subRunResult = arg_37_0._subRunStatistics

	return
end

function var_0_0.CalcKillingSupplyShip(arg_38_0)
	arg_38_0._subRunStatistics.score = arg_38_0._subRunStatistics.score + 1

	return
end

function var_0_0.CalcSubRountineTimeUp(arg_39_0)
	arg_39_0._statistics._badTime = true

	arg_39_0:CalcSubRoutineScore()

	arg_39_0._statistics._battleScore = var_0_3.BattleScore.C

	return
end

function var_0_0.CalcSubRountineElimate(arg_40_0)
	arg_40_0._statistics._elimated = true

	arg_40_0:CalcSubRoutineScore()

	arg_40_0._statistics._battleScore = var_0_3.BattleScore.D

	return
end

function var_0_0.CalcSubRoutineScore(arg_41_0)
	local var_41_0 = arg_41_0._statistics._deadCount * var_0_4.SR_CONFIG.DEAD_POINT
	local var_41_1 = arg_41_0._subRunStatistics.score * var_0_4.SR_CONFIG.POINT

	if ((arg_41_0._statistics._badTime or arg_41_0._statistics._elimated) and 0 or var_0_4.SR_CONFIG.BASE_POINT) + var_41_1 - var_41_0 >= var_0_4.SR_CONFIG.BASE_POINT + var_0_4.SR_CONFIG.M * var_0_4.SR_CONFIG.POINT then
		arg_41_0._statistics._battleScore = var_0_3.BattleScore.S
	elseif var_4 >= var_0_4.SR_CONFIG.BASE_POINT then
		arg_41_0._statistics._battleScore = var_0_3.BattleScore.A
	elseif var_4 >= var_0_4.SR_CONFIG.BASE_POINT - 2 * var_0_4.SR_CONFIG.DEAD_POINT then
		arg_41_0._statistics._battleScore = var_0_3.BattleScore.B
	else
		arg_41_0._statistics._battleScore = var_0_3.BattleScore.D
	end

	arg_41_0._subRunStatistics.basePoint = var_3
	arg_41_0._subRunStatistics.deadCount = arg_41_0._statistics._deadCount
	arg_41_0._subRunStatistics.losePoint = var_41_0
	arg_41_0._subRunStatistics.point = var_41_1
	arg_41_0._subRunStatistics.total = var_4
	arg_41_0._statistics.subRunResult = arg_41_0._subRunStatistics

	return
end

function var_0_0.AirFightInit(arg_42_0)
	arg_42_0._statistics._airFightStatistics = {}
	arg_42_0._statistics._airFightStatistics.kill = 0
	arg_42_0._statistics._airFightStatistics.score = 0
	arg_42_0._statistics._airFightStatistics.hit = 0
	arg_42_0._statistics._airFightStatistics.lose = 0
	arg_42_0._statistics._airFightStatistics.total = 0

	return
end

function var_0_0.AddAirFightScore(arg_43_0, arg_43_1)
	arg_43_0._statistics._airFightStatistics.score = arg_43_0._statistics._airFightStatistics.score + arg_43_1
	arg_43_0._statistics._airFightStatistics.kill = arg_43_0._statistics._airFightStatistics.kill + 1

	local var_43_0 = arg_43_0._statistics._airFightStatistics

	math = var_3
	var_43_0.total = var_3.max(arg_43_0._statistics._airFightStatistics.score - arg_43_0._statistics._airFightStatistics.lose, 0)

	local var_43_1 = arg_43_0
	local var_43_2 = arg_43_0.DispatchEvent

	ys = var_5

	var_43_2(var_43_1, var_5.Event.New(var_0_1.UPDATE_DODGEM_SCORE, {
		totalScore = arg_43_0._statistics._airFightStatistics.total
	}))

	return
end

function var_0_0.DecreaseAirFightScore(arg_44_0, arg_44_1)
	arg_44_0._statistics._airFightStatistics.lose = arg_44_0._statistics._airFightStatistics.lose + arg_44_1
	arg_44_0._statistics._airFightStatistics.hit = arg_44_0._statistics._airFightStatistics.hit + 1

	local var_44_0 = arg_44_0._statistics._airFightStatistics

	math = var_3
	var_44_0.total = var_3.max(arg_44_0._statistics._airFightStatistics.score - arg_44_0._statistics._airFightStatistics.lose, 0)

	local var_44_1 = arg_44_0
	local var_44_2 = arg_44_0.DispatchEvent

	ys = var_5

	var_44_2(var_44_1, var_5.Event.New(var_0_1.UPDATE_DODGEM_SCORE, {
		totalScore = arg_44_0._statistics._airFightStatistics.total
	}))

	return
end

function var_0_0.CalcAirFightScore(arg_45_0)
	arg_45_0._statistics._battleScore = var_0_3.BattleScore.S

	return
end

function var_0_0.AddScenarioSubStrikeBoss(arg_46_0, arg_46_1)
	arg_46_0._statistics._scenarioSubStrikebossUnit = arg_46_1

	return
end

function var_0_0.CalcScenarioSubStrikeScoreAtEnd(arg_47_0)
	if not arg_47_0._statistics._scenarioSubStrikebossUnit then
		arg_47_0._statistics._bossHP = 1
		arg_47_0._statistics._battleScore = var_0_3.BattleScore.C
	elseif not var_1:IsAlive() then
		arg_47_0._statistics._battleScore = var_0_3.BattleScore.S
		arg_47_0._statistics._bossHP = 0
	else
		local var_47_0 = var_1:GetHPRate()

		var_1_10003 = arg_47_0._expeditionTmp.objective_2[2] * 0.01

		local var_47_1 = arg_47_0._expeditionTmp.objective_3[2] * 0.01

		if var_47_0 < var_1_10003 then
			arg_47_0._statistics._battleScore = var_0_3.BattleScore.A
		elseif var_1_10003 <= var_47_0 and var_47_0 < var_47_1 then
			arg_47_0._statistics._battleScore = var_0_3.BattleScore.B
		elseif var_47_1 <= var_47_0 then
			arg_47_0._statistics._battleScore = var_0_3.BattleScore.C
		end

		arg_47_0._statistics._bossHP = var_47_0
	end

	local var_47_2 = 0

	pairs = var_1_10003

	for iter_47_0, iter_47_1 in var_1_10003(arg_47_0._statistics) do
		type = var_1_10008

		if var_1_10008(iter_47_1) == "table" and iter_47_1.id and iter_47_1.damage and var_47_2 < iter_47_1.damage then
			var_47_2 = iter_47_1.damage
			var_1_10008 = arg_47_0._statistics
			var_1_10008.mvpShipID = iter_47_1.id
		end
	end

	return
end

function var_0_0.AutoStatistics(arg_48_0, arg_48_1)
	if not arg_48_0._statistics._autoInit then
		arg_48_0._statistics._autoInit = not arg_48_1 and 1 or 0
	else
		arg_48_0._statistics._autoCount = arg_48_0._statistics._autoCount + 1
	end

	return
end

return
