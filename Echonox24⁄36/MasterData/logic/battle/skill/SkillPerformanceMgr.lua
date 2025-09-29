-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/SkillPerformanceMgr.lua

module("logic.battle.skill.SkillPerformanceMgr", package.seeall)

local SkillPerformanceMgr = class("SkillPerformanceMgr")
local kGGG = getglobal("_G")

function SkillPerformanceMgr:ctor()
	self._standardPerformance = SkillStandardPerformance.New()
	self._soloPerformance = SkillSoloPerformance.New()
	self._multiSoloPerformance = SkillMultiSoloPerformance.New()
	self._skipPerformance = SkillSkipPerformance.New()
	self._specificPerformanceList = {}
	self._activePerformance = false
	self._preResLoader = BattleMultiResLoaderIncludeModel.New()
	self._skillVSInfo = SkillVSInfo:createInstance()
	self._hasPreload = false
	self._attackInfo = SkillAttackInfo:createInstance()
	self._nextAttackInfo = SkillAttackInfo:createInstance()
end

function SkillPerformanceMgr:init()
	self._standardPerformance:init()
end

function SkillPerformanceMgr:interruptSpecificPerfromance(entityId, skillId)
	local performance = self:_getSpecificPerformance(entityId, skillId)

	if performance then
		table.removebyvalue(self._specificPerformanceList, performance)
		performance:interrupt()
		performance:returnSelf()
	end
end

function SkillPerformanceMgr:doPreprocessSkill(skillVSInfo, callback, callbackSelf)
	self._hasPreload = false

	self._skillVSInfo:copyFrom(skillVSInfo)

	local attacker = skillVSInfo:getAttacker()
	local performance = self:_getOrCreateSpecificPerformance(attacker.property:getEntityId(), skillVSInfo:getSkillId())

	if not performance then
		return
	end

	performance:doPreprocessSkill(skillVSInfo, callback, callbackSelf)

	return true
end

function SkillPerformanceMgr:beginPerformance(skillVSInfo, callback, callbackSelf)
	if self._activePerformance then
		if BattleLog.enableError then
			BattleLog.error("SkillPerformanceMgr::current is running.")
		end

		return
	end

	self._hasPreload = false

	self._skillVSInfo:copyFrom(skillVSInfo)
	BattleMainViewFacade.instance:lockOperation()
	Handler:executeCallback(callback, callbackSelf)
end

function SkillPerformanceMgr:doAttack(attackInfo, callback, callbackSelf)
	local nextPerformance = self:_getPerformance(attackInfo)
	local currentPeformance = self._activePerformance

	self._activePerformance = nextPerformance

	if nextPerformance ~= currentPeformance then
		if currentPeformance then
			self._nextAttackInfo:copyFrom(attackInfo)

			self._nextAttackCallBack = callback
			self._nextAttackCallbackSelf = callbackSelf

			currentPeformance:endPerformance(self._onLastPerformanceFinish, self)

			return
		else
			nextPerformance:beginPerformance(self._skillVSInfo)
		end
	end

	self:_preloadAndDoAttack(attackInfo, callback, callbackSelf)
end

function SkillPerformanceMgr:_onLastPerformanceFinish()
	if not self._activePerformance then
		return
	end

	self._activePerformance:beginPerformance(self._skillVSInfo)
	self:_preloadAndDoAttack(self._nextAttackInfo, self._nextAttackCallBack, self._nextAttackCallbackSelf)
	self._nextAttackInfo:clear()

	self._nextAttackCallBack = false
	self._nextAttackCallbackSelf = false
end

function SkillPerformanceMgr:_preloadAndDoAttack(attackInfo, callback, callbackSelf)
	if not self._hasPreload and OOPUtil.isInstanceOf(self._activePerformance, SkillStandardPerformance) then
		self._attackInfo:clear()
		self._attackInfo:copyFrom(attackInfo)

		self._attackFunc = callback
		self._attackHandler = callbackSelf

		self:_preloadResource(self._skillVSInfo, self._, callbackSelf)
	else
		self._activePerformance:doAttack(attackInfo, callback, callbackSelf)
	end
end

function SkillPerformanceMgr:_getPerformance(attackInfo)
	local skillVSInfo = self._skillVSInfo
	local attacker = attackInfo:getAttacker()
	local isStrengthen = attackInfo:isStrengthening()
	local performance = self:_getOrCreateSpecificPerformance(attacker.property:getEntityId(), attackInfo:getSkillId())

	if performance then
		return performance
	elseif skillVSInfo:isForceSolo() or SkillPerformanceCOUtil.isSoloPerformance(attackInfo:getSkillId(), isStrengthen) then
		local isMultiSoloPerformance = SkillPerformanceCOUtil.isMultiSoloPerformance(attacker, attackInfo:getSkillId())

		if isMultiSoloPerformance then
			local settingModel = BattleMgr.instance:getSettingModel()

			return settingModel:isEnableSkillPerformance(attacker) and self._multiSoloPerformance or self._skipPerformance
		else
			return self._soloPerformance
		end
	else
		local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(attackInfo:getSkillId())

		if ActiveSkillCOUtil.isNormal(skillCOWrapper, isStrengthen) then
			return self._skipPerformance
		else
			local settingModel = BattleMgr.instance:getSettingModel()

			if settingModel:isEnableSkillPerformance(skillVSInfo:getAttacker()) then
				return self._standardPerformance
			else
				return self._skipPerformance
			end
		end
	end
end

function SkillPerformanceMgr:endPerformance(callback, callbackSelf)
	if not self:_checkRunning() then
		return
	end

	self._activePerformance:endPerformance(callback, callbackSelf)
	self:_onClear()
	BattleMainViewFacade.instance:unlockOperation()
end

function SkillPerformanceMgr:isInPerformance()
	return self._activePerformance and true or false
end

function SkillPerformanceMgr:interrupt()
	if self._activePerformance then
		self._activePerformance:interrupt()
		self:_onClear()

		self._activePerformance = false
	end

	self:_interruptAllSpecificPerformance()
end

function SkillPerformanceMgr:syncVSInfo(attackInfo)
	if self._activePerformance then
		self._activePerformance:syncVSInfo(false, attackInfo)
	end
end

function SkillPerformanceMgr:setSpecificPerformanceVisible(visible)
	for _, performance in ipairs(self._specificPerformanceList) do
		if performance ~= self._activePerformance then
			performance:setVisible(visible)
		end
	end
end

function SkillPerformanceMgr:internal_isSkipPerformance()
	return self._activePerformance == self._skipPerformance
end

function SkillPerformanceMgr:_clearActivePerformance()
	if OOPUtil.isInstanceOf(self._activePerformance, ISpecificSkillPerformance) then
		table.removebyvalue(self._specificPerformanceList, self._activePerformance)
		self._activePerformance:returnSelf()
	end

	self._activePerformance = false
end

function SkillPerformanceMgr:_getOrCreateSpecificPerformance(entityId, skillId)
	local perfromanceClassName = string.format("SkillPerformance_%s", skillId)
	local perfromanceClass = kGGG[perfromanceClassName]

	if not perfromanceClass then
		return false
	end

	local performance = self:_getSpecificPerformance(entityId, skillId)

	if performance then
		return performance
	end

	performance = perfromanceClass:createInstance()

	performance:bindEntityAndSkill(entityId, skillId)
	table.insert(self._specificPerformanceList, performance)

	return performance
end

function SkillPerformanceMgr:_getSpecificPerformance(entityId, skillId)
	for _, performance in ipairs(self._specificPerformanceList) do
		if performance:checkEntityAndSkill(entityId, skillId) then
			return performance
		end
	end

	return false
end

function SkillPerformanceMgr:_interruptAllSpecificPerformance()
	for _, performance in ipairs(self._specificPerformanceList) do
		performance:interrupt()
	end

	BattleTableUtil.clearReusableTable(self._specificPerformanceList)
end

function SkillPerformanceMgr:_checkRunning()
	if not self._activePerformance then
		if BattleLog.enableError then
			BattleLog.error("SkillPerformanceMgr::current is not running.")
		end

		return false
	end

	return true
end

function SkillPerformanceMgr:_preloadResource(skillVSInfo)
	SkillPerformanceAssistant:collectSkillVSInfoPreloadList(self._preResLoader, skillVSInfo)
	self._preResLoader:load(self._onAllLoaded, self)
end

function SkillPerformanceMgr:_onAllLoaded()
	self._hasPreload = true

	self._activePerformance:doAttack(self._attackInfo, self._attackFunc, self._attackHandler)
	self._attackInfo:clear()

	self._attackFunc = false
	self._attackHandler = false
end

function SkillPerformanceMgr:_onClear()
	self:_clearActivePerformance()
	self._skillVSInfo:clear()
	self._attackInfo:clear()
	self._preResLoader:clear()

	self._attackFunc = false
	self._attackHandler = false
	self._hasPreload = false

	self._nextAttackInfo:clear()

	self._nextAttackCallBack = false
	self._nextAttackCallbackSelf = false
end

SkillPerformanceMgr.instance = SkillPerformanceMgr.New()

return SkillPerformanceMgr
