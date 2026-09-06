-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/model/BreakFormationModel.lua

module("logic.extensions.breakformation.model.BreakFormationModel", package.seeall)

local BreakFormationModel = class("BreakFormationModel", BaseModel)

BreakFormationModel.HAS_GET = -1
BreakFormationModel.NO_PASS = 1
BreakFormationModel.NOT_ENOUGH = 2
BreakFormationModel.CAN_GET = 3
BreakFormationModel.MODE_NORMAL = 1
BreakFormationModel.MODE_HELL = 2

function BreakFormationModel:ctor()
	return
end

function BreakFormationModel:onInit()
	self:onReset()
end

function BreakFormationModel:onReset()
	self._formationMo = nil
	self._fightDatas = {}
	self._onlineEnemyInfo = {}
	self.allHurtCount = 0
	self.progReceiveList = nil
	self.isPopupTipsParam = -1
	self.isDataInit = false
	self.newScoreIdx = nil
	self.lastIdx = nil
	self.mode = BreakFormationModel.MODE_NORMAL
	self._lastOpenTime = nil
	self.allPetList = nil
	self.allPetMap = nil
	self._curBagPetVersion = nil
end

local pozhenQuickRedKey = "POZHEN_QUICK_PASS_KEY"

function BreakFormationModel:isQuickRedActive()
	local quickPassCost = BreakFormationConfig.instance:getBreakParmCfg("quickPassCost").paramVal
	local matType, matId, _ = unpack(string.splitToNumber(quickPassCost, ":"))
	local isEnough = MaterialModel.instance:IsEnough(matType, matId, 1)
	local key = pozhenQuickRedKey

	if self._lastOpenTime == nil then
		self._lastOpenTime = checknumber(GameUtil.getUserDayData(key))
	end

	local nowDate = ServerTime.nowDateServerLook()
	local lastDate = GameUtil.time2date(self._lastOpenTime)

	if nowDate.hour >= 5 then
		if not nowDate.day then
			local nowDay = nowDate.day - 1

			if lastDate.hour >= 5 then
				if not lastDate.day then
					local lastDay = lastDate.day - 1

					return nowDay ~= lastDay and isEnough
				end
			end
		end
	end
end

function BreakFormationModel:clearQuickOpenTime()
	GameUtil.saveUserDayData(pozhenQuickRedKey, 0)

	self._lastOpenTime = 0

	RedPointModel.instance:updateAllRedPoint()
end

function BreakFormationModel:saveQuickOpenTime()
	if not RedPointModel.instance:isActive(115) then
		return
	end

	local key = pozhenQuickRedKey
	local now = ServerTime.now()

	self._lastOpenTime = now

	GameUtil.saveUserDayData(key, tostring(now))
	RedPointModel.instance:updateAllRedPoint()
end

function BreakFormationModel:handlePM_BreachFormationGetUserInfoRes(msg)
	self.isDataInit = true
	self.periodId = msg.periodId
	self._scorelist = msg.scoreList
	self.hellScoreList = msg.hellScoreList
	self._prizegainstates = msg.progress or {}
	self.endTime = checknumber(msg.endTime) / 1000
	self.hasFirstPassTimes = checknumber(msg.hasFirstPassTimes)
	self.hasBuyFirstPassTimes = checknumber(msg.hasBuyFirstPassTimes)
	self.allHurtCount = 0

	for _, count in ipairs(msg.scoreList) do
		if count and count >= 0 then
			self.allHurtCount = self.allHurtCount + count
		end
	end

	for _, count in ipairs(msg.hellScoreList) do
		if count and count >= 0 then
			self.allHurtCount = self.allHurtCount + count
		end
	end

	self._cardDates = {}

	local highestScore = 0

	self._totalScore = 0

	local cfg = BreakFormationConfig.instance:getTeamCfg(msg.periodId)

	if cfg then
		self._teamId = cfg.teamId

		local teamId = self._teamId
		local cfgs = BreakFormationConfig.instance:getMonsterCfgs(teamId)
		local tem = {}

		for index = 1, #cfgs do
			local monsterCfg = cfgs[index]
			local monsterId = monsterCfg.creepsMasterId
			local creepCfg = BreakFormationConfig.instance:getCreepCfg(teamId, monsterId)
			local showFaceId = monsterCfg.showFaceId

			if showFaceId == nil then
				local max = -1

				for i, v in ipairs(creepCfg) do
					if table.indexof(tem, v.raceId) == false then
						local pw = FightingPowerFormula.instance:getPetMaxFightingPower(v.raceId)

						if max < pw then
							max = pw
							showFaceId = v.raceId
						end
					end
				end

				if #tem > 1 then
					table.remove(tem, 1)
				end

				table.insert(tem, showFaceId)
			end

			local data = {}

			data.raceId = creepCfg[1].raceId
			data.prize = monsterCfg.prize
			data.score = self._scorelist[index]
			data.teamId = teamId
			data.monsterId = monsterId
			data.cfg = monsterCfg
			data.creepCfg = creepCfg
			data.showFaceId = showFaceId
			data.index = index

			table.insert(self._cardDates, data)

			if data.score and data.score > 0 then
				self._totalScore = self._totalScore + data.score

				if highestScore < data.score then
					highestScore = data.score
				end
			end
		end
	end

	self._highestScore = highestScore

	local h = self:createHellData(msg.periodId, self.hellScoreList)

	self._highestScore = math.max(h, self._highestScore)
end

function BreakFormationModel:updatePetListVersion()
	local tmp = BagPetsController.instance:getPetChangeVersion()

	if self._curBagPetVersion == nil then
		self._curBagPetVersion = tmp
	end

	if tmp > self._curBagPetVersion then
		local changePetMoMap = BagPetsController.instance:getPetVersionChangeMap(self._curBagPetVersion)

		self:refreshPetList(changePetMoMap)

		self._curBagPetVersion = tmp
	end
end

function BreakFormationModel:initPetList()
	self.allPetMap = {}

	local map = {}
	local fmo = FormationNewModel.instance:GetCurTeam():GetCurFormation()

	if fmo then
		local pos = fmo:GetPositions()

		for k, v in pairs(pos) do
			map[v] = true
		end
	end

	local pets = BagPetsController.instance:getFightBagPet()
	local list = {}

	for k, v in pairs(pets) do
		if v then
			local mo = FightingPowerPetMo.getMaxPetMoByData(v)

			table.insert(list, mo)

			self.allPetMap[mo.petId] = mo
		end
	end

	self.allPetList = list
end

function BreakFormationModel:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function BreakFormationModel:updatePetMo(mo)
	if self.allPetList then
		local mo = FightingPowerPetMo.getMaxPetMoByData(mo)
		local isHas = false

		for i, v in ipairs(self.allPetList) do
			if v.petId == mo.petId then
				isHas = true

				if mo:isExist() then
					self.allPetList[i] = mo
					self.allPetMap[mo.petId] = mo

					break
				end

				table.remove(self.allPetList, i)

				self.allPetMap[mo.petId] = nil

				break
			end
		end

		if isHas == false and mo:isExist() then
			table.insert(self.allPetList, mo)

			self.allPetMap[mo.petId] = mo
		end
	end
end

function BreakFormationModel:updateFmoPet()
	if self.allPetMap then
		local fmo = FormationNewModel.instance:GetCurTeam():GetCurFormation()

		if fmo then
			local pos = fmo:GetPositions()

			for k, v in pairs(pos) do
				if v > 0 and self.allPetMap[v] == nil then
					local mo = BagPetsController.instance:getPet(v)
					local maxMo = FightingPowerPetMo.getMaxPetMoByData(mo)

					table.insert(self.allPetList, maxMo)

					self.allPetMap[mo.petId] = maxMo
				end
			end
		end
	end
end

function BreakFormationModel:getAllPetList()
	if self.allPetList == nil then
		self:initPetList()
	end

	self:updatePetListVersion()
	self:updateFmoPet()

	return self.allPetList
end

function BreakFormationModel:clearAllPetList()
	return
end

function BreakFormationModel:createHellData(periodId, scorelist)
	self._hellCardDates = {}

	local highestScore = 0
	local cfg = BreakFormationConfig.instance:getTeamCfg(periodId)

	if cfg then
		local teamId = cfg.teamId
		local cfgs = BreakFormationConfig.instance:getHellMonsterCfgs(teamId)
		local tem = {}

		for index = 1, #cfgs do
			local monsterCfg = cfgs[index]
			local monsterId = monsterCfg.creepsMasterId
			local creepCfg = BreakFormationConfig.instance:getHellCreepCfg(teamId, monsterId)
			local showFaceId = monsterCfg.showFaceId

			if showFaceId == nil then
				local max = -1

				for i, v in ipairs(creepCfg) do
					if table.indexof(tem, v.raceId) == false then
						local pw = FightingPowerFormula.instance:getPetMaxFightingPower(v.raceId)

						if max < pw then
							max = pw
							showFaceId = v.raceId
						end
					end
				end

				if #tem > 1 then
					table.remove(tem, 1)
				end

				table.insert(tem, showFaceId)
			end

			local data = {}

			data.raceId = creepCfg[1].raceId
			data.prize = monsterCfg.prize
			data.score = scorelist[index]
			data.teamId = teamId
			data.monsterId = monsterId
			data.cfg = monsterCfg
			data.creepCfg = creepCfg
			data.showFaceId = showFaceId
			data.index = index
			data.isHell = true

			table.insert(self._hellCardDates, data)

			if data.score and data.score > 0 then
				self._totalScore = self._totalScore + data.score

				if highestScore < data.score then
					highestScore = data.score
				end
			end
		end
	end

	return highestScore
end

function BreakFormationModel:getCurMode()
	return self.mode
end

function BreakFormationModel:setCurMode(mode)
	self.mode = mode
end

function BreakFormationModel:getBestScore()
	return self._highestScore
end

function BreakFormationModel:getTotalScore()
	return self._totalScore
end

function BreakFormationModel:getHasFirstPassTimes()
	return checknumber(self.hasFirstPassTimes)
end

function BreakFormationModel:getHasBuyFirstPassTimes()
	return checknumber(self.hasBuyFirstPassTimes)
end

function BreakFormationModel:addHasBuyFirstPassTimes()
	self.hasBuyFirstPassTimes = self.hasBuyFirstPassTimes + 1
end

function BreakFormationModel:getBuffDesc()
	return BreakFormationConfig.instance:getTeamCfg(self._teamId).buffDesc
end

function BreakFormationModel:getConditionDesc(pid)
	local scoreProcessor = BreakFormationConfig.instance:getTeamCfg(pid).scoreProcessor

	return BreakFormationConfig.instance:getBreakParmCfg(scoreProcessor).conditionDesc
end

function BreakFormationModel:handleBreachFormationInfoRes(msg)
	self.isDataInit = true
	self._onlineEnemyInfo = msg or {}
	self._fightDatas = {}

	for difficulty = 1, 3 do
		local data = {}

		data.difficulty = difficulty
		data.enemyPower = checknumber(self._onlineEnemyInfo.zdlList[difficulty])
		data.enemySpeed = checknumber(self._onlineEnemyInfo.speedList[difficulty])
		data.lowestPower = checknumber(self._onlineEnemyInfo.states[difficulty].minFightZdl)
		data.hasGainPrize = checknumber(self._onlineEnemyInfo.states[difficulty].hasGainPrize)

		table.insert(self._fightDatas, data)
	end
end

function BreakFormationModel:onResultBattle(teamId, monsterId, fightPower)
	print("result battle")

	if self:getFightId() == teamId and self._cardDates then
		local data = self._cardDates[monsterId]

		if data then
			data.hasGainPrize = true
		end
	end
end

function BreakFormationModel:getFightId()
	return self._teamId or 1
end

function BreakFormationModel:getMoByDifficulty(difficulty)
	return self._fightDatas[difficulty] or {}
end

function BreakFormationModel:getFormationCardMo(index)
	return self._cardDates[index] or {}
end

function BreakFormationModel:getHellFormationCardMo(index)
	return self._hellCardDates[index] or {}
end

function BreakFormationModel:getFormationCards()
	return self._cardDates or {}
end

function BreakFormationModel:getHellFormationCards()
	return self._hellCardDates or {}
end

function BreakFormationModel:SetPozhenSingleProgReceive(index)
	if self._prizegainstates then
		self._prizegainstates[index] = true
	end
end

function BreakFormationModel:getBtnState(teamId, idx)
	local tempList = BreakFormationConfig.instance:GetPozhenProgByWeek(teamId)
	local sord = 0
	local cfg = BreakFormationConfig.instance:GetPozhenTeamCfg(teamId)

	if cfg then
		sord = cfg.sortOrder
	end

	if tempList == nil or #tempList == 0 then
		return BreakFormationModel.NO_PASS
	end

	if self._prizegainstates[idx] then
		return BreakFormationModel.HAS_GET
	else
		if tempList[idx].needScore <= self.allHurtCount then
			return BreakFormationModel.CAN_GET
		end

		return BreakFormationModel.NOT_ENOUGH
	end
end

function BreakFormationModel:SetPozhenAllProgReceive(allList)
	if allList == nil then
		return
	end

	local tempList = BreakFormationConfig.instance:GetPozhenProgByWeek(self._teamId)
	local sord = 0
	local cfg = BreakFormationConfig.instance:GetPozhenTeamCfg()

	if cfg then
		sord = cfg.sortOrder
	end

	if tempList == nil or #tempList == 0 then
		return
	end

	local isPass = self:IsAllFormationPass()

	for i = 1, #tempList do
		if isPass then
			if allList[i] then
				tempList[i].stage = BreakFormationModel.HAS_GET
			elseif sord == 0 then
				tempList[i].stage = tempList[i].needScore >= self.allHurtCount and 3 or 2
			elseif sord == 1 then
				tempList[i].stage = tempList[i].needScore <= self.allHurtCount and 3 or 2
			end
		else
			tempList[i].stage = 1
		end
	end

	self.progReceiveList = tempList
end

function BreakFormationModel:GetPozhenProgReceiveList()
	self.allHurtCount = self.allHurtCount or 0

	if self.progReceiveList == nil or #self.progReceiveList == 0 then
		self._teamId = self._teamId or 1
		self.progReceiveList = BreakFormationConfig.instance:GetPozhenProgByWeek(self._teamId)
	end

	return self.allHurtCount, self.progReceiveList
end

function BreakFormationModel:GetExplainViewRewardList(typeId)
	local tempList = typeId == 2 and BreakFormationConfig.instance:GetPozhenProgByWeek() or typeId == 3 and BreakFormationConfig.instance:GetPozhenRankByWeek() or BreakFormationConfig.instance:GetPozhenMonsterCfg()

	if tempList == nil then
		return nil
	end

	local list = {}

	for _, item in ipairs(tempList) do
		if item and item.prize ~= "" then
			local strList = string.split(item.prize, "#")

			for i = 1, #strList do
				local subList = string.split(strList[i], ":")
				local str = subList[1] .. ":" .. subList[2]

				if not self:IsInspectIdentical(list, str) then
					table.insert(list, str)
				end
			end
		end
	end

	if list == nil or #list == 0 then
		return nil
	end

	for i = 1, #list do
		list[i] = list[i] .. ":0"
	end

	return table.concat(list, "#")
end

function BreakFormationModel:IsInspectIdentical(list, str)
	if list == nil or #list == 0 then
		return false
	end

	for i = 1, #list do
		if list[i] and list[i] == str then
			return true
		end
	end

	return false
end

function BreakFormationModel:SetPozhanScorelist(index, score)
	if index == nil or score == nil then
		return
	end

	self._scorelist = self._scorelist or {}

	if score > checknumber(self._scorelist[index]) then
		self.newScoreIdx = index

		print(">>>>>>>>>>>>>>>>> 得到新分数的IDX -- 使用后 赋值 nil", index)

		local offset = score - math.max(0, checknumber(self._scorelist[index]))

		self._totalScore = self._totalScore + offset
		self.allHurtCount = self.allHurtCount + offset
	end

	self._scorelist[index] = score

	local data = self:getFormationCardMo(index)

	data.score = self._scorelist[index]
end

function BreakFormationModel:GetPozhanScorelist(index)
	if index == nil then
		return nil
	end

	if self._scorelist == nil or self._scorelist[index] == nil then
		return nil
	end

	return self._scorelist[index]
end

function BreakFormationModel:SetHellPozhanScorelist(index, score)
	if index == nil or score == nil then
		return
	end

	self.hellScoreList = self.hellScoreList or {}

	if score > checknumber(self.hellScoreList[index]) then
		self.newScoreIdx = index

		print(">>>>>>>>>>>>>>>>> 得到新分数的IDX -- 使用后 赋值 nil", index)
	end

	self.hellScoreList[index] = score

	local data = self:getHellFormationCardMo(index)

	data.score = self.hellScoreList[index]
end

function BreakFormationModel:GetHellPozhanScorelist(index)
	if index == nil then
		return nil
	end

	if self.hellScoreList == nil or self.hellScoreList[index] == nil then
		return nil
	end

	return self.hellScoreList[index]
end

function BreakFormationModel:GetPozhanScorelistByType(isNormal, index)
	if isNormal then
		return self:GetPozhanScorelist(index)
	else
		return self:GetHellPozhanScorelist(index)
	end
end

function BreakFormationModel:getNewScoreIdx()
	return self.newScoreIdx
end

function BreakFormationModel:resetNewScoreIdx()
	print("resetNewScoreIdx = " .. debug.traceback())

	self.newScoreIdx = nil
end

function BreakFormationModel:setLastIdx(idx)
	self.lastIdx = idx
end

function BreakFormationModel:getAndResetLastIdx()
	self.lastIdx = nil

	return self.lastIdx
end

function BreakFormationModel:IsAllFormationPass()
	if self._scorelist == nil then
		return false
	end

	for _, score in ipairs(self._scorelist) do
		if score == nil or score < 0 then
			return false
		end
	end

	return true
end

function BreakFormationModel:isFirstEnter()
	if not self._isFirstEnterInit then
		self._isFirstEnterInit = true
		self._isFirstEnter = GameUtil.isEmptyString(GameUtil.getLocalString(RoleModel.instance:getUserName() .. "isFirstEnterBreakFormation")) or false
	end

	return self._isFirstEnter
end

function BreakFormationModel:setHasEnter()
	if not self._isFirstEnter then
		return
	end

	self._isFirstEnter = false

	GameUtil.setLocalString(RoleModel.instance:getUserName() .. "isFirstEnterBreakFormation", "true")
end

BreakFormationModel.instance = BreakFormationModel.New()

return BreakFormationModel
