-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/skip/SkillSkipPerformance.lua

module("logic.battle.skill.performance.skip.SkillSkipPerformance", package.seeall)

local SkillSkipPerformance = class("SkillSkipPerformance", ISkillPerformance)
local kStrengthenHalf = 0.4
local kEnterBlurOut = 0.4

function SkillSkipPerformance:ctor()
	self._skillVSInfo = SkillVSInfo:createInstance()
	self._context = SkillTimelineContext.New(self._skillVSInfo)
	self._handler = Handler.New()
	self._runningPlayer = false
end

function SkillSkipPerformance:beginPerformance(skillVSInfo, callback, callbackSelf)
	self._skillVSInfo:copyFrom(skillVSInfo)
	ViewMgr.instance:open(ViewName.BattleVs, true)
	BattleBossPropertyFacade.instance:setVisible(false, BattleConst.DefaultStateKey)
	Handler:executeCallback(callback, callbackSelf)
end

function SkillSkipPerformance:doAttack(attackInfo, callback, callbackSelf)
	self:_stopRunningPlayer()
	self:_clearBeforeAttack(attackInfo)

	self._runningPlayer = SkillSkipPlayer:createInstance()

	self._runningPlayer:bindContext(self._context)
	self._runningPlayer:doAttack(attackInfo, callback, callbackSelf)
end

function SkillSkipPerformance:_clearBeforeAttack(attackInfo)
	if attackInfo:isStrengthening() then
		local attacker = attackInfo:getAttacker()

		attacker.property:inactiveState(BattleEnum.State.SANITY_STRENGTHEN)
		attacker.effectPlayer:stopLoopEffectWithAnim(BattleConst.SANITY_BURN_LOOP_EFFECT, "End", 0.5)
	end
end

function SkillSkipPerformance:endPerformance(callback, callbackSelf)
	self:_stopRunningPlayer()
	ViewMgr.instance:close(ViewName.BattleVs)
	BattleBossPropertyFacade.instance:setVisible(true, BattleConst.DefaultStateKey)
	Handler:executeCallback(callback, callbackSelf)
end

function SkillSkipPerformance:interrupt()
	self:_internalStop()
	self._handler:callAndClear()
end

function SkillSkipPerformance:syncVSInfo(isInit, attackInfo)
	return
end

function SkillSkipPerformance:_internalStop()
	self:_stopRunningPlayer()
	self._skillVSInfo:clear()
	self._context:clear()
end

function SkillSkipPerformance:_stopRunningPlayer()
	if self._runningPlayer then
		self._runningPlayer:doStop()
		self._runningPlayer:returnSelf()

		self._runningPlayer = false
	end
end

return SkillSkipPerformance
