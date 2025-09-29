-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/solo/SkillSoloInMainScene.lua

module("logic.battle.skill.performance.solo.SkillSoloInMainScene", package.seeall)

local SkillSoloInMainScene = class("SkillSoloInMainScene", ISkillPerformance)
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kBattleScene = SceneMgr.instance:getScene(SceneType.Battle)
local kTempVec3 = Vector3.New()

function SkillSoloInMainScene:ctor()
	self._resLoader = SingleResLoader.New()
	self._handler = Handler.New()
	self._directorSetter = PlayableDirectorSetter.New()
	self._attackPointContext = SkillAttackPointContext.New()
	self._fadeUnitList = {}
	self._goTimeline = false
	self._timelineListener = false
	self._context = false
	self._attackInfo = false
	self._attackPointIndex = 0
	self._skillAudioName = false
	self._timelineResPath = false
	self._doFadeInCommand = false
end

function SkillSoloInMainScene:bindContext(context)
	self._context = context
end

function SkillSoloInMainScene:setupAudioName(audioName)
	self._skillAudioName = audioName
end

function SkillSoloInMainScene:setTimelineResPath(timelineResPath)
	self._timelineResPath = timelineResPath
end

function SkillSoloInMainScene:loadResource(url, callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self._resLoader:load(url, self._onResLoaded, self)
end

function SkillSoloInMainScene:isResourceLoaded()
	return self._resLoader:getResource() and true or false
end

function SkillSoloInMainScene:clear()
	if self._goTimeline then
		goutil.destroy(self._goTimeline)

		self._goTimeline = false
	end

	if self._timelineListener then
		self._timelineListener:RemoveListener()

		self._timelineListener = false
	end

	self._directorSetter:Clear()
	self._attackPointContext:clear()
	self._handler:clear()
	self._resLoader:clear()

	self._attackPointIndex = 0
	self._context = false
	self._attackInfo = false
	self._skillAudioName = false
	self._timelineResPath = false
	self._doFadeInCommand = false
end

function SkillSoloInMainScene:start(attackInfo, callback, callbackSelf)
	self._attackInfo = attackInfo

	self._handler:setListener(callback, callbackSelf)
	self:_buildTimelineInstance()
	self:_buildAttackPointContext()
	self:_setTimelineBindings()
	self:_addUnitToCharacterRoot()
	self:_startAttack()
end

function SkillSoloInMainScene:stop()
	if not self._context then
		return
	end

	self:_removeUnitFromCharacterRoot()
	self:_cleanTimelineBindings()
end

function SkillSoloInMainScene:_onResLoaded()
	self._handler:callAndClear()
end

function SkillSoloInMainScene:_buildTimelineInstance()
	local resource = self._resLoader:getResource()
	local asset = resource:GetAsset(nil, nil)
	local goTimeline = goutil.clone(asset)
	local attacker = self._attackInfo:getAttacker()
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local goAvatar = attacker.mountRoot:getAvatarRoot()

	goutil.addChildToParent(goTimeline, kSceneRoot)
	Astral.TransformUtil.SetPos(goTimeline.transform, Astral.TransformUtil.GetPos(goAvatar.transform, 0, 0, 0))

	local targetUnionIndex = self._context:getSkillVSInfo():getTargetUnionIndex()
	local targetPosition = boardMgr:getCellPosition(targetUnionIndex)
	local goRightRoot = GameObjectUtils.FindChildRecursively(goTimeline, 10, SkillTimelineContext.VictimRoot)

	if goRightRoot then
		Astral.TransformUtil.SetPos(goRightRoot.transform, targetPosition:Get())
	end

	self._goTimeline = goTimeline

	self._directorSetter:Build(goTimeline)
	self._directorSetter:SetWrapMode(UnityEngine.Playables.DirectorWrapMode.None)
	self._directorSetter:Stop()

	self._timelineListener = TimelineEventListener.Get(goTimeline)

	self._timelineListener:AddListener(self._onTimelineEvent, self)
end

function SkillSoloInMainScene:_buildAttackPointContext()
	local count, weight = self._directorSetter:GetTotalAttackPointCountAndWeight(0, 0)
	local pointTimeStr = self._directorSetter:GetTotalAttackPointTimeString(0)

	self._totalAttackPoint = self:_judgeTotalAttackPoint(count)

	self._attackPointContext:setTimelineGameObject(self._goTimeline)
	self._attackPointContext:setSoloPerformance(true)
	self._attackPointContext:setAttackInfo(self._attackInfo)
	self._attackPointContext:setParam(SkillAttackPointContext.TotalWeight, weight)
	self._attackPointContext:setPointTimeStr(pointTimeStr)
	self._attackPointContext:setParam(SkillAttackPointContext.DeadType, BattleEnum.PerformanceDeadType.Animation)
	self._attackPointContext:setSkipPerformance(SkillPerformanceMgr.instance:internal_isSkipPerformance())
	SkillAttackPointHandlerUtil.buildAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext)
end

function SkillSoloInMainScene:_judgeTotalAttackPoint(countInTimeline)
	local continuousType = self._attackInfo:getContinuousType()

	if continuousType == BattleEnum.SkillContinuousType.LOOP_TIMELINE then
		return self._attackInfo:getContinuousCount()
	end

	return countInTimeline
end

function SkillSoloInMainScene:_setTimelineBindings()
	SkillPerformanceAssistant:setupTimelineBindings(self._directorSetter, self._goTimeline, self._attackInfo)
	SkillPerformanceAssistant:setupLoopRegionFeature(self._directorSetter, self._goTimeline, self._attackInfo)
	SkillPerformanceAssistant:setupBullet(self._directorSetter, self._goTimeline, self._attackInfo)
end

function SkillSoloInMainScene:_cleanTimelineBindings()
	SkillPerformanceAssistant:cleanupTimelineBindings(self._directorSetter, self._attackInfo)
end

function SkillSoloInMainScene:onCommandFinish()
	self._doFadeInCommand = false
end

function SkillSoloInMainScene:_addUnitToCharacterRoot()
	if self._context:getSkillVSInfo():isHideUnrelated() and not self._context:getSkillVSInfo():hasHideUnrelated() then
		BattleUnitUtil.getFadeUnitList(self._attackInfo, self._fadeUnitList)

		self._doFadeInCommand = BattleUnitDOFadeCommand:createAndExecuteCommand(self._fadeUnitList, true)

		if self._doFadeInCommand then
			self._doFadeInCommand:setCommandHandler(self)
		end
	end

	local attacker = self._attackInfo:getAttacker()
	local victims = self._attackInfo:getVictims()
	local goVictimRoot = GameObjectUtils.FindChildRecursively(self._goTimeline, 10, SkillTimelineContext.VictimRoot)
	local mainVictim

	if goVictimRoot and #victims > 0 then
		mainVictim = victims[1]

		local boardMgr = BattleMgr.instance:getBoardMgr()
		local victimUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(mainVictim.transform:getCoordinates())
		local victimPosition = boardMgr:getCellPosition(victimUnionIndex)

		Astral.TransformUtil.SetPos(goVictimRoot.transform, victimPosition:Get())

		for _, victim in ipairs(victims) do
			GameObjectUtils.MoveChildToParent(victim:getGameObject(), goVictimRoot)
		end
	end

	SkillPerformanceAssistant:setupAOESkillTimelineAttackEffect(self._goTimeline, self._attackInfo)

	local list = BattleTableUtil.getTempList()
	local attackerModelGo = attacker.meshModel:getInst()

	GameObjectUtils.GetComponentsInChildren(self._goTimeline, typeof(SpaceX.BattleEffectRotateFollowUnit), list)

	for i, comp in ipairs(list) do
		comp:SetEffectTarget(attackerModelGo)
	end

	BattleTableUtil.releaseTempList(list)

	local list = BattleTableUtil.getTempList()

	GameObjectUtils.GetComponentsInChildren(self._goTimeline, typeof(SpaceX.BattleEffectSetHitPosForVfx), list)

	for i, comp in ipairs(list) do
		local goHitRoot = comp.gameObject

		self._attackInfo:setShowNormalHitEffect(true)

		local effectScale = comp.effectScale
		local pos = comp.posType

		if mainVictim ~= nil and goHitRoot ~= nil then
			if pos == 1 then
				local bodyGo = mainVictim.meshModel:getBodyGo()

				if not goutil.isNil(bodyGo) then
					goHitRoot.transform.position = bodyGo.transform.position
				end
			end

			if mainVictim.transform:isComposite() then
				comp:SetEffectScale(effectScale)
			end
		end
	end

	BattleTableUtil.releaseTempList(list)
end

function SkillSoloInMainScene:_startAttack()
	self._attackPointIndex = 0

	self._directorSetter:Play()
	self._directorSetter:SetPlaySpeed(BattleTime.timeScale)
	self._directorSetter:GenHitAnimationNotification(nil)
	SkillPerformanceAssistant:playSkillAudio(self._attackInfo:getAttacker(), self._skillAudioName)
	SkillPerformanceAssistant:playSkillSpeech(self._attackInfo:getAttacker(), self._timelineResPath)
	SkillPerformanceMgr.instance:syncVSInfo(self._attackInfo)
end

function SkillSoloInMainScene:_removeUnitFromCharacterRoot()
	local unitsRoot = BattleGameObjectRootUtil.unitsRoot
	local victims = self._attackInfo:getVictims()

	for _, victim in ipairs(victims) do
		GameObjectUtils.MoveChildToParent(victim:getGameObject(), unitsRoot)
		self:_resetUnitTransform(victim)
	end

	if self._doFadeInCommand then
		self._doFadeInCommand:stop()

		self._doFadeInCommand = false
	end

	BattleUnitDOFadeCommand:createAndExecuteCommand(self._fadeUnitList, false)
	BattleTableUtil.clearTable(self._fadeUnitList)
end

function SkillSoloInMainScene:_resetUnitTransform(unit)
	local x, z = unit.mover:getPos()

	unit.mover:setPosDirectly(x, z)

	local dx, dy, dz = unit.meshModel:getLookAtDir()

	unit.meshModel:lookAtDir(dx, dy, dz)
end

function SkillSoloInMainScene:_onTimelineStop()
	self:_hideTagHintEffect()
	SkillAttackPointHandlerUtil.clearAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext)
	self._handler:callAndClear()
end

function SkillSoloInMainScene:_onTimelineEvent(eventName, param, amplitude)
	if eventName == BattleTimelineEventName.Stopped then
		self:_onTimelineStop()
	elseif eventName == BattleTimelineEventName.AttackPoint then
		self:_handleAttackPoint(param, amplitude)
	elseif eventName == BattleTimelineEventName.SanityConsume then
		if not self._attackInfo:isStrengthening() then
			BattleDispatcher:dispatchEvent(BattleEventType.PlaySanityConsumeAnim, self._attackInfo)
		end
	elseif eventName == BattleTimelineEventName.EventHitAnimation then
		local victim = self._attackInfo:getFirstVictim()

		if victim then
			self._lastHitVoiceTimeStamp = SkillPerformanceAssistant:handleHitVoice(victim, param, self._lastHitVoiceTimeStamp)
		end
	end
end

function SkillSoloInMainScene:_handleAttackPoint(weight, amplitude)
	if not self:_checkAttackPoint() then
		return
	end

	self._attackPointIndex = self._attackPointIndex + 1

	SkillAttackPointHandlerUtil.executeAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext, weight, amplitude)
	SkillPerformanceMgr.instance:syncVSInfo(self._attackInfo)
	self:_checkTagHintEffect()
	self:_checkDeadPerformance()
end

function SkillSoloInMainScene:_checkTagHintEffect()
	local attackingDirection = self._attackInfo:getAttackingDirection()

	if attackingDirection == BattleEnum.AttackingDirection.ATTACKING_DIRECTION_CHASE then
		local continuousCount = self._attackInfo:getContinuousCount()
		local continuousIndex = self._attackInfo:getContinuousIndex()

		if continuousCount > 0 then
			continuousIndex = continuousIndex - continuousCount + self._attackPointIndex

			local constCO = BattleConfig.instance:getBattleConstCO(BattleConst.Chase)

			BattleSideHintViewFacade.instance:showTagHint(constCO.numValue, continuousIndex)
		elseif self._attackPointIndex <= 1 then
			local constCO = BattleConfig.instance:getBattleConstCO(BattleConst.Chase)

			BattleSideHintViewFacade.instance:showTagHint(constCO.numValue, continuousIndex)
		end
	end
end

function SkillSoloInMainScene:_hideTagHintEffect()
	local continuousIndex = self._attackInfo:getContinuousIndex()
	local totalContinuousCount = self._attackInfo:getTotalContinuousCount()

	if continuousIndex > 0 and totalContinuousCount <= continuousIndex then
		BattleSideHintViewFacade.instance:hideTagHint()
	end
end

function SkillSoloInMainScene:_checkAttackPoint()
	if self._attackPointIndex >= self._totalAttackPoint then
		if BattleLog.enableError then
			BattleLog.error(string.format("SkillSoloInMainScene::attack point[%s] is not equal，skill [%s]", self._totalAttackPoint, self._attackInfo:getSkillId()))
		end

		return false
	end

	return true
end

function SkillSoloInMainScene:_checkDeadPerformance()
	if self._attackPointIndex < self._totalAttackPoint then
		return
	end

	SkillAttackPointHandlerUtil.executeLastAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext)
end

return SkillSoloInMainScene
