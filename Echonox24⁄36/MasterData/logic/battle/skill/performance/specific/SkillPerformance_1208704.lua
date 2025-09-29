-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/specific/SkillPerformance_1208704.lua

module("logic.battle.skill.performance.specific.SkillPerformance_1208704", package.seeall)

local SkillPerformance_1208704 = class("SkillPerformance_1208704", ISpecificSkillPerformance, ISkillPerformance)
local kSceneRoot = SceneMgr.instance:getSceneRoot()

function SkillPerformance_1208704:ctor()
	self._directorSetter = PlayableDirectorSetter.New()
	self._attackPointContext = SkillAttackPointContext.New()
	self._resLoader = SingleResLoader.New()
	self._skillVSInfo = SkillVSInfo.New()
	self._attackInfo = SkillAttackInfo.New()
	self._handler = Handler.New()
	self._fadeUnitList = {}
	self._goTimeline = false
	self._timelineListener = false
	self._attackPointIndex = 0
	self._isFirstPiece = false
	self._skillAudioName = false
end

function SkillPerformance_1208704:setVisible(visible)
	if not self._goTimeline then
		return
	end

	if visible then
		goutil.setActive(self._goTimeline, true)

		local time = self._directorSetter:GetMultiRoundSkillSeparationMarkerTime()

		self._directorSetter:JumpToTime(time)
	else
		goutil.setActive(self._goTimeline, false)
	end
end

function SkillPerformance_1208704:doPreprocessSkill(skillVSInfo, callback, callbackSelf)
	local attacker = skillVSInfo:getAttacker()
	local victim = skillVSInfo:getVictim()
	local skillId = skillVSInfo:getSkillId()
	local animState = SkillPerformanceConfig.instance:getMainSkillAnimState(skillId, attacker.skill:getSkillStatus())
	local timelineResPath = SkillPerformanceConfig.instance:getSkillPerformanceTimeline(animState, attacker.property:getModelCode())
	local url = BattleSkillAssist.get3dEffectSkillUrl(timelineResPath, attacker, victim, skillId, attacker.skill:getSkillStatus())

	self._isFirstPiece = true
	self._skillAudioName = SkillPerformanceAssistant:getSkillAudioName(timelineResPath)

	self._skillVSInfo:copyFrom(skillVSInfo)
	self._handler:setListener(callback, callbackSelf)
	self._resLoader:load(url, self._onResLoaded, self)
end

function SkillPerformance_1208704:beginPerformance(skillVSInfo, callback, callbackSelf)
	self._skillVSInfo:copyFrom(skillVSInfo)
	Handler:executeCallback(callback, callbackSelf)
end

function SkillPerformance_1208704:doAttack(attackInfo, callback, callbackSelf)
	self._isFirstPiece = false

	self._attackInfo:copyFrom(attackInfo)
	self._handler:setListener(callback, callbackSelf)
	self:_buildAttackPointContext()
	self:_setTimelineBindings()
	self:_addUnitToCharacterRoot()
	self:_startAttack()
end

function SkillPerformance_1208704:endPerformance(callback, callbackSelf)
	self:_clear()
	Handler:executeCallback(callback, callbackSelf)
end

function SkillPerformance_1208704:interrupt()
	self:_clear()
end

function SkillPerformance_1208704:_clear()
	self:_removeUnitFromCharacterRoot()

	if self._goTimeline then
		self:_cleanTimelineBindings()
		goutil.destroy(self._goTimeline)

		self._goTimeline = false
	end

	if self._timelineListener then
		self._timelineListener:RemoveListener()

		self._timelineListener = false
	end

	self._skillVSInfo:clear()
	self._attackInfo:clear()
	self._directorSetter:Clear()
	self._attackPointContext:clear()
	self._handler:clear()
	self._resLoader:clear()

	self._attackPointIndex = 0
end

function SkillPerformance_1208704:_onResLoaded()
	self:_buildTimelineInstance()
	self._directorSetter:Play()
end

function SkillPerformance_1208704:_buildTimelineInstance()
	local resource = self._resLoader:getResource()
	local asset = resource:GetAsset(nil, nil)
	local goTimeline = goutil.clone(asset)
	local attacker = self._skillVSInfo:getAttacker()
	local goAvatar = attacker.mountRoot:getAvatarRoot()

	goutil.addChildToParent(goTimeline, kSceneRoot)
	Astral.TransformUtil.SetPos(goTimeline.transform, Astral.TransformUtil.GetPos(goAvatar.transform, 0, 0, 0))

	self._goTimeline = goTimeline

	self._directorSetter:Build(goTimeline)
	self._directorSetter:SetWrapMode(UnityEngine.Playables.DirectorWrapMode.None)
	self._directorSetter:Stop()

	self._timelineListener = TimelineEventListener.Get(goTimeline)

	self._timelineListener:AddListener(self._onTimelineEvent, self)
end

function SkillPerformance_1208704:_buildAttackPointContext()
	local count, weight = self._directorSetter:GetTotalAttackPointCountAndWeight(0, 0)
	local pointTimeStr = self._directorSetter:GetTotalAttackPointTimeString(0)

	self._totalAttackPoint = count

	self._attackPointContext:setTimelineGameObject(self._goTimeline)
	self._attackPointContext:setSoloPerformance(true)
	self._attackPointContext:setAttackInfo(self._attackInfo)
	self._attackPointContext:setParam(SkillAttackPointContext.TotalWeight, weight)
	self._attackPointContext:setPointTimeStr(pointTimeStr)
	self._attackPointContext:setParam(SkillAttackPointContext.DeadType, BattleEnum.PerformanceDeadType.Animation)
	SkillAttackPointHandlerUtil.buildAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext)
end

function SkillPerformance_1208704:_setTimelineBindings()
	SkillPerformanceAssistant:setupTimelineBindings(self._directorSetter, self._goTimeline, self._attackInfo)
end

function SkillPerformance_1208704:_cleanTimelineBindings()
	SkillPerformanceAssistant:cleanupTimelineBindings(self._directorSetter, self._attackInfo)
end

function SkillPerformance_1208704:_addUnitToCharacterRoot()
	if self._skillVSInfo:isHideUnrelated() and not self._skillVSInfo:hasHideUnrelated() then
		BattleUnitUtil.getFadeUnitList(self._attackInfo, self._fadeUnitList)
		BattleUnitDOFadeCommand:createAndExecuteCommand(self._fadeUnitList, true)
	end

	local attacker = self._attackInfo:getAttacker()
	local victims = self._attackInfo:getVictims()
	local goVictimRoot = GameObjectUtils.FindChildRecursively(self._goTimeline, 10, SkillTimelineContext.VictimRoot)

	if goVictimRoot and #victims > 0 then
		local mainVictim = victims[1]
		local boardMgr = BattleMgr.instance:getBoardMgr()
		local victimUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(mainVictim.transform:getCoordinates())
		local victimPosition = boardMgr:getCellPosition(victimUnionIndex)

		Astral.TransformUtil.SetPos(goVictimRoot.transform, victimPosition:Get())

		for _, victim in ipairs(victims) do
			GameObjectUtils.MoveChildToParent(victim:getGameObject(), goVictimRoot)
		end
	end

	SkillPerformanceAssistant:setupAOESkillTimelineAttackEffect(self._goTimeline, self._attackInfo)
end

function SkillPerformance_1208704:_startAttack()
	self._attackPointIndex = 0

	self._directorSetter:Play()
	self._directorSetter:SetPlaySpeed(BattleTime.timeScale)
	self._directorSetter:GenHitAnimationNotification(nil)
	SkillPerformanceAssistant:playSkillAudio(self._attackInfo:getAttacker(), self._skillAudioName)
	SkillPerformanceAssistant:playSkillSpeech(self._attackInfo:getAttacker(), self._timelineResPath)
	SkillPerformanceMgr.instance:syncVSInfo(self._attackInfo)
end

function SkillPerformance_1208704:_removeUnitFromCharacterRoot()
	local unitsRoot = BattleGameObjectRootUtil.unitsRoot
	local victims = self._attackInfo:getVictims()

	for _, victim in ipairs(victims) do
		GameObjectUtils.MoveChildToParent(victim:getGameObject(), unitsRoot)
		self:_resetUnitTransform(victim)
	end

	BattleUnitDOFadeCommand:createAndExecuteCommand(self._fadeUnitList, false)
	BattleTableUtil.clearTable(self._fadeUnitList)
end

function SkillPerformance_1208704:_resetUnitTransform(unit)
	local x, z = unit.mover:getPos()

	unit.mover:setPosDirectly(x, z)

	local dx, dy, dz = unit.meshModel:getLookAtDir()

	unit.meshModel:lookAtDir(dx, dy, dz)
end

function SkillPerformance_1208704:_onTimelineStop()
	SkillAttackPointHandlerUtil.clearAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext)
	self._handler:callAndClear()
end

function SkillPerformance_1208704:_onTimelineEvent(eventName, param)
	if eventName == BattleTimelineEventName.EventMultiRoundSkillSeparation then
		if self._isFirstPiece then
			self:_onFinishFirstPiece()
		end
	elseif eventName == BattleTimelineEventName.Stopped then
		self:_onTimelineStop()
	elseif eventName == BattleTimelineEventName.AttackPoint then
		self:_handleAttackPoint(param)
	elseif eventName == BattleTimelineEventName.EventHitAnimation then
		local victim = self._attackInfo:getFirstVictim()

		self._lastHitVoiceTimeStamp = SkillPerformanceAssistant:handleHitVoice(victim, param, self._lastHitVoiceTimeStamp)
	end
end

function SkillPerformance_1208704:_onFinishFirstPiece()
	self._directorSetter:Pause()
	self._handler:callAndClear()
end

function SkillPerformance_1208704:_handleAttackPoint(weight)
	if not self:_checkAttackPoint() then
		return
	end

	self._attackPointIndex = self._attackPointIndex + 1

	SkillAttackPointHandlerUtil.executeAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext, weight)
	SkillPerformanceMgr.instance:syncVSInfo(self._attackInfo)
	self:_checkDeadPerformance()
end

function SkillPerformance_1208704:_checkAttackPoint()
	if self._attackPointIndex >= self._totalAttackPoint then
		if BattleLog.enableError then
			BattleLog.error(string.format("SkillPerformance_1208704::attack point[%s] is not equal，skill [%s]", self._totalAttackPoint, self._attackInfo:getSkillId()))
		end

		return false
	end

	return true
end

function SkillPerformance_1208704:_checkDeadPerformance()
	if self._attackPointIndex < self._totalAttackPoint then
		return
	end

	SkillAttackPointHandlerUtil.executeLastAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext)
end

return SkillPerformance_1208704
