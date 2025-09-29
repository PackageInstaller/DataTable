-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/battleflow/FootBallCompReleaseSkillAgent.lua

module("logic.extensions.football.battleflow.FootBallCompReleaseSkillAgent", package.seeall)

local FootBallCompReleaseSkillAgent = class("FootBallCompReleaseSkillAgent", IBattleFlowComp, IBattleReleaseSkillAgent)

function FootBallCompReleaseSkillAgent:onStart()
	self._unitMgr = self.flow.unitMgr or false
	self._sharedPathFinder = self.flow.sharedPathFinder or false
	self._netAgent = self.flow.netAgent or false
	self._forecastMgr = self.flow.forecastMgr or false
end

function FootBallCompReleaseSkillAgent:onClear()
	self._unitMgr = false
	self._sharedPathFinder = false
	self._netAgent = false
	self._forecastMgr = false
end

function FootBallCompReleaseSkillAgent:isValidSkillTarget(unit, targetUnionIndex, skillId)
	local targetUnit = self._unitMgr:getUnitOnUnionIndex(targetUnionIndex)
	local isTargetFootBall = FootBallCompReleaseSkillAgent.isFootball(targetUnit)

	if isTargetFootBall and unit ~= targetUnit and BattleSkillAssist.isTransportSkill(skillId, unit.skill:getSkillStatus()) then
		return true, false
	end

	if not BattleSkillAssist.validateSkillTarget(unit, targetUnionIndex, skillId) then
		return false
	end

	if not BattleSkillAssist.isDamage(skillId, unit.skill:getSkillStatus()) then
		return true, false
	end

	return true, isTargetFootBall
end

function FootBallCompReleaseSkillAgent:requestAttack(releaseSkillContext)
	local unit = self._unitMgr:getUnit(releaseSkillContext.entityId)
	local skillId = releaseSkillContext.selectedSkillId
	local isValid, isQTE = self:isValidSkillTarget(unit, releaseSkillContext.targetUnionIndex, skillId)

	if not isValid then
		return false
	end

	GlobalDispatcher:dispatchEvent(EventType.FOOTBALL_MANNUAL_ATTACK)

	if not isQTE then
		FootBallCompReleaseSkillAgent.sendAttack(releaseSkillContext)

		return true
	end

	local targetUnit = self._unitMgr:getUnitOnUnionIndex(releaseSkillContext.targetUnionIndex)

	if not BattleSkillAssist.checkTwoUnitsInDistance(unit, targetUnit, 1) then
		FloatWordMgr.instance:show("必须在相邻格才能攻击NPC！")

		return false
	end

	local skillMO = unit.skill:getActiveSkillById(releaseSkillContext.selectedSkillId)

	if skillMO:isNormalSkill() then
		local qteScore = FootBallCompReleaseSkillAgent._randomQTEScore()

		FootBallCompReleaseSkillAgent.sendQTEAttack(releaseSkillContext, qteScore)

		return true
	end

	local qteAttackContext = BattleReleaseSkillContext:createInstance()

	qteAttackContext:copyFrom(releaseSkillContext)
	ViewMgr.instance:open(ViewName.FootballQTE, qteAttackContext)

	return true
end

function FootBallCompReleaseSkillAgent:requestForecast(releaseSkillContext)
	local unit = self._unitMgr:getUnit(releaseSkillContext.entityId)
	local pathUnionIndexs = self._sharedPathFinder:findPathForServer(unit, releaseSkillContext.selectedSkillId, releaseSkillContext.originUnionIndex, releaseSkillContext.stopUnionIndex)
	local transportUnionIndex = releaseSkillContext.transportUnionIndex
	local targetUnit = self._unitMgr:getUnitOnUnionIndex(releaseSkillContext.targetUnionIndex)

	if targetUnit and FootBallCompReleaseSkillAgent.isFootball(targetUnit) then
		transportUnionIndex = releaseSkillContext.targetUnionIndex
	end

	return self._forecastMgr:requestForecast(releaseSkillContext.entityId, pathUnionIndexs, releaseSkillContext.selectedSkillId, releaseSkillContext.targetUnionIndex, transportUnionIndex, releaseSkillContext.isStrenthening, releaseSkillContext.lookAtDirection)
end

function FootBallCompReleaseSkillAgent:requestEndStage()
	BattleDispatcher:dispatchEvent(BattleEventType.OnForceOperate)
end

function FootBallCompReleaseSkillAgent.isFootball(unit)
	if not unit then
		return false
	end

	local entityCode = unit.property:getEntityCode()

	if not BattleUnitUtil.isCharacter(unit) then
		local entityCO = MonsterConfig.instance:getMonsterCO(entityCode)

		if entityCO.battleCamp == BattleEnum.MonsterCampType.NONE then
			return true
		end
	end

	return false
end

function FootBallCompReleaseSkillAgent.sendQTEAttack(releaseSkillContext, qteScore)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(releaseSkillContext.entityId)
	local targetUnit = unitMgr:getUnitOnUnionIndex(releaseSkillContext.targetUnionIndex)

	releaseSkillContext.transportUnionIndex = BattleSkillAssist.calculateRepelCellIndex(unit, targetUnit, qteScore)

	FootBallCompReleaseSkillAgent.sendAttack(releaseSkillContext)
end

function FootBallCompReleaseSkillAgent.sendAttack(releaseSkillContext)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local pathFinder = BattleMgr.instance:getSharedPathFinder()
	local netAgent = BattleMgr.instance:getNetAgent()
	local unit = unitMgr:getUnit(releaseSkillContext.entityId)
	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	local pathUnionIndexs = pathFinder:findPathForServer(unit, releaseSkillContext.selectedSkillId, releaseSkillContext.originUnionIndex, unionIndex)

	netAgent:sendStepRequest(releaseSkillContext.entityId, pathUnionIndexs, releaseSkillContext.selectedSkillId, releaseSkillContext.targetUnionIndex, releaseSkillContext.transportUnionIndex, releaseSkillContext.isStrenthening, releaseSkillContext.lookAtDirection)
end

function FootBallCompReleaseSkillAgent._randomQTEScore()
	local jsonConfig = FootBallConfig.instance:getConstJson(FootBallConstEnum.NormalAttackScores)
	local totalWeight = 0

	for _, weightCell in ipairs(jsonConfig) do
		totalWeight = totalWeight + weightCell[2]
	end

	local weight = 0
	local randomWeight = math.random(totalWeight)

	for _, weightCell in ipairs(jsonConfig) do
		weight = weight + weightCell[2]

		if randomWeight <= weight then
			return weightCell[1]
		end
	end

	return 0
end

return FootBallCompReleaseSkillAgent
