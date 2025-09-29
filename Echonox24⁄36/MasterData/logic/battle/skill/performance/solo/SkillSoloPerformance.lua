-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/solo/SkillSoloPerformance.lua

module("logic.battle.skill.performance.solo.SkillSoloPerformance", package.seeall)

local SkillSoloPerformance = class("SkillSoloPerformance", ISkillPerformance)

function SkillSoloPerformance:ctor()
	self._skillVSInfo = SkillVSInfo.New()
	self._context = SkillTimelineContext.New(self._skillVSInfo)
	self._soloInMainScene = SkillSoloInMainScene.New()
	self._attackInfo = SkillAttackInfo:createInstance()
	self._handler = Handler.New()
end

function SkillSoloPerformance:beginPerformance(skillVSInfo, callback, callbackSelf)
	self._skillVSInfo:copyFrom(skillVSInfo)
	self._soloInMainScene:bindContext(self._context)
	Handler:executeCallback(callback, callbackSelf)
end

function SkillSoloPerformance:endPerformance(callback, callbackSelf)
	Handler:executeCallback(callback, callbackSelf)
end

function SkillSoloPerformance:doAttack(attackInfo, callback, callbackSelf)
	self._attackInfo:copyFrom(attackInfo)
	self._handler:setListener(callback, callbackSelf)

	local attacker = attackInfo:getAttacker()
	local animState = attackInfo:getAnimState()

	if checkint(animState) ~= 0 then
		local effectCode = tonumber(animState)
		local url = EffectUtil.getEffectUrl(effectCode)

		self._soloInMainScene:setupAudioName(EffectUtil.getAudioName(effectCode))
		self._soloInMainScene:loadResource(url, self._onResLoaded, self)
	else
		local timelineResPath = SkillPerformanceConfig.instance:getSkillPerformanceTimeline(attackInfo:getAnimState(), attacker.property:getModelCode())
		local url = BattleSkillAssist.get3dEffectSkillUrl(timelineResPath, attacker, attackInfo:getFirstVictim(), attackInfo:getSkillId(), attackInfo:isStrengthening())

		self._soloInMainScene:setupAudioName(SkillPerformanceAssistant:getSkillAudioName(timelineResPath))
		self._soloInMainScene:setTimelineResPath(timelineResPath)
		self._soloInMainScene:loadResource(url, self._onResLoaded, self)
	end
end

function SkillSoloPerformance:interrupt()
	self:_internalStop()
	self._handler:callAndClear()
end

function SkillSoloPerformance:_internalStop()
	self._soloInMainScene:stop()
	self._soloInMainScene:clear()
	self._attackInfo:clear()
	self._skillVSInfo:clear()
	self._context:clear()
end

function SkillSoloPerformance:_onResLoaded()
	self._soloInMainScene:start(self._attackInfo, self._onPerformanceFinished, self)
end

function SkillSoloPerformance:_onPerformanceFinished()
	self:_internalStop()
	self._handler:callAndClear()
end

return SkillSoloPerformance
