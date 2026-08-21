local var_0_0 = ys.Battle.BattleEvent
local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleConfig
local var_0_4 = ys.Battle.BattleDataFunction

function ys.Battle.BattleDataProxy.StatisticsInit(arg_1_0, arg_1_1)
	arg_1_0._statistics = {}
	arg_1_0._statistics._battleScore = var_0_2.BattleScore.D
	arg_1_0._statistics.kill_id_list = {}
	arg_1_0._statistics._totalTime = 0
	arg_1_0._statistics._deadCount = 0
	arg_1_0._statistics._boss_destruct = 0
	arg_1_0._statistics._botPercentage = 0
	arg_1_0._statistics._maxBossHP = 0
	arg_1_0._statistics._enemyInfoList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		local var_1_0 = {
			id = iter_1_1:GetAttrByName("id")
		}

		var_1_0.damage = 0
		var_1_0.output = 0
		var_1_0.kill_count = 0
		var_1_0.bp = 0
		var_1_0.max_hp = iter_1_1:GetAttrByName("maxHP")
		var_1_0.maxDamageOnce = 0
		var_1_0.gearScore = iter_1_1:GetGearScore()
		arg_1_0._statistics[var_1_0.id] = var_1_0
	end

	arg_1_0._statistics._autoCount = 0

	return
end

function ys.Battle.BattleDataProxy.InitAidUnitStatistics(arg_2_0, arg_2_1)
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

function ys.Battle.BattleDataProxy.InitSpecificEnemyStatistics(arg_3_0, arg_3_1)
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

function ys.Battle.BattleDataProxy.RivalInit(arg_4_0, arg_4_1)
	arg_4_0._statistics._rivalInfo = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = iter_4_1:GetAttrByName("id")

		arg_4_0._statistics._rivalInfo[var_4_0] = {}
		arg_4_0._statistics._rivalInfo[var_4_0].id = var_4_0
	end

	return
end

function ys.Battle.BattleDataProxy.DodgemCountInit(arg_5_0)
	arg_5_0._dodgemStatistics = {}
	arg_5_0._dodgemStatistics.kill = 0
	arg_5_0._dodgemStatistics.combo = 0
	arg_5_0._dodgemStatistics.miss = 0
	arg_5_0._dodgemStatistics.fail = 0
	arg_5_0._dodgemStatistics.score = 0
	arg_5_0._dodgemStatistics.maxCombo = 0

	return
end

function ys.Battle.BattleDataProxy.SubmarineRunInit(arg_6_0)
	arg_6_0._subRunStatistics = {}
	arg_6_0._subRunStatistics.score = 0

	return
end

function ys.Battle.BattleDataProxy.SetFlagShipID(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0._statistics._flagShipID = arg_7_1:GetAttrByName("id")
	end

	return
end

function ys.Battle.BattleDataProxy.DamageStatistics(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_0._statistics[arg_8_1] then
		arg_8_0._statistics[arg_8_1].output = arg_8_0._statistics[arg_8_1].output + arg_8_3
		arg_8_0._statistics[arg_8_1].maxDamageOnce = math.max(arg_8_0._statistics[arg_8_1].maxDamageOnce, arg_8_3)
	end

	if arg_8_0._statistics[arg_8_2] then
		arg_8_0._statistics[arg_8_2].damage = arg_8_0._statistics[arg_8_2].damage + arg_8_3
	end

	return
end

function ys.Battle.BattleDataProxy.KillCountStatistics(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._statistics[arg_9_1] then
		arg_9_0._statistics[arg_9_1].kill_count = arg_9_0._statistics[arg_9_1].kill_count + 1
	end

	return
end

function ys.Battle.BattleDataProxy.HPRatioStatistics(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._fleetList) do
		iter_10_1:UndoFusion()
	end

	for iter_10_2, iter_10_3 in ipairs((arg_10_0._fleetList[1]:GetUnitList())) do
		arg_10_0._statistics[iter_10_3:GetAttrByName("id")].bp = math.ceil(iter_10_3:GetHPRate() * 16)
	end

	return
end

function ys.Battle.BattleDataProxy.BotPercentage(arg_11_0, arg_11_1)
	arg_11_0._statistics._botPercentage = Mathf.Clamp(math.floor(arg_11_1 / (arg_11_0._currentStageData.timeCount - arg_11_0._countDown) * 100), 0, 100)

	return
end

function ys.Battle.BattleDataProxy.CalcBattleScoreWhenDead(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:GetIFF()

	if var_12_0 == var_0_3.FRIENDLY_CODE then
		if not table.contains(ShipType.SubShipType, arg_12_1:GetTemplate().type) then
			arg_12_0:DelScoreWhenPlayerDead(arg_12_1)
		end
	elseif var_12_0 == var_0_3.FOE_CODE then
		arg_12_0:AddScoreWhenEnemyDead(arg_12_1)
	end

	return
end

function ys.Battle.BattleDataProxy.AddScoreWhenBossDestruct(arg_13_0)
	arg_13_0._statistics._boss_destruct = arg_13_0._statistics._boss_destruct + 1

	return
end

function ys.Battle.BattleDataProxy.AddScoreWhenEnemyDead(arg_14_0, arg_14_1)
	if arg_14_1:GetDeathReason() == var_0_2.UnitDeathReason.KILLED then
		arg_14_0._statistics.kill_id_list[#arg_14_0._statistics.kill_id_list + 1] = arg_14_1:GetTemplateID()
	end

	return
end

function ys.Battle.BattleDataProxy.DelScoreWhenPlayerDead(arg_15_0, arg_15_1)
	arg_15_0._statistics._deadCount = arg_15_0._statistics._deadCount + 1

	return
end

function ys.Battle.BattleDataProxy.CalcBPWhenPlayerLeave(arg_16_0, arg_16_1)
	arg_16_0._statistics[arg_16_1:GetAttrByName("id")].bp = math.ceil(arg_16_1:GetHPRate() * 16)

	return
end

function ys.Battle.BattleDataProxy.isTimeOut(arg_17_0)
	return arg_17_0._currentStageData.timeCount - arg_17_0._countDown >= 180
end

function ys.Battle.BattleDataProxy.CalcCardPuzzleScoreAtEnd(arg_18_0, arg_18_1)
	arg_18_0._statistics._deadUnit = true
	arg_18_0._statistics._badTime = true

	local var_18_0 = arg_18_1:GetCardPuzzleComponent():GetCurrentCommonHP()
	local var_18_1 = arg_18_0._statistics

	if var_18_0 > 0 then
		var_18_1._battleScore = var_0_2.BattleScore.S or var_0_2.BattleScore.D
		arg_18_0._statistics._cardPuzzleStatistics = {}
		arg_18_0._statistics._cardPuzzleStatistics.common_hp_rest = var_18_0
		arg_18_0._statistics._totalTime = arg_18_0._currentStageData.timeCount - arg_18_0._countDown

		arg_18_0:AirFightInit()

		return
	end
end

function ys.Battle.BattleDataProxy.CalcSingleDungeonScoreAtEnd(arg_19_0, arg_19_1)
	arg_19_0._statistics._deadUnit = true
	arg_19_0._statistics._badTime = true
	arg_19_0._statistics._totalTime = arg_19_0._currentStageData.timeCount - arg_19_0._countDown

	if arg_19_0._expeditionTmp.sink_limit > arg_19_0._statistics._deadCount then
		arg_19_0._statistics._deadUnit = false
	end

	local var_19_0 = arg_19_1:GetFlagShip()
	local var_19_1 = arg_19_1:GetScoutList()

	if arg_19_0._expeditionTmp.limit_type == 2 then
		if not var_19_0:IsAlive() or #var_19_1 <= 0 then
			arg_19_0._statistics._battleScore = var_0_2.BattleScore.D
			arg_19_0._statistics._boss_destruct = 1
		else
			arg_19_0._statistics._battleScore = var_0_2.BattleScore.S
		end
	elseif arg_19_0._countDown <= 0 then
		arg_19_0._statistics._battleScore = var_0_2.BattleScore.C
		arg_19_0._statistics._boss_destruct = 1
	elseif var_19_0 and not var_19_0:IsAlive() then
		arg_19_0._statistics._battleScore = var_0_2.BattleScore.D
		arg_19_0._statistics._boss_destruct = 1
		arg_19_0._statistics._scoreMark = var_0_2.DEAD_FLAG
	elseif #var_19_1 <= 0 then
		arg_19_0._statistics._battleScore = var_0_2.BattleScore.D
		arg_19_0._statistics._boss_destruct = 1
	else
		local var_19_2 = 0

		if arg_19_0._statistics._deadUnit then
			var_19_2 = var_19_2 + 1
		end

		if arg_19_0._expeditionTmp.time_limit < arg_19_0._currentStageData.timeCount - arg_19_0._countDown then
			var_19_2 = var_19_2 + 1
		else
			arg_19_0._statistics._badTime = false
		end

		if arg_19_0._statistics._boss_destruct > 0 then
			var_19_2 = var_19_2 + 1
		end

		if var_19_2 >= 2 then
			arg_19_0._statistics._battleScore = var_0_2.BattleScore.B
		elseif var_19_2 == 1 then
			arg_19_0._statistics._battleScore = var_0_2.BattleScore.A
		elseif var_19_2 == 0 then
			arg_19_0._statistics._battleScore = var_0_2.BattleScore.S
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

function ys.Battle.BattleDataProxy.CalcMaxRestHPRateBossRate(arg_20_0, arg_20_1)
	arg_20_0._statistics._maxBossHP = arg_20_1

	return
end

function ys.Battle.BattleDataProxy.CalcDuelScoreAtTimesUp(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	arg_21_0._statistics._deadUnit = true
	arg_21_0._statistics._badTime = true
	arg_21_0._statistics._timeout = false
	arg_21_0._statistics._totalTime = arg_21_0._currentStageData.timeCount - arg_21_0._countDown

	if arg_21_0._expeditionTmp.sink_limit > arg_21_0._statistics._deadCount then
		arg_21_0._statistics._deadUnit = false
	end

	if arg_21_2 < arg_21_1 then
		arg_21_0._statistics._battleScore = var_0_2.BattleScore.S
	elseif arg_21_1 < arg_21_2 then
		arg_21_0._statistics._battleScore = var_0_2.BattleScore.D
	elseif arg_21_4 <= arg_21_3 then
		arg_21_0._statistics._battleScore = var_0_2.BattleScore.S
	elseif arg_21_3 < arg_21_4 then
		arg_21_0._statistics._battleScore = var_0_2.BattleScore.D
	end

	return
end

function ys.Battle.BattleDataProxy.CalcDuelScoreAtEnd(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0._statistics._deadUnit = true
	arg_22_0._statistics._badTime = true
	arg_22_0._statistics._totalTime = arg_22_0._currentStageData.timeCount - arg_22_0._countDown

	if arg_22_0._expeditionTmp.sink_limit > arg_22_0._statistics._deadCount then
		arg_22_0._statistics._deadUnit = false
	end

	if #arg_22_1:GetUnitList() == 0 then
		arg_22_0._statistics._battleScore = var_0_2.BattleScore.D
	elseif #arg_22_2:GetUnitList() == 0 then
		arg_22_0._statistics._battleScore = var_0_2.BattleScore.S
	end

	arg_22_0._statistics._timeout = arg_22_0:isTimeOut()

	return
end

function ys.Battle.BattleDataProxy.CalcSimulationScoreAtEnd(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._statistics._deadUnit = true
	arg_23_0._statistics._badTime = true
	arg_23_0._statistics._totalTime = arg_23_0._currentStageData.timeCount - arg_23_0._countDown

	local var_23_0 = #arg_23_1:GetUnitList()
	local var_23_1 = arg_23_1:GetMaxCount()

	if arg_23_0._statistics._deadCount <= 0 then
		arg_23_0._statistics._deadUnit = false
	end

	local var_23_4 = arg_23_1:GetFlagShip()

	if not var_23_4:IsAlive() then
		arg_23_0._statistics._battleScore = var_0_2.BattleScore.D
		arg_23_0._statistics._scoreMark = var_0_2.DEAD_FLAG
	elseif #arg_23_1:GetScoutList() == 0 then
		arg_23_0._statistics._battleScore = var_0_2.BattleScore.D
	elseif #arg_23_2:GetUnitList() == 0 then
		arg_23_0._statistics._battleScore = var_0_2.BattleScore.S
	end

	arg_23_0._statistics._timeout = arg_23_0:isTimeOut()

	arg_23_0:overwriteRivalStatistics(arg_23_2)

	return
end

function ys.Battle.BattleDataProxy.CalcSimulationScoreAtTimesUp(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	arg_24_0._statistics._deadUnit = true
	arg_24_0._statistics._badTime = true
	arg_24_0._statistics._timeout = false
	arg_24_0._statistics._totalTime = arg_24_0._currentStageData.timeCount - arg_24_0._countDown

	if arg_24_0._statistics._deadCount <= 0 then
		arg_24_0._statistics._deadUnit = false
	end

	arg_24_0._statistics._battleScore = var_0_2.BattleScore.D

	arg_24_0:overwriteRivalStatistics(arg_24_5)

	return
end

function ys.Battle.BattleDataProxy.overwriteRivalStatistics(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in pairs(arg_25_0._statistics._rivalInfo) do
		local var_25_0 = false

		for iter_25_2, iter_25_3 in ipairs(arg_25_1:GetUnitList()) do
			if iter_25_3:GetAttrByName("id") == iter_25_0 then
				iter_25_1.bp = math.ceil(iter_25_3:GetHPRate() * 16)
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

function ys.Battle.BattleDataProxy.CalcChallengeScore(arg_26_0, arg_26_1)
	arg_26_0._statistics._battleScore = arg_26_1 and var_0_2.BattleScore.S or var_0_2.BattleScore.D
	arg_26_0._statistics._totalTime = arg_26_0._totalTime

	return
end

function ys.Battle.BattleDataProxy.CalcDodgemCount(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1:GetTemplate().type

	if arg_27_1:GetDeathReason() == ys.Battle.BattleConst.UnitDeathReason.CRUSH then
		arg_27_0._dodgemStatistics.kill = arg_27_0._dodgemStatistics.kill + 1

		if var_27_0 == ShipType.JinBi then
			arg_27_0._dodgemStatistics.combo = arg_27_0._dodgemStatistics.combo + 1
			arg_27_0._dodgemStatistics.maxCombo = math.max(arg_27_0._dodgemStatistics.maxCombo, arg_27_0._dodgemStatistics.combo)

			local var_27_1 = arg_27_0._dodgemStatistics.score + arg_27_0:GetScorePoint()

			arg_27_0._dodgemStatistics.score = var_27_1

			arg_27_0:DispatchEvent(ys.Event.New(var_0_0.UPDATE_DODGEM_SCORE, {
				totalScore = var_27_1
			}))
		elseif var_27_0 == ShipType.ZiBao then
			arg_27_0._dodgemStatistics.fail = arg_27_0._dodgemStatistics.fail + 1
			arg_27_0._dodgemStatistics.combo = 0
		end

		arg_27_0:DispatchEvent(ys.Event.New(var_0_0.UPDATE_DODGEM_COMBO, {
			combo = arg_27_0._dodgemStatistics.combo
		}))
	elseif var_27_0 == ShipType.JinBi then
		arg_27_0._dodgemStatistics.miss = arg_27_0._dodgemStatistics.miss + 1
	end

	return
end

function ys.Battle.BattleDataProxy.GetScorePoint(arg_28_0)
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

function ys.Battle.BattleDataProxy.CalcDodgemScore(arg_29_0)
	arg_29_0._statistics._battleScore = arg_29_0._dodgemStatistics.score >= var_0_3.BATTLE_DODGEM_PASS_SCORE and var_0_2.BattleScore.S or var_0_2.BattleScore.B
	arg_29_0._statistics.dodgemResult = arg_29_0._dodgemStatistics

	return
end

function ys.Battle.BattleDataProxy.CalcActBossDamageInfo(arg_30_0, arg_30_1)
	arg_30_0:CalcSpecificEnemyInfo((var_0_4.GetSpecificEnemyList(arg_30_1, arg_30_0._expeditionID)))

	return
end

function ys.Battle.BattleDataProxy.CalcWorldBossDamageInfo(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	arg_31_0:CalcSpecificEnemyInfo((var_0_4.GetSpecificWorldJointEnemyList(arg_31_1, arg_31_2, arg_31_3)))

	return
end

function ys.Battle.BattleDataProxy.CalcGuildBossEnemyInfo(arg_32_0, arg_32_1)
	arg_32_0:CalcSpecificEnemyInfo((var_0_4.GetSpecificGuildBossEnemyList(arg_32_1, arg_32_0._expeditionID)))

	return
end

function ys.Battle.BattleDataProxy.CalcSpecificEnemyInfo(arg_33_0, arg_33_1)
	arg_33_0._statistics.specificDamage = 0

	for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
		if arg_33_0._statistics["enemy_" .. iter_33_1] then
			local var_33_0 = arg_33_0._statistics["enemy_" .. iter_33_1].damage

			if table.contains(arg_33_0._statistics.kill_id_list, iter_33_1) then
				var_33_0 = arg_33_0._statistics["enemy_" .. iter_33_1].init_hp
			end

			arg_33_0._statistics.specificDamage = arg_33_0._statistics.specificDamage + var_33_0

			table.insert(arg_33_0._statistics._enemyInfoList, {
				id = iter_33_1,
				damage = var_33_0,
				totalHp = arg_33_0._statistics["enemy_" .. iter_33_1].max_hp
			})
		end
	end

	return
end

function ys.Battle.BattleDataProxy.CalcKillingSupplyShip(arg_34_0)
	arg_34_0._subRunStatistics.score = arg_34_0._subRunStatistics.score + 1

	return
end

function ys.Battle.BattleDataProxy.CalcSubRunTimeUp(arg_35_0)
	arg_35_0._statistics._battleScore = var_0_2.BattleScore.B
	arg_35_0._statistics.subRunResult = arg_35_0._subRunStatistics

	return
end

function ys.Battle.BattleDataProxy.CalcSubRunScore(arg_36_0)
	arg_36_0._statistics._battleScore = var_0_2.BattleScore.S
	arg_36_0._statistics.subRunResult = arg_36_0._subRunStatistics

	return
end

function ys.Battle.BattleDataProxy.CalcSubRunDead(arg_37_0)
	arg_37_0._statistics._battleScore = var_0_2.BattleScore.D
	arg_37_0._statistics.subRunResult = arg_37_0._subRunStatistics

	return
end

function ys.Battle.BattleDataProxy.CalcKillingSupplyShip(arg_38_0)
	arg_38_0._subRunStatistics.score = arg_38_0._subRunStatistics.score + 1

	return
end

function ys.Battle.BattleDataProxy.CalcSubRountineTimeUp(arg_39_0)
	arg_39_0._statistics._badTime = true

	arg_39_0:CalcSubRoutineScore()

	arg_39_0._statistics._battleScore = var_0_2.BattleScore.C

	return
end

function ys.Battle.BattleDataProxy.CalcSubRountineElimate(arg_40_0)
	arg_40_0._statistics._elimated = true

	arg_40_0:CalcSubRoutineScore()

	arg_40_0._statistics._battleScore = var_0_2.BattleScore.D

	return
end

function ys.Battle.BattleDataProxy.CalcSubRoutineScore(arg_41_0)
	local var_41_0 = arg_41_0._statistics._deadCount * var_0_3.SR_CONFIG.DEAD_POINT
	local var_41_1 = arg_41_0._subRunStatistics.score * var_0_3.SR_CONFIG.POINT
	local var_41_2 = (arg_41_0._statistics._badTime or arg_41_0._statistics._elimated) and 0 or var_0_3.SR_CONFIG.BASE_POINT
	local var_41_3 = ((arg_41_0._statistics._badTime or arg_41_0._statistics._elimated) and 0 or var_0_3.SR_CONFIG.BASE_POINT) + arg_41_0._subRunStatistics.score * var_0_3.SR_CONFIG.POINT - arg_41_0._statistics._deadCount * var_0_3.SR_CONFIG.DEAD_POINT

	arg_41_0._statistics._battleScore = ((arg_41_0._statistics._badTime or arg_41_0._statistics._elimated) and 0 or var_0_3.SR_CONFIG.BASE_POINT) + arg_41_0._subRunStatistics.score * var_0_3.SR_CONFIG.POINT - arg_41_0._statistics._deadCount * var_0_3.SR_CONFIG.DEAD_POINT >= var_0_3.SR_CONFIG.BASE_POINT + var_0_3.SR_CONFIG.M * var_0_3.SR_CONFIG.POINT and var_0_2.BattleScore.S or var_41_3 >= var_0_3.SR_CONFIG.BASE_POINT and var_0_2.BattleScore.A or var_41_3 >= var_0_3.SR_CONFIG.BASE_POINT - 2 * var_0_3.SR_CONFIG.DEAD_POINT and var_0_2.BattleScore.B or var_0_2.BattleScore.D
	arg_41_0._subRunStatistics.basePoint = var_41_2
	arg_41_0._subRunStatistics.deadCount = arg_41_0._statistics._deadCount
	arg_41_0._subRunStatistics.losePoint = var_41_0
	arg_41_0._subRunStatistics.point = var_41_1
	arg_41_0._subRunStatistics.total = var_41_3
	arg_41_0._statistics.subRunResult = arg_41_0._subRunStatistics

	return
end

function ys.Battle.BattleDataProxy.AirFightInit(arg_42_0)
	arg_42_0._statistics._airFightStatistics = {}
	arg_42_0._statistics._airFightStatistics.kill = 0
	arg_42_0._statistics._airFightStatistics.score = 0
	arg_42_0._statistics._airFightStatistics.hit = 0
	arg_42_0._statistics._airFightStatistics.lose = 0
	arg_42_0._statistics._airFightStatistics.total = 0

	return
end

function ys.Battle.BattleDataProxy.AddAirFightScore(arg_43_0, arg_43_1)
	arg_43_0._statistics._airFightStatistics.score = arg_43_0._statistics._airFightStatistics.score + arg_43_1
	arg_43_0._statistics._airFightStatistics.kill = arg_43_0._statistics._airFightStatistics.kill + 1
	arg_43_0._statistics._airFightStatistics.total = math.max(arg_43_0._statistics._airFightStatistics.score - arg_43_0._statistics._airFightStatistics.lose, 0)

	arg_43_0:DispatchEvent(ys.Event.New(var_0_0.UPDATE_DODGEM_SCORE, {
		totalScore = arg_43_0._statistics._airFightStatistics.total
	}))

	return
end

function ys.Battle.BattleDataProxy.DecreaseAirFightScore(arg_44_0, arg_44_1)
	arg_44_0._statistics._airFightStatistics.lose = arg_44_0._statistics._airFightStatistics.lose + arg_44_1
	arg_44_0._statistics._airFightStatistics.hit = arg_44_0._statistics._airFightStatistics.hit + 1
	arg_44_0._statistics._airFightStatistics.total = math.max(arg_44_0._statistics._airFightStatistics.score - arg_44_0._statistics._airFightStatistics.lose, 0)

	arg_44_0:DispatchEvent(ys.Event.New(var_0_0.UPDATE_DODGEM_SCORE, {
		totalScore = arg_44_0._statistics._airFightStatistics.total
	}))

	return
end

function ys.Battle.BattleDataProxy.CalcAirFightScore(arg_45_0)
	arg_45_0._statistics._battleScore = var_0_2.BattleScore.S

	return
end

function ys.Battle.BattleDataProxy.AddScenarioSubStrikeBoss(arg_46_0, arg_46_1)
	arg_46_0._statistics._scenarioSubStrikebossUnit = arg_46_1

	return
end

function ys.Battle.BattleDataProxy.CalcScenarioSubStrikeScoreAtEnd(arg_47_0)
	if not arg_47_0._statistics._scenarioSubStrikebossUnit then
		arg_47_0._statistics._bossHP = 1
		arg_47_0._statistics._battleScore = var_0_2.BattleScore.C
	elseif not arg_47_0._statistics._scenarioSubStrikebossUnit:IsAlive() then
		arg_47_0._statistics._battleScore = var_0_2.BattleScore.S
		arg_47_0._statistics._bossHP = 0
	else
		local var_47_0 = arg_47_0._statistics._scenarioSubStrikebossUnit:GetHPRate()

		if var_47_0 < arg_47_0._expeditionTmp.objective_2[2] * 0.01 then
			arg_47_0._statistics._battleScore = var_0_2.BattleScore.A
		elseif arg_47_0._expeditionTmp.objective_2[2] * 0.01 <= var_47_0 and var_47_0 < arg_47_0._expeditionTmp.objective_3[2] * 0.01 then
			arg_47_0._statistics._battleScore = var_0_2.BattleScore.B
		elseif arg_47_0._expeditionTmp.objective_3[2] * 0.01 <= var_47_0 then
			arg_47_0._statistics._battleScore = var_0_2.BattleScore.C
		end

		arg_47_0._statistics._bossHP = var_47_0
	end

	local var_47_1 = 0

	for iter_47_0, iter_47_1 in pairs(arg_47_0._statistics) do
		if type(iter_47_1) == "table" and iter_47_1.id and iter_47_1.damage and var_47_1 < iter_47_1.damage then
			var_47_1 = iter_47_1.damage
			arg_47_0._statistics.mvpShipID = iter_47_1.id
		end
	end

	return
end

function ys.Battle.BattleDataProxy.AutoStatistics(arg_48_0, arg_48_1)
	if not arg_48_0._statistics._autoInit then
		arg_48_0._statistics._autoInit = not arg_48_1 and 1 or 0
	else
		arg_48_0._statistics._autoCount = arg_48_0._statistics._autoCount + 1
	end

	return
end

return
