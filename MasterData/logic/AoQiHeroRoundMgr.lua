-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/controller/battlemgr/AoQiHeroRoundMgr.lua

module("logic.extensions.aoqihero.controller.battlemgr.AoQiHeroRoundMgr", package.seeall)

local AoQiHeroRoundMgr = class("AoQiHeroRoundMgr")

function AoQiHeroRoundMgr:ctor()
	self.id = 0
	self.roundIndex = 0
	self.curStepCount = 0
	self.curRoundIndex = 1
	self.endRoundIndex = 0
	self._roundList = {}
	self.objectPool = nil
	self.myTeamFinish = false
	self.enemyTeamFinish = false
	self.endRoundReportMos = {}

	local function resetFunc()
		return
	end

	local function disposeFunc()
		return
	end

	self.reportPool = ObjectPool.New(100, nil, disposeFunc, resetFunc)
end

function AoQiHeroRoundMgr:initData(activityId)
	self._activityId = activityId
	self._activityCfg = AoQiHeroConfig.instance:getActivityCfg(self._activityId)
	self.id = 1
	self.roundIndex = 0
	self.curStepCount = 0
	self.curRoundIndex = 1
	self.endRoundIndex = 0

	for i, roundMo in pairs(self._roundList) do
		for j, reportMos in ipairs(roundMo.reportMosList) do
			for q, reportMo in ipairs(reportMos) do
				self:returnReportMo(reportMo)
			end
		end
	end

	for i, mos in pairs(self.endRoundReportMos) do
		for j, reportMo in pairs(mos) do
			self:returnReportMo(reportMo)
		end
	end

	self.endRoundReportMos = {}
	self._roundList = {}
	self.objectPool = nil
	self.myTeamFinish = false
	self.enemyTeamFinish = false
end

function AoQiHeroRoundMgr:getBigRound()
	return self.roundIndex
end

function AoQiHeroRoundMgr:startBigRound()
	self.roundIndex = self.roundIndex + 1
	self.enemyTeamFinish = false
	self.myTeamFinish = false

	AoQiHeroEntityMgr.instance:resetAllActive()

	local reportMos = AoQiHeroBuffMgr.instance:activeBuff(AoQiHeroConst.TimeBigRoundStart)
	local hasReportMos = false

	for i, v in pairs(reportMos) do
		if v then
			hasReportMos = true

			break
		end
	end

	if hasReportMos == true then
		local roundMo = self:addEmptyRound(AoQiHeroConst.TimeBigRoundStart)

		roundMo:mergeReportMos(reportMos)
		self:deadCheck()
		roundMo:startMotion()
	end

	return hasReportMos
end

function AoQiHeroRoundMgr:startRound()
	self.roundRuning = true
	self.runingTeam = self:getCurTeamType()

	local roundMo = AoQiHeroRoundMgr.instance:getTopRound()

	roundMo:startMotion()
	roundMo:onRoundStart()
	self:deadCheck()

	if roundMo.belongUnit and AoQiHeroEntityMgr.instance:isPetSurvival(roundMo.belongUnit) then
		if roundMo.skillMo then
			roundMo:startMotion()
			roundMo:onSkillEffect()

			if not roundMo.skillMo.isSuper and roundMo.skillMo.targetA then
				local skillPetMo = AoQiHeroEntityMgr.instance:getPet(roundMo.skillMo.targetA)

				skillPetMo:changeEnergy(self._activityCfg.attackStandEnergy)
			elseif roundMo.skillMo.isSuper and roundMo.skillMo.targetA then
				local skillPetMo = AoQiHeroEntityMgr.instance:getPet(roundMo.skillMo.targetA)

				skillPetMo:clearEnergy()
			end

			local reportMos = AoQiHeroBuffMgr.instance:activeBuff(AoQiHeroConst.TimeAttack, roundMo.skillMo.targetA, roundMo.skillMo.targetB)

			roundMo:mergeReportMos(reportMos)

			local skillIsDead, skillDeadList = false, {}
			local tempIsDead, tempDeadList = self:deadCheck()

			if tempIsDead == true then
				skillIsDead = true

				for i, v in ipairs(tempDeadList) do
					table.insert(skillDeadList, v)
				end
			end

			roundMo:startMotion()

			for i, v in ipairs(roundMo.skillMo.targetB) do
				if AoQiHeroEntityMgr.instance:isPetSurvival(v) == true then
					local beAttackReportMos = AoQiHeroBuffMgr.instance:activeBuff(AoQiHeroConst.TimeBeAttacked, v, roundMo.skillMo.targetA)

					roundMo:mergeReportMos(beAttackReportMos)
				end
			end

			tempIsDead, tempDeadList = self:deadCheck()

			if tempIsDead == true then
				skillIsDead = true

				for i, v in ipairs(tempDeadList) do
					table.insert(skillDeadList, v)
				end
			end

			if skillIsDead == true then
				local skillPetMo = AoQiHeroEntityMgr.instance:getPet(roundMo.skillMo.targetA)

				skillPetMo:changeEnergy(self._activityCfg.killEnergy * #skillDeadList)
			end
		end

		roundMo:startMotion()

		if roundMo.moveInfo and roundMo:onMoveEntity() then
			-- block empty
		end
	end

	roundMo:startMotion()
	roundMo:onRoundEnd()
	self:deadCheck()

	if roundMo and roundMo.belongUnit then
		local entityMo = AoQiHeroEntityMgr.instance:getPet(roundMo.belongUnit)

		entityMo.isActive = true
	end

	roundMo:startMotion()
end

function AoQiHeroRoundMgr:endRound()
	self:popTopRound()

	if AoQiHeroRoundMgr.instance:getTopRound() then
		return
	end

	local teamMo = AoQiHeroEntityMgr.instance:getTeamMo(self.runingTeam)
	local hasActive = false

	for i, v in ipairs(teamMo.pos) do
		local entityMo = AoQiHeroEntityMgr.instance:getPet(v)

		if v ~= AoQiHeroConst.TowerEntityId and AoQiHeroEntityMgr.instance:isPetSurvival(v) and entityMo.isActive == false then
			hasActive = true

			break
		end
	end

	if hasActive == false then
		if self.runingTeam == AoQiHeroConst.AttackTeam then
			self.myTeamFinish = true
		else
			self.enemyTeamFinish = true
		end
	end
end

function AoQiHeroRoundMgr:isEndBigRound()
	return self.myTeamFinish and self.enemyTeamFinish
end

function AoQiHeroRoundMgr:endBigRound()
	local reportMos = AoQiHeroBuffMgr.instance:activeBuff(AoQiHeroConst.TimeBigRoundEnd)
	local hasReportMos = false

	for i, v in pairs(reportMos) do
		if v then
			hasReportMos = true

			break
		end
	end

	if hasReportMos == true then
		local roundMo = self:addEmptyRound(AoQiHeroConst.TimeBigRoundEnd)

		roundMo:mergeReportMos(reportMos)
		self:deadCheck()
		roundMo:startMotion()
	end

	local reduceBuffReportMos = AoQiHeroBuffMgr.instance:changeAllBuffTime()
	local hasReduceReportMos = false

	for i, v in pairs(reduceBuffReportMos) do
		if v then
			hasReduceReportMos = true

			break
		end
	end

	if hasReduceReportMos == true then
		local endRound = self:getEndRound()

		if endRound and endRound.time == AoQiHeroConst.TimeBigRoundEnd then
			endRound:mergeReportMos(reduceBuffReportMos)
		else
			local roundMo = self:addEmptyRound(AoQiHeroConst.TimeBigRoundEnd)

			roundMo:mergeReportMos(reduceBuffReportMos)
		end
	end

	self.endRoundReportMos[self.roundIndex] = reduceBuffReportMos
end

function AoQiHeroRoundMgr:getEndRoundReportMos(roundIndex)
	return self.endRoundReportMos[roundIndex] or {}
end

function AoQiHeroRoundMgr:createAndAddEmptyRound()
	local roundMo = AoQiHeroRoundMgr.instance:getEndRound()

	if not roundMo or roundMo.isInit == true then
		roundMo = AoQiHeroRoundMo.New()

		table.insert(self._roundList, roundMo)

		roundMo.isInit = false
		self.endRoundIndex = self.endRoundIndex + 1
	end
end

function AoQiHeroRoundMgr:addRound(skillMo, teamId, moveInfo, petId)
	local insertSkillMo = skillMo
	local roundMo = AoQiHeroRoundMgr.instance:getEndRound()

	if not roundMo or roundMo.isInit == true then
		roundMo = AoQiHeroRoundMo.New()

		table.insert(self._roundList, roundMo)

		self.endRoundIndex = self.endRoundIndex + 1
	end

	roundMo.roundIndex = self.roundIndex
	roundMo.isInit = true
	roundMo.skillMo = insertSkillMo
	roundMo.teamId = teamId
	roundMo.moveInfo = moveInfo
	roundMo.belongUnit = petId
end

function AoQiHeroRoundMgr:addEmptyRound(time)
	local roundMo = AoQiHeroRoundMgr.instance:getEndRound()

	if not roundMo or roundMo.isInit == true then
		roundMo = AoQiHeroRoundMo.New()

		table.insert(self._roundList, roundMo)

		self.endRoundIndex = self.endRoundIndex + 1
	end

	roundMo.roundIndex = self.roundIndex
	roundMo.isInit = true
	roundMo.time = time

	return roundMo
end

function AoQiHeroRoundMgr:popTopRound()
	local roundMo = AoQiHeroRoundMgr.instance:getTopRound()

	if roundMo and roundMo.isInit == true then
		self.curRoundIndex = self.curRoundIndex + 1
	end
end

function AoQiHeroRoundMgr:getTopRound()
	return self._roundList[self.curRoundIndex]
end

function AoQiHeroRoundMgr:getEndRound()
	return self._roundList[self.endRoundIndex]
end

function AoQiHeroRoundMgr:getCurTeamType()
	if not self.myTeamFinish then
		return AoQiHeroConst.AttackTeam
	elseif not self.enemyTeamFinish then
		return AoQiHeroConst.DefenceTeam
	end

	return nil
end

function AoQiHeroRoundMgr:getBigRoundList(roundIndex)
	local roundList = {}

	for i = self.endRoundIndex, 1, -1 do
		local roundMo = self._roundList[i]

		if roundMo.roundIndex == roundIndex then
			table.insert(roundList, 1, roundMo)
		end
	end

	return roundList
end

function AoQiHeroRoundMgr:getRuningTeam()
	return self.runingTeam
end

function AoQiHeroRoundMgr:getCurStepCount()
	return self.curStepCount
end

function AoQiHeroRoundMgr:getNewReportMo()
	local reportMo = self.reportPool:fetchObject()

	reportMo = reportMo or AoQiHeroReportMo.New()

	return reportMo
end

function AoQiHeroRoundMgr:returnReportMo(mo)
	mo:reset()
	self.reportPool:returnObject(mo)
end

function AoQiHeroRoundMgr:deadCheck()
	local roundMo = AoQiHeroRoundMgr.instance:getTopRound()
	local totalIsDead = false
	local totalDeadList = {}
	local isDead, deadList = AoQiHeroEntityMgr.instance:deadCheck()

	AoQiHeroEntityMgr.instance:setDeadRoot()

	while isDead == true do
		totalIsDead = true

		for i, v in ipairs(deadList) do
			table.insert(totalDeadList, v)
		end

		roundMo:startMotion()

		for i, v in ipairs(deadList) do
			local reportMo = AoQiHeroBuffMgr.instance:activeBuff(AoQiHeroConst.TimeDead, v)

			roundMo:mergeReportMos(reportMo)
			AoQiHeroBattleModel.instance:clearPetId(v)
		end

		AoQiHeroEntityMgr.instance:setDeadRoot()

		isDead, deadList = AoQiHeroEntityMgr.instance:deadCheck()
	end

	return totalIsDead, totalDeadList
end

AoQiHeroRoundMgr.instance = AoQiHeroRoundMgr.New()

return AoQiHeroRoundMgr
