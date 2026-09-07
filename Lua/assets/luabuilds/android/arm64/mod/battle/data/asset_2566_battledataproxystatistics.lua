local var_0_0 = ys.Battle.BattleEvent
local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleConfig
local var_0_4 = ys.Battle.BattleDataFunction

function ys.Battle.BattleDataProxy:StatisticsInit(arg_1_1)
	self._statistics = {}
	self._statistics._battleScore = var_0_2.BattleScore.D
	self._statistics.kill_id_list = {}
	self._statistics._totalTime = 0
	self._statistics._deadCount = 0
	self._statistics._boss_destruct = 0
	self._statistics._botPercentage = 0
	self._statistics._maxBossHP = 0
	self._statistics._enemyInfoList = {}

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
		self._statistics[var_1_0.id] = var_1_0
	end

	self._statistics._autoCount = 0

	return
end

function ys.Battle.BattleDataProxy:InitAidUnitStatistics(arg_2_1)
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
	self._statistics[var_2_0.id] = var_2_0
	self._statistics.submarineAid = true

	return
end

function ys.Battle.BattleDataProxy:InitSpecificEnemyStatistics(arg_3_1)
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
	self._statistics[var_3_0.id] = var_3_0

	return
end

function ys.Battle.BattleDataProxy:RivalInit(arg_4_1)
	self._statistics._rivalInfo = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = iter_4_1:GetAttrByName("id")

		self._statistics._rivalInfo[var_4_0] = {}
		self._statistics._rivalInfo[var_4_0].id = var_4_0
	end

	return
end

function ys.Battle.BattleDataProxy:DodgemCountInit()
	self._dodgemStatistics = {}
	self._dodgemStatistics.kill = 0
	self._dodgemStatistics.combo = 0
	self._dodgemStatistics.miss = 0
	self._dodgemStatistics.fail = 0
	self._dodgemStatistics.score = 0
	self._dodgemStatistics.maxCombo = 0

	return
end

function ys.Battle.BattleDataProxy:SubmarineRunInit()
	self._subRunStatistics = {}
	self._subRunStatistics.score = 0

	return
end

function ys.Battle.BattleDataProxy:SetFlagShipID(arg_7_1)
	if arg_7_1 then
		self._statistics._flagShipID = arg_7_1:GetAttrByName("id")
	end

	return
end

function ys.Battle.BattleDataProxy:DamageStatistics(arg_8_1, arg_8_2, arg_8_3)
	if self._statistics[arg_8_1] then
		self._statistics[arg_8_1].output = self._statistics[arg_8_1].output + arg_8_3
		self._statistics[arg_8_1].maxDamageOnce = math.max(self._statistics[arg_8_1].maxDamageOnce, arg_8_3)
	end

	if self._statistics[arg_8_2] then
		self._statistics[arg_8_2].damage = self._statistics[arg_8_2].damage + arg_8_3
	end

	return
end

function ys.Battle.BattleDataProxy:KillCountStatistics(arg_9_1, arg_9_2)
	if self._statistics[arg_9_1] then
		self._statistics[arg_9_1].kill_count = self._statistics[arg_9_1].kill_count + 1
	end

	return
end

function ys.Battle.BattleDataProxy:HPRatioStatistics()
	for iter_10_0, iter_10_1 in pairs(self._fleetList) do
		iter_10_1:UndoFusion()
	end

	for iter_10_2, iter_10_3 in ipairs((self._fleetList[1]:GetUnitList())) do
		self._statistics[iter_10_3:GetAttrByName("id")].bp = math.ceil(iter_10_3:GetHPRate() * 16)
	end

	return
end

function ys.Battle.BattleDataProxy:BotPercentage(arg_11_1)
	self._statistics._botPercentage = Mathf.Clamp(math.floor(arg_11_1 / (self._currentStageData.timeCount - self._countDown) * 100), 0, 100)

	return
end

function ys.Battle.BattleDataProxy:CalcBattleScoreWhenDead(arg_12_1)
	local var_12_0 = arg_12_1:GetIFF()

	if var_12_0 == var_0_3.FRIENDLY_CODE then
		if not table.contains(ShipType.SubShipType, arg_12_1:GetTemplate().type) then
			self:DelScoreWhenPlayerDead(arg_12_1)
		end
	elseif var_12_0 == var_0_3.FOE_CODE then
		self:AddScoreWhenEnemyDead(arg_12_1)
	end

	return
end

function ys.Battle.BattleDataProxy:AddScoreWhenBossDestruct()
	self._statistics._boss_destruct = self._statistics._boss_destruct + 1

	return
end

function ys.Battle.BattleDataProxy:AddScoreWhenEnemyDead(arg_14_1)
	if arg_14_1:GetDeathReason() == var_0_2.UnitDeathReason.KILLED then
		self._statistics.kill_id_list[#self._statistics.kill_id_list + 1] = arg_14_1:GetTemplateID()
	end

	return
end

function ys.Battle.BattleDataProxy:DelScoreWhenPlayerDead(arg_15_1)
	self._statistics._deadCount = self._statistics._deadCount + 1

	return
end

function ys.Battle.BattleDataProxy:CalcBPWhenPlayerLeave(arg_16_1)
	self._statistics[arg_16_1:GetAttrByName("id")].bp = math.ceil(arg_16_1:GetHPRate() * 16)

	return
end

function ys.Battle.BattleDataProxy:isTimeOut()
	return self._currentStageData.timeCount - self._countDown >= 180
end

function ys.Battle.BattleDataProxy:CalcCardPuzzleScoreAtEnd(arg_18_1)
	self._statistics._deadUnit = true
	self._statistics._badTime = true

	local var_18_0 = arg_18_1:GetCardPuzzleComponent():GetCurrentCommonHP()

	if var_18_0 > 0 then
		self._statistics._battleScore = var_0_2.BattleScore.S or var_0_2.BattleScore.D
	end

	self._statistics._cardPuzzleStatistics = {}
	self._statistics._cardPuzzleStatistics.common_hp_rest = var_18_0
	self._statistics._totalTime = self._currentStageData.timeCount - self._countDown

	self:AirFightInit()

	return
end

function ys.Battle.BattleDataProxy:CalcSingleDungeonScoreAtEnd(arg_19_1)
	self._statistics._deadUnit = true
	self._statistics._badTime = true
	self._statistics._totalTime = self._currentStageData.timeCount - self._countDown

	if self._expeditionTmp.sink_limit > self._statistics._deadCount then
		self._statistics._deadUnit = false
	end

	local var_19_0 = arg_19_1:GetFlagShip()
	local var_19_1 = arg_19_1:GetScoutList()

	if self._expeditionTmp.limit_type == 2 then
		if not var_19_0:IsAlive() or #var_19_1 <= 0 then
			self._statistics._battleScore = var_0_2.BattleScore.D
			self._statistics._boss_destruct = 1
		else
			self._statistics._battleScore = var_0_2.BattleScore.S
		end
	elseif self._countDown <= 0 then
		self._statistics._battleScore = var_0_2.BattleScore.C
		self._statistics._boss_destruct = 1
	elseif var_19_0 and not var_19_0:IsAlive() then
		self._statistics._battleScore = var_0_2.BattleScore.D
		self._statistics._boss_destruct = 1
		self._statistics._scoreMark = var_0_2.DEAD_FLAG
	elseif #var_19_1 <= 0 then
		self._statistics._battleScore = var_0_2.BattleScore.D
		self._statistics._boss_destruct = 1
	else
		local var_19_2 = 0

		if self._statistics._deadUnit then
			var_19_2 = var_19_2 + 1
		end

		if self._expeditionTmp.time_limit < self._currentStageData.timeCount - self._countDown then
			var_19_2 = var_19_2 + 1
		else
			self._statistics._badTime = false
		end

		if self._statistics._boss_destruct > 0 then
			var_19_2 = var_19_2 + 1
		end

		if var_19_2 >= 2 then
			self._statistics._battleScore = var_0_2.BattleScore.B
		elseif var_19_2 == 1 then
			self._statistics._battleScore = var_0_2.BattleScore.A
		elseif var_19_2 == 0 then
			self._statistics._battleScore = var_0_2.BattleScore.S
		end
	end

	self._statistics._timeout = self:isTimeOut()

	if self._battleInitData.CMDArgs then
		self:CalcSpecificEnemyInfo({
			self._battleInitData.CMDArgs
		})
	end

	return
end

function ys.Battle.BattleDataProxy:CalcMaxRestHPRateBossRate(arg_20_1)
	self._statistics._maxBossHP = arg_20_1

	return
end

function ys.Battle.BattleDataProxy:CalcDuelScoreAtTimesUp(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	self._statistics._deadUnit = true
	self._statistics._badTime = true
	self._statistics._timeout = false
	self._statistics._totalTime = self._currentStageData.timeCount - self._countDown

	if self._expeditionTmp.sink_limit > self._statistics._deadCount then
		self._statistics._deadUnit = false
	end

	if arg_21_2 < arg_21_1 then
		self._statistics._battleScore = var_0_2.BattleScore.S
	elseif arg_21_1 < arg_21_2 then
		self._statistics._battleScore = var_0_2.BattleScore.D
	elseif arg_21_4 <= arg_21_3 then
		self._statistics._battleScore = var_0_2.BattleScore.S
	elseif arg_21_3 < arg_21_4 then
		self._statistics._battleScore = var_0_2.BattleScore.D
	end

	return
end

function ys.Battle.BattleDataProxy:CalcDuelScoreAtEnd(arg_22_1, arg_22_2)
	self._statistics._deadUnit = true
	self._statistics._badTime = true
	self._statistics._totalTime = self._currentStageData.timeCount - self._countDown

	if self._expeditionTmp.sink_limit > self._statistics._deadCount then
		self._statistics._deadUnit = false
	end

	if #arg_22_1:GetUnitList() == 0 then
		self._statistics._battleScore = var_0_2.BattleScore.D
	elseif #arg_22_2:GetUnitList() == 0 then
		self._statistics._battleScore = var_0_2.BattleScore.S
	end

	self._statistics._timeout = self:isTimeOut()

	return
end

function ys.Battle.BattleDataProxy:CalcSimulationScoreAtEnd(arg_23_1, arg_23_2)
	self._statistics._deadUnit = true
	self._statistics._badTime = true
	self._statistics._totalTime = self._currentStageData.timeCount - self._countDown

	local var_23_0 = #arg_23_1:GetUnitList()
	local var_23_1 = arg_23_1:GetMaxCount()

	if self._statistics._deadCount <= 0 then
		self._statistics._deadUnit = false
	end

	if not arg_23_1:GetFlagShip():IsAlive() then
		self._statistics._battleScore = var_0_2.BattleScore.D
		self._statistics._scoreMark = var_0_2.DEAD_FLAG
	elseif #arg_23_1:GetScoutList() == 0 then
		self._statistics._battleScore = var_0_2.BattleScore.D
	elseif #arg_23_2:GetUnitList() == 0 then
		self._statistics._battleScore = var_0_2.BattleScore.S
	end

	self._statistics._timeout = self:isTimeOut()

	self:overwriteRivalStatistics(arg_23_2)

	return
end

function ys.Battle.BattleDataProxy:CalcSimulationScoreAtTimesUp(arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	self._statistics._deadUnit = true
	self._statistics._badTime = true
	self._statistics._timeout = false
	self._statistics._totalTime = self._currentStageData.timeCount - self._countDown

	if self._statistics._deadCount <= 0 then
		self._statistics._deadUnit = false
	end

	self._statistics._battleScore = var_0_2.BattleScore.D

	self:overwriteRivalStatistics(arg_24_5)

	return
end

function ys.Battle.BattleDataProxy:overwriteRivalStatistics(arg_25_1)
	for iter_25_0, iter_25_1 in pairs(self._statistics._rivalInfo) do
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

function ys.Battle.BattleDataProxy:CalcChallengeScore(arg_26_1)
	self._statistics._battleScore = arg_26_1 and var_0_2.BattleScore.S or var_0_2.BattleScore.D
	self._statistics._totalTime = self._totalTime

	return
end

function ys.Battle.BattleDataProxy:CalcDodgemCount(arg_27_1)
	local var_27_0 = arg_27_1:GetTemplate().type

	if arg_27_1:GetDeathReason() == ys.Battle.BattleConst.UnitDeathReason.CRUSH then
		self._dodgemStatistics.kill = self._dodgemStatistics.kill + 1

		if var_27_0 == ShipType.JinBi then
			self._dodgemStatistics.combo = self._dodgemStatistics.combo + 1
			self._dodgemStatistics.maxCombo = math.max(self._dodgemStatistics.maxCombo, self._dodgemStatistics.combo)

			local var_27_1 = self._dodgemStatistics.score + self:GetScorePoint()

			self._dodgemStatistics.score = var_27_1

			self:DispatchEvent(ys.Event.New(var_0_0.UPDATE_DODGEM_SCORE, {
				totalScore = var_27_1
			}))
		elseif var_27_0 == ShipType.ZiBao then
			self._dodgemStatistics.fail = self._dodgemStatistics.fail + 1
			self._dodgemStatistics.combo = 0
		end

		self:DispatchEvent(ys.Event.New(var_0_0.UPDATE_DODGEM_COMBO, {
			combo = self._dodgemStatistics.combo
		}))
	elseif var_27_0 == ShipType.JinBi then
		self._dodgemStatistics.miss = self._dodgemStatistics.miss + 1
	end

	return
end

function ys.Battle.BattleDataProxy:GetScorePoint()
	local var_28_0

	if self._dodgemStatistics.combo == 1 then
		var_28_0 = 1
	elseif self._dodgemStatistics.combo == 2 then
		var_28_0 = 2
	elseif self._dodgemStatistics.combo > 2 then
		var_28_0 = 3
	end

	return var_28_0
end

function ys.Battle.BattleDataProxy:CalcDodgemScore()
	self._statistics._battleScore = self._dodgemStatistics.score >= var_0_3.BATTLE_DODGEM_PASS_SCORE and var_0_2.BattleScore.S or var_0_2.BattleScore.B
	self._statistics.dodgemResult = self._dodgemStatistics

	return
end

function ys.Battle.BattleDataProxy:CalcActBossDamageInfo(arg_30_1)
	self:CalcSpecificEnemyInfo((var_0_4.GetSpecificEnemyList(arg_30_1, self._expeditionID)))

	return
end

function ys.Battle.BattleDataProxy:CalcWorldBossDamageInfo(arg_31_1, arg_31_2, arg_31_3)
	self:CalcSpecificEnemyInfo((var_0_4.GetSpecificWorldJointEnemyList(arg_31_1, arg_31_2, arg_31_3)))

	return
end

function ys.Battle.BattleDataProxy:CalcGuildBossEnemyInfo(arg_32_1)
	self:CalcSpecificEnemyInfo((var_0_4.GetSpecificGuildBossEnemyList(arg_32_1, self._expeditionID)))

	return
end

function ys.Battle.BattleDataProxy:CalcSpecificEnemyInfo(arg_33_1)
	self._statistics.specificDamage = 0

	for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
		if self._statistics["enemy_" .. iter_33_1] then
			local var_33_0 = self._statistics["enemy_" .. iter_33_1].damage

			if table.contains(self._statistics.kill_id_list, iter_33_1) then
				var_33_0 = self._statistics["enemy_" .. iter_33_1].init_hp
			end

			self._statistics.specificDamage = self._statistics.specificDamage + var_33_0

			table.insert(self._statistics._enemyInfoList, {
				id = iter_33_1,
				damage = var_33_0,
				totalHp = self._statistics["enemy_" .. iter_33_1].max_hp
			})
		end
	end

	return
end

function ys.Battle.BattleDataProxy:CalcKillingSupplyShip()
	self._subRunStatistics.score = self._subRunStatistics.score + 1

	return
end

function ys.Battle.BattleDataProxy:CalcSubRunTimeUp()
	self._statistics._battleScore = var_0_2.BattleScore.B
	self._statistics.subRunResult = self._subRunStatistics

	return
end

function ys.Battle.BattleDataProxy:CalcSubRunScore()
	self._statistics._battleScore = var_0_2.BattleScore.S
	self._statistics.subRunResult = self._subRunStatistics

	return
end

function ys.Battle.BattleDataProxy:CalcSubRunDead()
	self._statistics._battleScore = var_0_2.BattleScore.D
	self._statistics.subRunResult = self._subRunStatistics

	return
end

function ys.Battle.BattleDataProxy:CalcKillingSupplyShip()
	self._subRunStatistics.score = self._subRunStatistics.score + 1

	return
end

function ys.Battle.BattleDataProxy:CalcSubRountineTimeUp()
	self._statistics._badTime = true

	self:CalcSubRoutineScore()

	self._statistics._battleScore = var_0_2.BattleScore.C

	return
end

function ys.Battle.BattleDataProxy:CalcSubRountineElimate()
	self._statistics._elimated = true

	self:CalcSubRoutineScore()

	self._statistics._battleScore = var_0_2.BattleScore.D

	return
end

function ys.Battle.BattleDataProxy:CalcSubRoutineScore()
	local var_41_1 = ((self._statistics._badTime or self._statistics._elimated) and 0 or var_0_3.SR_CONFIG.BASE_POINT) + self._subRunStatistics.score * var_0_3.SR_CONFIG.POINT - self._statistics._deadCount * var_0_3.SR_CONFIG.DEAD_POINT

	self._statistics._battleScore = ((self._statistics._badTime or self._statistics._elimated) and 0 or var_0_3.SR_CONFIG.BASE_POINT) + self._subRunStatistics.score * var_0_3.SR_CONFIG.POINT - self._statistics._deadCount * var_0_3.SR_CONFIG.DEAD_POINT >= var_0_3.SR_CONFIG.BASE_POINT + var_0_3.SR_CONFIG.M * var_0_3.SR_CONFIG.POINT and var_0_2.BattleScore.S or var_41_1 >= var_0_3.SR_CONFIG.BASE_POINT and var_0_2.BattleScore.A or var_41_1 >= var_0_3.SR_CONFIG.BASE_POINT - 2 * var_0_3.SR_CONFIG.DEAD_POINT and var_0_2.BattleScore.B or var_0_2.BattleScore.D
	self._subRunStatistics.basePoint = (self._statistics._badTime or self._statistics._elimated) and 0 or var_0_3.SR_CONFIG.BASE_POINT
	self._subRunStatistics.deadCount = self._statistics._deadCount
	self._subRunStatistics.losePoint = self._statistics._deadCount * var_0_3.SR_CONFIG.DEAD_POINT
	self._subRunStatistics.point = self._subRunStatistics.score * var_0_3.SR_CONFIG.POINT
	self._subRunStatistics.total = var_41_1
	self._statistics.subRunResult = self._subRunStatistics

	return
end

function ys.Battle.BattleDataProxy:AirFightInit()
	self._statistics._airFightStatistics = {}
	self._statistics._airFightStatistics.kill = 0
	self._statistics._airFightStatistics.score = 0
	self._statistics._airFightStatistics.hit = 0
	self._statistics._airFightStatistics.lose = 0
	self._statistics._airFightStatistics.total = 0

	return
end

function ys.Battle.BattleDataProxy:AddAirFightScore(arg_43_1)
	self._statistics._airFightStatistics.score = self._statistics._airFightStatistics.score + arg_43_1
	self._statistics._airFightStatistics.kill = self._statistics._airFightStatistics.kill + 1
	self._statistics._airFightStatistics.total = math.max(self._statistics._airFightStatistics.score - self._statistics._airFightStatistics.lose, 0)

	self:DispatchEvent(ys.Event.New(var_0_0.UPDATE_DODGEM_SCORE, {
		totalScore = self._statistics._airFightStatistics.total
	}))

	return
end

function ys.Battle.BattleDataProxy:DecreaseAirFightScore(arg_44_1)
	self._statistics._airFightStatistics.lose = self._statistics._airFightStatistics.lose + arg_44_1
	self._statistics._airFightStatistics.hit = self._statistics._airFightStatistics.hit + 1
	self._statistics._airFightStatistics.total = math.max(self._statistics._airFightStatistics.score - self._statistics._airFightStatistics.lose, 0)

	self:DispatchEvent(ys.Event.New(var_0_0.UPDATE_DODGEM_SCORE, {
		totalScore = self._statistics._airFightStatistics.total
	}))

	return
end

function ys.Battle.BattleDataProxy:CalcAirFightScore()
	self._statistics._battleScore = var_0_2.BattleScore.S

	return
end

function ys.Battle.BattleDataProxy:AddScenarioSubStrikeBoss(arg_46_1)
	self._statistics._scenarioSubStrikebossUnit = arg_46_1

	return
end

function ys.Battle.BattleDataProxy:CalcScenarioSubStrikeScoreAtEnd()
	if not self._statistics._scenarioSubStrikebossUnit then
		self._statistics._bossHP = 1
		self._statistics._battleScore = var_0_2.BattleScore.C
	elseif not self._statistics._scenarioSubStrikebossUnit:IsAlive() then
		self._statistics._battleScore = var_0_2.BattleScore.S
		self._statistics._bossHP = 0
	else
		local var_47_0 = self._statistics._scenarioSubStrikebossUnit:GetHPRate()

		if var_47_0 < self._expeditionTmp.objective_2[2] * 0.01 then
			self._statistics._battleScore = var_0_2.BattleScore.A
		elseif self._expeditionTmp.objective_2[2] * 0.01 <= var_47_0 and var_47_0 < self._expeditionTmp.objective_3[2] * 0.01 then
			self._statistics._battleScore = var_0_2.BattleScore.B
		elseif self._expeditionTmp.objective_3[2] * 0.01 <= var_47_0 then
			self._statistics._battleScore = var_0_2.BattleScore.C
		end

		self._statistics._bossHP = var_47_0
	end

	local var_47_1 = 0

	for iter_47_0, iter_47_1 in pairs(self._statistics) do
		if type(iter_47_1) == "table" and iter_47_1.id and iter_47_1.damage and var_47_1 < iter_47_1.damage then
			var_47_1 = iter_47_1.damage
			self._statistics.mvpShipID = iter_47_1.id
		end
	end

	return
end

function ys.Battle.BattleDataProxy:AutoStatistics(arg_48_1)
	if not self._statistics._autoInit then
		self._statistics._autoInit = not arg_48_1 and 1 or 0
	else
		self._statistics._autoCount = self._statistics._autoCount + 1
	end

	return
end

return
