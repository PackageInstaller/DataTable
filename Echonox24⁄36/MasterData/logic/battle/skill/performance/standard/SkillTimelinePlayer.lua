-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/standard/SkillTimelinePlayer.lua

module("logic.battle.skill.performance.standard.SkillTimelinePlayer", package.seeall)

local SkillTimelinePlayer = class("SkillTimelinePlayer", AbstractGlobalReusable)
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kBattleScene = SceneMgr.instance:getScene(SceneType.Battle)
local kTempVec3 = Vector3.New()

function SkillTimelinePlayer:ctor()
	self._resLoader = BattleMultiResLoaderIncludeModel.New()
	self._finishHander = Handler.New()
	self._resLoadedHandler = Handler.New()
	self._directorSetter = PlayableDirectorSetter.New()
	self._attackPointContext = SkillAttackPointContext.New()
	self._timeWaiter = TimeWaiter.New()
	self._goTimeline = false
	self._timelineListener = false
	self._context = false
	self._attackInfo = false
	self._attackPointIndex = 0
	self._deadTimeStamp = 0
	self._skillAudioName = false
	self._timelineResPath = false
end

function SkillTimelinePlayer:reuse()
	return
end

function SkillTimelinePlayer:reset()
	if self._goTimeline then
		goutil.destroy(self._goTimeline)

		self._goTimeline = false
	end

	if self._attackInfo then
		self._attackInfo:returnSelf()

		self._attackInfo = false
	end

	if self._timelineListener then
		self._timelineListener:RemoveListener()

		self._timelineListener = false
	end

	self._directorSetter:Clear()
	self._finishHander:clear()
	self._resLoadedHandler:clear()
	self._resLoader:clear()
	self._attackPointContext:clear()
	self._timeWaiter:clear()

	self._attackPointIndex = 0
	self._deadTimeStamp = 0
	self._context = false
	self._skillAudioName = false
	self._timelineResPath = false
end

function SkillTimelinePlayer:destroy()
	self:reset()

	self._directorSetter = false
end

function SkillTimelinePlayer:bindContext(context)
	self._context = context

	return self
end

function SkillTimelinePlayer:bindFinishListener(callback, callbackSelf)
	self._finishHander:setListener(callback, callbackSelf)

	return self
end

function SkillTimelinePlayer:getAttackInfo()
	return self._attackInfo
end

function SkillTimelinePlayer:loadResource(attackInfo, callback, callbackSelf)
	local timelineResPath = SkillPerformanceConfig.instance:getSkillPerformanceTimeline(attackInfo:getAnimState(), attackInfo:getAttacker().property:getModelCode())

	self._attackInfo = SkillAttackInfo:createInstance()

	self._attackInfo:copyFrom(attackInfo)
	self._resLoadedHandler:setListener(callback, callbackSelf)

	local url = BattleSkillAssist.get3dEffectSkillUrl(timelineResPath, attackInfo:getAttacker(), attackInfo:getFirstVictim(), attackInfo:getSkillId(), attackInfo:isStrengthening())

	self._resLoader:addNormalRes(url)
	SkillPerformanceAssistant:collectAttackInfoPreloadList(self._resLoader, attackInfo)

	self._skillAudioName = SkillPerformanceAssistant:getSkillAudioName(timelineResPath)
	self._timelineResPath = timelineResPath

	self._resLoader:load(self._onResLoaded, self)
end

function SkillTimelinePlayer:setupTimelineInstance()
	self:_buildTimelineInstance()
	self:_recordAttackInfo()
	self:_buildAttackPointContext()
	self:_addUnitToCharacterRoot()
	self:_prepareAttackInfo()
	self:_setTimelineOffset()
	self:_setTimelineBindings()
	self._directorSetter:JumpToTime(0)
end

function SkillTimelinePlayer:doSkill()
	self:_startAttack()
	self:_playPriorityCounterDirection()
end

function SkillTimelinePlayer:doStop()
	self:_hideAllUniqueBubble()
	self:_clearTimelineOffset()
	self:_removeUnitFromCharacterRoot()
	self:_cleanTimelineBindings()
	goutil.setActive(self._goTimeline, false)
end

function SkillTimelinePlayer:_playPriorityCounterDirection()
	local hasPriorityCounter = self._attackInfo:hasPriorityCounter()

	if not hasPriorityCounter then
		return
	end

	local attacker = self._attackInfo:getAttacker()

	BattleAttackSignCommand:executeAttackSignCommand(attacker, BattleEnum.AttackingDirection.ATTACKING_DIRECTION_PRIORITY_COUNTER)
end

function SkillTimelinePlayer:_onResLoaded()
	self:_createTimelineInstance()
	self._resLoadedHandler:call(self)
end

function SkillTimelinePlayer:_recordAttackInfo()
	SkillPerformanceAssistant:recordUnitOfAttackInfo(self._context, self._attackInfo)
end

function SkillTimelinePlayer:_prepareAttackInfo()
	SkillPerformanceAssistant:prepareUnitOfAttackInfo(self._context, self._attackInfo)
end

function SkillTimelinePlayer:_setTimelineOffset()
	local victims = self._attackInfo:getVictims()

	for i, victim in ipairs(victims) do
		local modelCO = ModelConfig.instance:getModelConfig(victim.property:getModelCode())
		local dx, dy, dz = ModelCOUtil.getPerformancePositionOffsets(modelCO)

		if dx ~= 0 or dy ~= 0 or dz ~= 0 then
			local goAvatar = victim.mountRoot:getAvatarRoot()
			local x, y, z = Astral.TransformUtil.GetLocalPos(goAvatar.transform, 0, 0, 0)
			local vx, vy, vz = Astral.TransformUtil.GetPos(goAvatar.transform, 0, 0, 0)
			local tx, ty, tz = Astral.TransformUtil.GetLocalPos(self._goTimeline.transform, 0, 0, 0)

			Astral.TransformUtil.SetLocalPos(self._goTimeline.transform, tx + dx, ty + dy, tz + dz)
			Astral.TransformUtil.SetPos(goAvatar.transform, vx, vy, vz)

			break
		end
	end
end

function SkillTimelinePlayer:_clearTimelineOffset()
	local victims = self._attackInfo:getVictims()

	for i, victim in ipairs(victims) do
		local modelCO = ModelConfig.instance:getModelConfig(victim.property:getModelCode())
		local dx, dy, dz = ModelCOUtil.getPerformancePositionOffsets(modelCO)

		if dx ~= 0 or dy ~= 0 or dz ~= 0 then
			local positionOffsets = ModelCOUtil.getPositionOffsets(modelCO)
			local goAvatar = victim.mountRoot:getAvatarRoot()

			if positionOffsets then
				Astral.TransformUtil.SetLocalPos(goAvatar.transform, positionOffsets[1], BattleConst.YOffsetAvatar, positionOffsets[2])

				break
			end

			Astral.TransformUtil.SetLocalPos(goAvatar.transform, 0, BattleConst.YOffsetAvatar, 0)

			break
		end
	end
end

function SkillTimelinePlayer:_createTimelineInstance()
	if self._goTimeline then
		return
	end

	local normalResLoader = self._resLoader:getNormalLoader()
	local url = normalResLoader._resPaths[1]
	local resource = normalResLoader:getResource(url)
	local asset = resource:GetAsset(nil, nil)

	self._goTimeline = goutil.clone(asset)

	goutil.setActive(self._goTimeline, false)
end

function SkillTimelinePlayer:_buildTimelineInstance()
	self:_createTimelineInstance()

	local goTimeline = self._goTimeline
	local isReversePosition = self._attackInfo:isReversePosition()
	local timelinePosition = self._context:judgeAttackerInitPosition(isReversePosition)
	local modelCO = ModelConfig.instance:getModelConfig(self._attackInfo:getAttacker().property:getModelCode())
	local reverseResource = modelCO.skillNotReverse == 0 and isReversePosition

	self._context:setParam(SkillTimelineContext.Param_IsResourceReversed, reverseResource)
	goutil.addChildToParent(goTimeline, kSceneRoot)
	goutil.setActive(goTimeline, true)
	Astral.TransformUtil.SetPos(goTimeline.transform, timelinePosition:Get())
	Astral.TransformUtil.SetLocalRotation(goTimeline.transform, 0, isReversePosition and -90 or 90, 0)

	self._goTimeline = goTimeline

	self._directorSetter:Build(goTimeline)
	self._directorSetter:SetWrapMode(UnityEngine.Playables.DirectorWrapMode.None)
	self._directorSetter:SetReverse(reverseResource)
	self._directorSetter:JumpToTime(0)
	self._directorSetter:Stop()

	self._timelineListener = TimelineEventListener.Get(goTimeline)

	self._timelineListener:AddListener(self._onTimelineEvent, self)
end

function SkillTimelinePlayer:_buildAttackPointContext()
	local count, weight = self._directorSetter:GetTotalAttackPointCountAndWeight(0, 0)
	local pointTimeStr = self._directorSetter:GetTotalAttackPointTimeString(0)
	local hasDeadPoint = self._directorSetter:HasDeadPoint()

	self._totalAttackPoint = count

	self._attackPointContext:setTimelineGameObject(self._goTimeline)
	self._attackPointContext:setAttackInfo(self._attackInfo)
	self._attackPointContext:setParam(SkillAttackPointContext.TotalWeight, weight)
	self._attackPointContext:setParam(SkillAttackPointContext.HasDeadPoint, hasDeadPoint)
	self._attackPointContext:setPointTimeStr(pointTimeStr)
	SkillAttackPointHandlerUtil.buildAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext)
end

function SkillTimelinePlayer:_setTimelineBindings()
	SkillPerformanceAssistant:setupTimelineBindings(self._directorSetter, self._goTimeline, self._attackInfo)
end

function SkillTimelinePlayer:_cleanTimelineBindings()
	Astral.TransformUtil.SetLocalRotation(self._attackInfo:getAttacker():getTransform(), 0, 0, 0)
	SkillPerformanceAssistant:cleanupTimelineBindings(self._directorSetter, self._attackInfo)
end

function SkillTimelinePlayer:_addUnitToCharacterRoot()
	local context = self._context
	local attackInfo = self._attackInfo
	local isResourceReversed = context:getParam(SkillTimelineContext.Param_IsResourceReversed)
	local attacker = attackInfo:getAttacker()

	BattleUnitGenerator.addUnitToRoot(attacker, self._goTimeline)
	attacker.meshModel:lookAtDirVec3(MeshModelDirection.Forward)
	Astral.TransformUtil.SetLocalPos(attacker:getTransform(), 0, 0, 0)

	local goVictimRoot = GameObjectUtils.FindChildRecursively(self._goTimeline, 10, SkillTimelineContext.VictimRoot)

	if goVictimRoot then
		local victims = attackInfo:getVictims()

		for index, victim in ipairs(victims) do
			BattleUnitGenerator.addUnitToRoot(victim, goVictimRoot)
			SkillPerformanceAssistant:switchUnit2HighModel(victim)
			victim.meshModel:lookAtDirVec3(MeshModelDirection.Back)

			if isResourceReversed then
				victim.meshModel:setVictimReverse()
			end

			local victimTransform = victim:getTransform()
			local position = SkillPerformanceAssistant:getVictimPositionDiff(index)

			Astral.TransformUtil.SetLocalPos(victimTransform, position.x, 0, position.z)

			local goAvatar = victim.mountRoot:getAvatarRoot()

			Astral.TransformUtil.SetLocalPos(goAvatar.transform, 0, 0, 0)
		end
	end

	SkillPerformanceAssistant:setupAOESkillTimelineHitEffect(self._goTimeline, self._attackInfo)
end

function SkillTimelinePlayer:_startAttack()
	self._attackPointIndex = 0

	self._directorSetter:Play()
	self._directorSetter:GenHitAnimationNotification(nil)
	SkillPerformanceAssistant:playSkillAudio(self._attackInfo:getAttacker(), self._skillAudioName)
	SkillPerformanceAssistant:playSkillSpeech(self._attackInfo:getAttacker(), self._timelineResPath)
	SkillPerformanceMgr.instance:syncVSInfo(self._attackInfo)
end

function SkillTimelinePlayer:_finishTimeline()
	SkillAttackPointHandlerUtil.clearAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext)
	self._finishHander:callAndClear()
end

function SkillTimelinePlayer:_hideAllUniqueBubble()
	local attackInfo = self._attackInfo
	local attacker = attackInfo:getAttacker()

	attacker.bubble:clearPerformanceBubbleGroup()

	local victims = attackInfo:getVictims()

	for _, victim in ipairs(victims) do
		victim.bubble:clearPerformanceBubbleGroup()
	end
end

function SkillTimelinePlayer:_onTimelineEvent(eventName, param, param2)
	if eventName == BattleTimelineEventName.Stopped then
		self:_stopAtLastFrame()
		self:_handleTimlineFinish()
	elseif eventName == BattleTimelineEventName.AttackPoint then
		self:_handleAttackPoint(param, param2)
	elseif eventName == BattleTimelineEventName.DeadPoint then
		self:_executeLastAttackPointHandlers(param)
	elseif eventName == BattleTimelineEventName.FinishPoint then
		self:_handleFinishPoint()
	elseif eventName == BattleTimelineEventName.SanityConsume then
		if not self._attackInfo:isStrengthening() then
			BattleDispatcher:dispatchEvent(BattleEventType.PlaySanityConsumeAnim, self._attackInfo)
		end
	elseif eventName == BattleTimelineEventName.EventHitAnimation then
		self._lastHitVoiceTimeStamp = SkillPerformanceAssistant:handleHitVoice(self._attackInfo:getFirstVictim(), param, self._lastHitVoiceTimeStamp)
	end
end

function SkillTimelinePlayer:_removeUnitFromCharacterRoot()
	SkillPerformanceAssistant:resetVSUnitsPosition(self._context)

	local attacker = self._context:getSkillVSInfo():getAttacker()
	local mainVictim = self._context:getSkillVSInfo():getVictim()
	local victims = self._attackInfo:getVictims()

	for _, victim in ipairs(victims) do
		victim.meshModel:revertVictimReverse()

		if victim ~= attacker and victim ~= mainVictim then
			BattleUnitGenerator.addUnitToScene(victim)
			SkillPerformanceAssistant:switchUnit2LowModel(victim)
			self._context:resumeUnit(victim)
		end
	end
end

function SkillTimelinePlayer:_handleTimlineFinish()
	local duration = BattleConst.DeadDuration - (Time.realtimeSinceStartup - self._deadTimeStamp)

	if duration > 0 then
		self._timeWaiter:start(duration, self._finishTimeline, self)

		return
	end

	self:_finishTimeline()
end

function SkillTimelinePlayer:_stopAtLastFrame()
	local attacker = self._attackInfo:getAttacker()

	attacker.meshModel:exchangeActivePlayable()
	self._directorSetter:Stop()
	self._directorSetter:JumpToTime(-1)
end

function SkillTimelinePlayer:_handleFinishPoint()
	if self._deadTimeStamp and self._deadTimeStamp > 0 then
		return
	end

	self:_finishTimeline()
end

function SkillTimelinePlayer:_handleAttackPoint(weight, amplitude)
	if not self:_checkAttackPoint() then
		return
	end

	self._attackPointIndex = self._attackPointIndex + 1

	SkillAttackPointHandlerUtil.executeAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext, weight, amplitude)
	SkillPerformanceMgr.instance:syncVSInfo()
	self:_tryExecuteLastAttackPointEffect()
end

function SkillTimelinePlayer:_checkAttackPoint()
	if self._attackPointIndex >= self._totalAttackPoint then
		if BattleLog.enableError then
			BattleLog.error(string.format("SkillTimelinePlayer::attack point[%s] is not equal，skill [%s]", self._totalAttackPoint, self._attackInfo:getSkillId()))
		end

		return false
	end

	return true
end

function SkillTimelinePlayer:_tryExecuteLastAttackPointEffect()
	if self._attackPointIndex < self._totalAttackPoint then
		return
	end

	self:_tryWeakPointBroken()
	self:_tryExecuteLastAttackPointHandlers()
end

function SkillTimelinePlayer:_tryWeakPointBroken()
	local weakPointBrokenEntityId = self:_getWeakPointBrokenEntityId()

	if weakPointBrokenEntityId then
		local unitMgr = BattleMgr.instance:getUnitMgr()
		local unit = unitMgr:getUnit(weakPointBrokenEntityId)

		unit.property:activeState(BattleEnum.State.WEAK_POINT_PERFORMANCED)
		self._context:setParam(SkillTimelineContext.Param_WeakPointBrokenEntityId, weakPointBrokenEntityId)

		local isSteppedAttackerAtLeft = self._attackInfo:isReversePosition()

		BattleDispatcher:dispatchEvent(BattleEventType.ON_SHOW_ATTACK_SIGN, isSteppedAttackerAtLeft, BattleEnum.AttackingDirection.WEAK_POINT_BROKEN)
	end
end

function SkillTimelinePlayer:_getWeakPointBrokenEntityId()
	local victims = self._attackInfo:getVictims()

	for _, victim in ipairs(victims) do
		if victim.property:isShowWeakPoint() and victim.property:getWeakPointHp() <= 0 and not victim.property:isStateActive(BattleEnum.State.WEAK_POINT_PERFORMANCED) and not victim.property:isWeakPointBroken() then
			return victim.property:getEntityId()
		end
	end

	return false
end

function SkillTimelinePlayer:_tryExecuteLastAttackPointHandlers(deadType)
	if self._attackPointIndex < self._totalAttackPoint then
		return
	end

	local hasDeadPoint = self._attackPointContext:getParam(SkillAttackPointContext.HasDeadPoint)

	if hasDeadPoint then
		return
	end

	self:_executeLastAttackPointHandlers(BattleEnum.PerformanceDeadType.Animation)
end

function SkillTimelinePlayer:_executeLastAttackPointHandlers(deadType)
	local isAnyOneDead = #self._attackInfo:getDeadEntityIds() > 0

	self._deadTimeStamp = isAnyOneDead and deadType == BattleEnum.PerformanceDeadType.Animation and Time.realtimeSinceStartup or 0

	self._attackPointContext:setParam(SkillAttackPointContext.DeadType, deadType)
	SkillAttackPointHandlerUtil.executeLastAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext)
end

return SkillTimelinePlayer
