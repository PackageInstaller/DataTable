-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/standard/SkillStandardPerformance.lua

module("logic.battle.skill.performance.standard.SkillStandardPerformance", package.seeall)

local SkillStandardPerformance = class("SkillStandardPerformance", ISkillPerformance)
local kEnterBlurOut = 0.4
local kStrengthenFinish = 1
local kStrengthenHalf = 0.4
local kExitBlurDuration = 0.2
local SkillPerformanceAssistant = SkillPerformanceAssistant

function SkillStandardPerformance:ctor()
	self._skillVSInfo = SkillVSInfo:createInstance()
	self._context = SkillTimelineContext.New(self._skillVSInfo)
	self._timelineTask = TimelineTask.New()
	self._timelineDelayTask = TimelineTask.New()
	self._handler = Handler.New()
	self._resLoader = MultiResLoader.New()
	self._runningPlayer = false
	self._isEnteredPerformance = false
end

function SkillStandardPerformance:init()
	self._context:init()
end

function SkillStandardPerformance:beginPerformance(skillVSInfo, callback, callbackSelf)
	self._isEnteredPerformance = false

	self._skillVSInfo:copyFrom(skillVSInfo)
	self._handler:setListener(callback, callbackSelf)
	SkillPerformanceAssistant:activeAttackTemporaryCamera(self._context, 0)
end

function SkillStandardPerformance:doAttack(attackInfo, callback, callbackSelf)
	self:_judgeReversePosition(attackInfo)

	local player = SkillTimelinePlayer:createInstance()

	player:bindContext(self._context)
	player:bindFinishListener(callback, callbackSelf)
	player:loadResource(attackInfo, self._onTimelinePlayerResourceLoaded, self)
end

function SkillStandardPerformance:endPerformance(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self:_exitPerformanceScene()
end

function SkillStandardPerformance:interrupt()
	self:_internalStop()
	SkillPerformanceAssistant:activeMainScene()
	SkillPerformanceAssistant:showUIProperties()
	SkillPerformanceAssistant:showSceneObjectRoot()
end

function SkillStandardPerformance:_internalStop()
	self:_stopRunningPlayer()
	self._handler:clear()
	self._skillVSInfo:clear()
	self._context:clear()
	self._resLoader:clear()
	self._timelineTask:stop()
	self._timelineDelayTask:stop()
end

function SkillStandardPerformance:syncVSInfo(isInit, attackInfo)
	local skillVSInfo = self._skillVSInfo
	local isReversePosition = skillVSInfo:isReversePosition()

	BattleDispatcher:dispatchEvent(BattleEventType.ON_UPDATE_VS_VIEW_INFO, isInit and true or false, isReversePosition and skillVSInfo:getVictim() or skillVSInfo:getAttacker(), isReversePosition and skillVSInfo:getAttacker() or skillVSInfo:getVictim(), attackInfo)
end

function SkillStandardPerformance:_onTimelinePlayerResourceLoaded(timelinePlayer)
	self._timelineDelayTask:clear()
	self._timelineDelayTask:addTask(0, self._tChangePlayer, self)
	self._timelineDelayTask:start(timelinePlayer)
end

function SkillStandardPerformance:_tChangePlayer(timelinePlayer)
	self:_stopRunningPlayer()

	self._runningPlayer = timelinePlayer

	if not self._isEnteredPerformance then
		self:_enterPerformanceScene()
	else
		self:_setupRunningPlayer()
		self:_startRunningPlayer()
	end
end

function SkillStandardPerformance:_setupRunningPlayer()
	self._runningPlayer:setupTimelineInstance()
end

function SkillStandardPerformance:_startRunningPlayer()
	self._runningPlayer:doSkill()
end

function SkillStandardPerformance:_judgeReversePosition(attackInfo)
	local skillVSInfo = self._skillVSInfo

	if attackInfo:getAttacker() == skillVSInfo:getAttacker() then
		attackInfo:setReversePosition(skillVSInfo:isReversePosition())
	else
		attackInfo:setReversePosition(not skillVSInfo:isReversePosition())
	end
end

function SkillStandardPerformance:_preloadResource()
	SkillPerformanceAssistant:collectSkillVSInfoPreloadList(self._resLoader, self._skillVSInfo)
	self._resLoader:load(self._onAllLoaded, false, self)
end

function SkillStandardPerformance:_onAllLoaded()
	self._handler:callAndClear()
end

function SkillStandardPerformance:_enterPerformanceScene()
	local halfStrengthenDuration = 0
	local totalStrengthenDuration = 0

	if self._skillVSInfo:isStrengthening() then
		halfStrengthenDuration = kStrengthenHalf
	end

	self._isEnteredPerformance = true

	self._timelineTask:stop()
	self._timelineTask:addFinishListener(self._onEnterPerformanceFinish, self)
	self._timelineTask:addTask(0, self._tBlurInPerformance, self)
	self._timelineTask:addTask(halfStrengthenDuration)
	self._timelineTask:addTask(0, self._tPrepareEnvironment_Scene, self)
	self._timelineTask:addTask(0, self._tPrepareEnvironment_Unit, self)
	self._timelineTask:addTask(0, self._tPrepareEnvironment_Setup, self)
	self._timelineTask:addTask(0, self._tStartRunningPlayer, self)
	self._timelineTask:addTask(totalStrengthenDuration - halfStrengthenDuration, self._turnOffStrengthen, self)
	self._timelineTask:addTask(kEnterBlurOut, self._tAfterBlurOutPerformance, self)
	self._timelineTask:start()
end

function SkillStandardPerformance:_turnOffStrengthen()
	if self._skillVSInfo:isStrengthening() then
		SkilStrengthenCutInMgr.instance:turnOffCutIn()
	end
end

function SkillStandardPerformance:_tBlurInPerformance()
	GlobalDispatcher:dispatchEvent(EventType.ON_ENTER_OR_EXIT_BATTLE_VS, true)
	BattleAudioUtil.stopVoice()
	SkillPerformanceAssistant:hideUIProperties()

	if self._skillVSInfo:isStrengthening() then
		local attacker = self._skillVSInfo:getAttacker()

		attacker.property:inactiveState(BattleEnum.State.SANITY_STRENGTHEN)
		attacker.effectPlayer:stopLoopEffectWithAnim(BattleConst.SANITY_BURN_LOOP_EFFECT, "End", 0.5)
		SkilStrengthenCutInMgr.instance:turnOnCutIn()
	else
		SkillPerformanceVolumeMgr.instance:turnOnBlur()
		SkillPerformanceVolumeMgr.instance:doEnterBlurIn(0)
	end
end

function SkillStandardPerformance:_tPrepareEnvironment_Scene()
	SkilStrengthenCutInMgr.instance:expandCutIn(true)
	SkillPerformanceAssistant:hideSceneObjectRoot()
	ViewMgr.instance:open(ViewName.BattleVs)
end

function SkillStandardPerformance:_tPrepareEnvironment_Unit()
	local attackInfo = self._runningPlayer:getAttackInfo()

	SkillPerformanceAssistant:recordUnitOfContext(self._context)
	SkillPerformanceAssistant:switchHighModel(attackInfo)
	SkillPerformanceAssistant:prepareUnitOfContext(self._context)
	SkillPerformanceAssistant:setupUnitXinMao(attackInfo)
end

function SkillStandardPerformance:_tPrepareEnvironment_Setup()
	if not self._skillVSInfo:isStrengthening() then
		SkillPerformanceVolumeMgr.instance:doEnterBlurOut(kEnterBlurOut)
	end

	SkillPerformanceAssistant:resetVSUnitsPosition(self._context)
	SkillPerformanceAssistant:normalizeVirtualCamera()
	SkillPerformanceAssistant:activeAdditionScene()
	self:syncVSInfo(true)
	self:_setupRunningPlayer()
end

function SkillStandardPerformance:_tStartRunningPlayer()
	self:_startRunningPlayer()
end

function SkillStandardPerformance:_tAfterBlurOutPerformance()
	if self._skillVSInfo:isStrengthening() then
		SkilStrengthenCutInMgr.instance:turnOffCutIn()
	else
		SkillPerformanceVolumeMgr.instance:turnOffBlur()
	end
end

function SkillStandardPerformance:_stopRunningPlayer()
	if self._runningPlayer then
		self._runningPlayer:doStop()
		self._runningPlayer:returnSelf()

		self._runningPlayer = false
	end
end

function SkillStandardPerformance:_exitPerformanceScene()
	self._timelineTask:stop()
	self._timelineTask:addTask(0, self._tResetFromSkill, self)
	self._timelineTask:addTask(0, self._tExitBlurOut, self)
	self._timelineTask:addTask(kExitBlurDuration, self._tExitTurnOffBlur, self)
	self._timelineTask:addFinishListener(self._onExitPerformanceSceneFinish, self)
	self._timelineTask:start()
end

function SkillStandardPerformance:_tExitBlurOut()
	SkillPerformanceVolumeMgr.instance:doExitBlurOut(kExitBlurDuration)
end

function SkillStandardPerformance:_tExitTurnOffBlur()
	SkillPerformanceVolumeMgr.instance:turnOffBlur()
end

function SkillStandardPerformance:_tResetFromSkill()
	SkillPerformanceAssistant:inactiveAttackTemporaryCamera(self._context, 0)
	self:_stopRunningPlayer()
	SkillPerformanceVolumeMgr.instance:turnOnBlur()
	SkillPerformanceVolumeMgr.instance:doExitBlurIn(0)
	GlobalDispatcher:dispatchEvent(EventType.ON_ENTER_OR_EXIT_BATTLE_VS, false)
	SkillPerformanceAssistant:activeMainScene()
	SkillPerformanceAssistant:showSceneObjectRoot()
	SkillPerformanceAssistant:showUIProperties()
	SkillPerformanceAssistant:resetFromFocusPosition(self._skillVSInfo)
	self._context:resumeAllUnit()
	ViewMgr.instance:close(ViewName.BattleVs)
end

function SkillStandardPerformance:_onExitPerformanceSceneFinish()
	self._handler:callAndClear()
	self:_internalStop()
end

return SkillStandardPerformance
