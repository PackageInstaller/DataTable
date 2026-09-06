-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/model/AoQiAttackForceModel.lua

module("logic.extensions.aoqiattackforce.model.AoQiAttackForceModel", package.seeall)

local AoQiAttackForceModel = class("AoQiAttackForceModel", BaseModel)

function AoQiAttackForceModel:ctor()
	return
end

function AoQiAttackForceModel:onInit()
	self:onReset()
end

function AoQiAttackForceModel:onReset()
	self._baseInfoList = {}
	self._rankInfoList = {}
	self._heroRankInfoList = {}
	self._lastServerKey = 0
	self._lastClientKey = 0
	self._skipLotteryBuffAnim = false
end

function AoQiAttackForceModel:saveServeKey(key)
	self._lastServerKey = key
end

function AoQiAttackForceModel:saveClientKey(key)
	self._lastClientKey = key
end

function AoQiAttackForceModel:getServeKey()
	return self._lastServerKey
end

function AoQiAttackForceModel:getClientKey()
	return self._lastClientKey
end

function AoQiAttackForceModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._baseInfoList[info.activityId] = info
end

function AoQiAttackForceModel:onGetRankInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._rankInfoList[info.activityId] = info
end

function AoQiAttackForceModel:onGetHeroRankInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._heroRankInfoList[info.activityId] = info
end

function AoQiAttackForceModel:onUpgradeEquipment(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self._baseInfoList[info.activityId]

	baseInfo.equipments = info.equipments
end

function AoQiAttackForceModel:onAdjustEquipment(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self._baseInfoList[info.activityId]
	local equipmentId = info.equipmentId

	for _, equipInfo in ipairs(baseInfo.equipments) do
		if equipInfo.equipmentId == equipmentId then
			equipInfo.isUsed = info.isUse
		end
	end
end

function AoQiAttackForceModel:onSweepClg(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self._baseInfoList[info.activityId]

	baseInfo.dailyUsedStrength = info.dailyUsedStrength
end

function AoQiAttackForceModel:onHeroSweepClg(msg, maxLimitCount)
	if self._baseInfoList[msg.activityId] then
		self._baseInfoList[msg.activityId].dailyHeroPrizeLimit = maxLimitCount
	end
end

function AoQiAttackForceModel:getBaseInfoByActId(actId)
	return self._baseInfoList[actId]
end

function AoQiAttackForceModel:getRankInfoByActId(actId)
	return self._rankInfoList[actId]
end

function AoQiAttackForceModel:getHeroRankInfoByActId(actId)
	return self._heroRankInfoList[actId]
end

function AoQiAttackForceModel:resetGameData()
	self._curActId = nil
	self._curActCfg = nil
	self._curClgCfg = nil
	self._curWaveCfg = nil
	self._curWaveId = 0
	self._gameMode = AQAFGameEnum.GameMode.Normal
	self._curBuffPool = {}
	self._curGoodsPool = {}
	self._curMonsterParams = {}
	self._curEquipLevelMap = {}
	self._curCreateGoodsNum = 0

	self:_initBackPack()

	self._curEquipsInGame = {}
	self._curBackPackOffsetIdxX = 0
	self._curBackPackOffsetIdxY = 0
	self._curMergeTimes = 0
	self._curCoinNum = 0
	self._curCostCoinNum = 0
	self._curRemainBuffTimes = 0
	self._curGainBuffs = {}
	self._hardCoefficient = 1
	self._curSaveDamage = 0
	self._curHPMax = 0
	self._curKillNum = 0
	self._restartTime = 0

	self:resetRecordWaveState()
end

function AoQiAttackForceModel:initGameFinalClgData(actId)
	self:resetGameData()

	self._gameMode = AQAFGameEnum.GameMode.Endless
	self._curActId = actId
	self._curActCfg = AoQiAttackForceConfig.instance:getActivityCfg(actId)
	self._curClgCfg = AoQiAttackForceConfig.instance:getFinalChallengeCfg(actId)

	self:updateCurEquipLimit(actId, self:getIsEndlessState())

	self._curCoinNum = self._curClgCfg.startCoin
	self._curCostCoinNum = 0
	self._restartTime = 0

	self:updateGoodsPool(self._curClgCfg.storePlan)
	self:updateMonsterPool(self._curClgCfg.monsterPlan)

	self._curRemainBuffTimes = self._curClgCfg.buffTime

	self:calculateAndSaveMaxHP(0, 0)
end

function AoQiAttackForceModel:initGameClgData(actId, challengeId)
	self:resetGameData()

	self._curActId = actId
	self._gameMode = AQAFGameEnum.GameMode.Normal
	self._curActCfg = AoQiAttackForceConfig.instance:getActivityCfg(actId)
	self._curClgCfg = AoQiAttackForceConfig.instance:getChallengeCfg(actId, challengeId)

	self:updateCurEquipLimit(actId, self:getIsEndlessState())

	self._curCoinNum = self._curClgCfg.startCoin
	self._curCostCoinNum = 0
	self._restartTime = 0

	self:calculateAndSaveMaxHP(0, 0)
	self:udpateWave()
end

function AoQiAttackForceModel:initGameHeroClgData(actId)
	self:resetGameData()

	self._curActId = actId
	self._gameMode = AQAFGameEnum.GameMode.Hero
	self._curActCfg = AoQiAttackForceConfig.instance:getActivityCfg(actId)
	self._curClgCfg = AoQiAttackForceConfig.instance:getHeroChallengeInfoClg(actId)

	self:updateCurEquipLimit(actId, self:getIsEndlessState())

	self._curCoinNum = self._curClgCfg.startCoin
	self._curCostCoinNum = 0
	self._restartTime = 0

	self:calculateAndSaveMaxHP(0, 0)
	self:udpateWave()
end

function AoQiAttackForceModel:udpateWave()
	if self._gameMode == AQAFGameEnum.GameMode.Normal then
		if self._curWaveId ~= 0 then
			self._curCoinNum = self._curWaveCfg.passReward + self._curCoinNum
			self._curCoinNum = self._curCoinNum + self:getIncomeByCurEquipment()
		end

		self._curWaveId = self._curWaveId + 1
		self._curWaveCfg = AoQiAttackForceConfig.instance:getChallengeWaveCfg(self._curClgCfg.activityId, self._curClgCfg.challengeId, self._curWaveId)

		self:updateGoodsPool(self._curWaveCfg.stotePlan)
		self:updateMonsterPool(self._curWaveCfg.monsterPlan)

		self._curRemainBuffTimes = self._curWaveCfg.buffTime
	elseif self:getIsHeroState() == true then
		if self._curWaveId ~= 0 then
			self._curCoinNum = self._curWaveCfg.passReward + self._curCoinNum
			self._curCoinNum = self._curCoinNum + self:getIncomeByCurEquipment()
		end

		self._curWaveId = self._curWaveId + 1
		self._curWaveCfg = AoQiAttackForceConfig.instance:getHeroChallengeWaveClg(self._curClgCfg.activityId, self._curWaveId)

		self:updateGoodsPool(self._curWaveCfg.stotePlan)
		self:updateMonsterPool(self._curWaveCfg.monsterPlan)

		self._curRemainBuffTimes = self._curWaveCfg.buffTime
	end
end

function AoQiAttackForceModel:updateCurEquipLimit(actId, isEndlessState)
	self._curEquipLevelMap = {}

	if not self._baseInfoList[actId] then
		for _, equipment in ipairs((not self._baseInfoList[actId].equipments or nil) and {}) do
			if equipment.isUsed then
				local equipmentCfg = AoQiAttackForceConfig.instance:getEquipmentCfg(actId, equipment.equipmentId)

				self._curEquipLevelMap[equipmentCfg.equipmentInGameId] = equipment.level
			end
		end

		if not isEndlessState then
			self._curEquipLevelMap[AQAFGameEnum.PurseEquipmentDefineId] = 1
		end
	end
end

function AoQiAttackForceModel:updateBuffPool(planId, temBuffs)
	local buffCfgs = AoQiAttackForceConfig.instance:getBuffPlanInGameCfg(planId)
	local leftLimit = 0
	local buffCountMap = {}

	for _, buffId in ipairs(self._curGainBuffs) do
		if not buffCountMap[buffId] then
			local curCount = 0

			curCount = curCount + 1
			buffCountMap[buffId] = curCount
		end
	end

	local temBuffList = temBuffs or {}

	for _, buffId in ipairs(temBuffList) do
		if not buffCountMap[buffId] then
			local curCount = 0

			curCount = curCount + 1
			buffCountMap[buffId] = curCount
		end
	end

	self._curBuffPool = {}

	for _, cfg in ipairs(buffCfgs) do
		local buffCfg = AoQiAttackForceConfig.instance:getBuffCfgInGameCfg(cfg.buffId)

		if buffCfg then
			local equipIdlimit = buffCfg.equipIdlimit
			local equipLvLimit = buffCfg.equipLvLimit

			if not buffCountMap[buffCfg.buffId] then
				local curEquipLV = self._curEquipLevelMap[equipIdlimit]

				if equipIdlimit == 0 then
					if buffCountMap[buffCfg.buffId] < buffCfg.getLimit then
						table.insert(self._curBuffPool, cfg)

						leftLimit = leftLimit + buffCfg.getLimit - buffCountMap[buffCfg.buffId]
					end
				elseif curEquipLV and equipLvLimit <= curEquipLV and buffCountMap[buffCfg.buffId] < buffCfg.getLimit then
					table.insert(self._curBuffPool, cfg)

					leftLimit = leftLimit + buffCfg.getLimit - buffCountMap[buffCfg.buffId]
				end
			end
		end
	end

	return leftLimit
end

function AoQiAttackForceModel:updateGoodsPool(planId)
	self._curGoodsPool = {}

	local storeCfgs = AoQiAttackForceConfig.instance:getStorePlanInGameCfg(planId)

	for _, cfg in ipairs(storeCfgs) do
		if not cfg.equipmentId then
			if cfg.equipmentId ~= 0 and not self._curEquipLevelMap[cfg.equipmentId] then
				-- block empty
			else
				table.insert(self._curGoodsPool, cfg)
			end
		end
	end
end

function AoQiAttackForceModel:updateMonsterPool(planId)
	self._curMonsterParams = AoQiAttackForceConfig.instance:getMonsterPlanInGameCfg(planId)
end

function AoQiAttackForceModel:getCurMonsterCfgs()
	local params = {}

	for i, cfg in ipairs(self._curMonsterParams) do
		table.insert(params, 1, cfg)
	end

	return params
end

function AoQiAttackForceModel:getRandomEdge(edges)
	local maxWeight = 0

	for _, v in ipairs(edges) do
		maxWeight = maxWeight + v.weight
	end

	local random = math.random(1, maxWeight)
	local totalWeight = 0

	for _, v in ipairs(edges) do
		totalWeight = totalWeight + v.weight

		if random <= totalWeight then
			return v
		end
	end
end

function AoQiAttackForceModel:getRandomBuffList(nums)
	local curBuffPlan = 1

	if self._gameMode == AQAFGameEnum.GameMode.Normal then
		curBuffPlan = self._curWaveCfg.buffPlan
	elseif self._gameMode == AQAFGameEnum.GameMode.Endless then
		curBuffPlan = self._curClgCfg.buffPlan
	elseif self._gameMode == AQAFGameEnum.GameMode.Hero then
		curBuffPlan = self._curWaveCfg.buffPlan
	end

	local buffNums = checknumber(nums)
	local newBuffIds = {}

	for i = 1, buffNums do
		self:updateBuffPool(curBuffPlan, newBuffIds)

		local cfg = self:getRandomEdge(self._curBuffPool)

		if cfg then
			table.insert(newBuffIds, cfg.buffId)
		end
	end

	return newBuffIds, self:updateBuffPool(curBuffPlan)
end

function AoQiAttackForceModel:getRandomGoodsList(nums)
	local goodsNums = checknumber(nums)
	local goodsDataList = {}

	for i = 1, goodsNums do
		local cfg = self:getRandomEdge(self._curGoodsPool)

		if cfg.equipmentId ~= 0 then
			local equipDefineId = cfg.equipmentId
			local data = self:createEquipmentData(self._curActId, equipDefineId, cfg.equipStar, self._curEquipLevelMap[equipDefineId])

			table.insert(goodsDataList, data)
		else
			local data = self:createAddBackPackData(cfg.addShape)

			table.insert(goodsDataList, data)
		end
	end

	return goodsDataList
end

function AoQiAttackForceModel:createEquipmentData(activityId, equipDefineId, starlv, level)
	self._curCreateGoodsNum = self._curCreateGoodsNum + 1

	local data = AoQiAttackForceEquipmentData.New()

	data.id = self:newOwnId()

	data:initData(activityId, equipDefineId, starlv, level)

	return data
end

function AoQiAttackForceModel:createAddBackPackData(shapeType)
	local data = AoQiAttackForceAddPBData.New()

	data.id = self:newOwnId()

	data:initData(shapeType)

	return data
end

function AoQiAttackForceModel:newOwnId()
	self._curCreateGoodsNum = self._curCreateGoodsNum + 1

	return self._curCreateGoodsNum
end

function AoQiAttackForceModel:updateMergeTime()
	self._curMergeTimes = self._curMergeTimes + 1
end

function AoQiAttackForceModel:getCurMergeTimes()
	return self._curMergeTimes
end

function AoQiAttackForceModel:_initBackPack()
	self._curBackPackDataMap = {}

	local addBackPackData = self:createAddBackPackData(-1)

	addBackPackData.oi = 3
	addBackPackData.oj = 2
	self._curBackPackDataMap[addBackPackData.id] = addBackPackData
end

function AoQiAttackForceModel:saveCurBackPackData(curBackPackMap, offx, offy)
	self._curBackPackDataMap = {}
	self._curEquipsInGame = {}

	for k, v in pairs(curBackPackMap) do
		self._curBackPackDataMap[k] = v

		if not v.isPack then
			table.insert(self._curEquipsInGame, v)
		end
	end

	self._curBackPackOffsetIdxX = offx
	self._curBackPackOffsetIdxY = offy
end

function AoQiAttackForceModel:getCurBackPackParams()
	return self._curBackPackDataMap, self._curBackPackOffsetIdxX, self._curBackPackOffsetIdxY
end

function AoQiAttackForceModel:getCurEquipsInGame()
	return self._curEquipsInGame
end

function AoQiAttackForceModel:strengthenMonster()
	self._hardCoefficient = self._hardCoefficient + 0.5
end

function AoQiAttackForceModel:getHardCoefficient()
	if self._gameMode == AQAFGameEnum.GameMode.Endless then
		return self._hardCoefficient
	else
		return 1
	end
end

function AoQiAttackForceModel:getCurGainBuffs()
	return self._curGainBuffs
end

function AoQiAttackForceModel:getCurBuffTimes()
	return self._curRemainBuffTimes
end

function AoQiAttackForceModel:getCurBuffLimitTimes()
	if self._gameMode == AQAFGameEnum.GameMode.Endless then
		return self._curClgCfg.buffTime
	elseif self._gameMode == AQAFGameEnum.GameMode.Normal then
		return self._curWaveCfg.buffTime
	elseif self._gameMode == AQAFGameEnum.GameMode.Hero then
		return self._curWaveCfg.buffCount
	end

	return 0
end

function AoQiAttackForceModel:selectBuffs(buffList)
	self._curRemainBuffTimes = self._curRemainBuffTimes - 1

	for _, buffId in ipairs(buffList) do
		self:gainBuff(buffId)
	end
end

function AoQiAttackForceModel:gainBuff(buffId)
	table.insert(self._curGainBuffs, buffId)
end

function AoQiAttackForceModel:getCurActCfg()
	return self._curActCfg
end

function AoQiAttackForceModel:getCurClgCfg()
	return self._curClgCfg
end

function AoQiAttackForceModel:getCurWaveCfg()
	return self._curWaveCfg
end

function AoQiAttackForceModel:getCurIsLastWave()
	if self._gameMode == AQAFGameEnum.GameMode.Endless then
		return false
	elseif self._gameMode == AQAFGameEnum.GameMode.Hero then
		return not AoQiAttackForceConfig.instance:getHeroChallengeWaveClg(self._curClgCfg.activityId, self._curWaveId + 1)
	else
		return not AoQiAttackForceConfig.instance:getChallengeWaveCfg(self._curClgCfg.activityId, self._curClgCfg.challengeId, self._curWaveId + 1)
	end
end

function AoQiAttackForceModel:costCoin(costNum)
	local num = checknumber(costNum)

	if num > self._curCoinNum then
		printError("货币不足")
	else
		self._curCoinNum = self._curCoinNum - num
		self._curCostCoinNum = self._curCostCoinNum + num
	end
end

function AoQiAttackForceModel:getCurCoinNum()
	return self._curCoinNum
end

function AoQiAttackForceModel:getCurCostCoinNum()
	return self._curCostCoinNum
end

function AoQiAttackForceModel:getIsEndlessState()
	return self._gameMode == AQAFGameEnum.GameMode.Endless
end

function AoQiAttackForceModel:getIsHeroState()
	return self._gameMode == AQAFGameEnum.GameMode.Hero
end

function AoQiAttackForceModel:getGameMode()
	return self._gameMode
end

function AoQiAttackForceModel:calculateAndSaveMaxHP(curHp, hpMax)
	self._curSaveDamage = hpMax - curHp
	self._curHPMax = self._curSaveDamage == 0 and self._curActCfg.playerHp or hpMax
end

function AoQiAttackForceModel:getCurHpMax()
	local hpMax = self._curActCfg.playerHp
	local equips = self:getCurEquipsInGame()

	for i, equip in ipairs(equips) do
		hpMax = hpMax + equip:getCurHpMax()
	end

	return math.max(hpMax, self._curHPMax)
end

function AoQiAttackForceModel:getCurHp()
	return math.max(self:getCurHpMax() - self._curSaveDamage, 1)
end

function AoQiAttackForceModel:getCurWaveId()
	return self._curWaveId
end

function AoQiAttackForceModel:getCurSaveDamage()
	return self._curSaveDamage
end

function AoQiAttackForceModel:getCurSaveHpMax()
	return self._curHPMax
end

function AoQiAttackForceModel:getIncomeByCurEquipment()
	local addIncome = 0

	for id, equipment in pairs(self._curEquipsInGame) do
		local cfg = equipment.cfg

		if cfg then
			addIncome = addIncome + cfg.income
		end
	end

	return addIncome
end

function AoQiAttackForceModel:updateKillScore(isBoss)
	self._curKillNum = isBoss and self._curKillNum + 10 or self._curKillNum + 1
end

function AoQiAttackForceModel:getCurKillScore()
	return self._curKillNum
end

function AoQiAttackForceModel:getRestartTime()
	return self._restartTime
end

function AoQiAttackForceModel:restartGame()
	self:recoverWaveState()

	self._restartTime = self._restartTime + 1
end

function AoQiAttackForceModel:recordWaveState()
	self._recordInfo = {}

	local backPackDataMap = {}

	for k, v in pairs(self._curBackPackDataMap) do
		backPackDataMap[k] = v
	end

	self._recordInfo.backPackDataMap = backPackDataMap

	local equipsInGame = {}

	for k, v in pairs(self._curEquipsInGame) do
		equipsInGame[k] = v
	end

	self._recordInfo.equipsInGame = equipsInGame
	self._recordInfo.curBackPackOffsetIdxX = self._curBackPackOffsetIdxX
	self._recordInfo.curBackPackOffsetIdxY = self._curBackPackOffsetIdxY
	self._recordInfo.curMergeTimes = self._curMergeTimes
	self._recordInfo.curCoinNum = self._curCoinNum
	self._recordInfo.curCostCoinNum = self._curCostCoinNum

	local gainBuffs = {}

	for k, v in pairs(self._curGainBuffs) do
		gainBuffs[k] = v
	end

	self._recordInfo.gainBuffs = gainBuffs
	self._recordInfo.hardCoefficient = self._hardCoefficient
	self._recordInfo.curSaveDamage = self._curSaveDamage
	self._recordInfo.curHPMax = self._curHPMax
	self._recordInfo.curKillNum = self._curKillNum
end

function AoQiAttackForceModel:recoverWaveState()
	if self._recordInfo then
		self._curBackPackDataMap = {}

		for k, v in pairs(self._recordInfo.backPackDataMap) do
			self._curBackPackDataMap[k] = v
		end

		self._curEquipsInGame = {}

		for k, v in pairs(self._recordInfo.equipsInGame) do
			self._curEquipsInGame[k] = v
		end

		self._curBackPackOffsetIdxX = self._recordInfo.curBackPackOffsetIdxX
		self._curBackPackOffsetIdxY = self._recordInfo.curBackPackOffsetIdxY
		self._curMergeTimes = self._recordInfo.curMergeTimes
		self._curCoinNum = self._recordInfo.curCoinNum
		self._curCostCoinNum = self._recordInfo.curCostCoinNum
		self._curGainBuffs = {}

		for k, v in pairs(self._recordInfo.gainBuffs) do
			self._curGainBuffs[k] = v
		end

		self._hardCoefficient = self._recordInfo.hardCoefficient
		self._curSaveDamage = self._recordInfo.curSaveDamage
		self._curHPMax = self._recordInfo.curHPMax
		self._curKillNum = self._recordInfo.curKillNum
	end
end

function AoQiAttackForceModel:resetRecordWaveState()
	self._recordInfo = nil
end

function AoQiAttackForceModel:setSkipLotteryBuffAnim()
	self._skipLotteryBuffAnim = true
end

function AoQiAttackForceModel:getSkipLotteryBuffAnim()
	return self._skipLotteryBuffAnim
end

AoQiAttackForceModel.instance = AoQiAttackForceModel.New()

return AoQiAttackForceModel
