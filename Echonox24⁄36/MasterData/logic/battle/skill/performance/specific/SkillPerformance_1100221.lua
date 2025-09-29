-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/specific/SkillPerformance_1100221.lua

module("logic.battle.skill.performance.specific.SkillPerformance_1100221", package.seeall)

local M = class("SkillPerformance_1100221", ISpecificSkillPerformance, ISkillPerformance)
local kSceneRoot = SceneMgr.instance:getSceneRoot()

function M:ctor()
	self._directorSetter = PlayableDirectorSetter.New()
	self._attackPointContext = SkillAttackPointContext.New()
	self._resLoader = MultiResLoader.New()
	self._skillVSInfo = SkillVSInfo.New()
	self._attackInfo = SkillAttackInfo.New()
	self._handler = Handler.New()
	self._fadeUnitList = {}
	self._goTimeline = false
	self._timelineListener = false
	self._attackPointIndex = 0
	self._isFirstPiece = false
	self._part1TimelinePlayerList = {}
	self._summonHandlers = {}
	self._skillAudioName = false
end

function M:setVisible(visible)
	for k, player in pairs(self._part1TimelinePlayerList) do
		if not player:isFinished() then
			player:setVisible(visible)
		end
	end

	if self._goTimeline then
		if visible then
			goutil.setActive(self._goTimeline, true)

			local time = self._directorSetter:GetMultiRoundSkillSeparationMarkerTime()

			self._directorSetter:JumpToTime(time)
		else
			goutil.setActive(self._goTimeline, false)
		end
	end
end

function M:doPreprocessSkill(skillVSInfo, callback, callbackSelf)
	local attacker = skillVSInfo:getAttacker()

	self._attackerEntityId = attacker.property:getEntityId()

	local victim = skillVSInfo:getVictim()
	local skillId = skillVSInfo:getSkillId()
	local animState = SkillPerformanceConfig.instance:getMainSkillAnimState(skillId, attacker.skill:getSkillStatus())
	local timelineResPath = SkillPerformanceConfig.instance:getSkillPerformanceTimeline(animState, attacker.property:getModelCode())

	self._skillAudioName = SkillPerformanceAssistant:getSkillAudioName(timelineResPath)
	self._part2Url = EffectUtil.getQualifiedUrl(string.format("effect3d/prefab/skill/%s/%s_end_p.prefab", timelineResPath, timelineResPath))

	self._resLoader:addResPath(self._part2Url)

	self._holdResPathList = {}

	local MultiRoundHoldDic = skillVSInfo:getMultiRoundHold()

	for entityId, effectTimeline in pairs(MultiRoundHoldDic) do
		local holdUrl = EffectUtil.getQualifiedUrl(string.format("effect3d/prefab/skill/%s/%s.prefab", timelineResPath, effectTimeline))

		self._holdResPathList[entityId] = holdUrl

		self._resLoader:addResPath(holdUrl)
	end

	self._isFirstPiece = true

	self._skillVSInfo:copyFrom(skillVSInfo)
	self._handler:setListener(callback, callbackSelf)
	self:_setEvent(true)
	self._resLoader:load(self._onResLoaded, nil, self)
end

function M:beginPerformance(skillVSInfo, callback, callbackSelf)
	self._skillVSInfo:copyFrom(skillVSInfo)
	self._handler:executeCallback(callback, callbackSelf)
end

function M:_playPart1EndTimeline()
	for k, player in pairs(self._part1TimelinePlayerList) do
		player:playPart2Timeline()
	end
end

function M:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnEntityDead, self._onEntityDead, self)
		BattleDispatcher:addEventListener(BattleEventType.OnStartPlayWeakPointBroken, self._onWeakPointBroken, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnEntityDead, self._onEntityDead, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnStartPlayWeakPointBroken, self._onWeakPointBroken, self)
	end
end

function M:_onWeakPointBroken(_, brokenEntityId)
	self:_setEvent(false)

	if brokenEntityId == self._attackerEntityId then
		for entityId, v in pairs(self._part1TimelinePlayerList) do
			if entityId ~= self._attackerEntityId then
				v:playPart2Timeline(self._onShadowPart2Finish, self, entityId)
			else
				v:playPart2Timeline(self._onPart1Broken, self)
			end
		end
	end
end

function M:_onShadowPart2Finish(entityId)
	local timelinePlayer = self._part1TimelinePlayerList[entityId]

	if timelinePlayer then
		timelinePlayer:setVisible(false)
	end
end

function M:_onEntityDead(_, entityId)
	if self._part1TimelinePlayerList[entityId] then
		self._part1TimelinePlayerList[entityId]:playPart2Timeline(self._onShadowPart2Finish, self, entityId)

		self._entityRetain = self._entityRetain - 1

		if self._entityRetain <= 0 then
			local attacker = self._skillVSInfo:getAttacker()
			local attackerId = attacker.property:getEntityId()

			if self._part1TimelinePlayerList[attackerId] then
				self._part1TimelinePlayerList[attackerId]:playPart2Timeline(self._onPart1Broken, self)
			end
		end
	end
end

function M:_onPart1Broken()
	self:_onPart1Finish()
	self:interrupt()
end

function M:doAttack(attackInfo, callback, callbackSelf)
	self:_setEvent(false)
	self:_buildPart2TimelineInstance()

	self._isFirstPiece = false

	self._attackInfo:copyFrom(attackInfo)
	self:_removeEntitiesAddHandlers()
	self._handler:setListener(callback, callbackSelf)
	self:_buildAttackPointContext()
	self:_setTimelineBindings()
	self:_addUnitToCharacterRoot()
	self:_playPart1EndTimeline()
	self:_startAttack()
	self:_onPart1Finish()
end

function M:_removeEntitiesAddHandlers()
	local attackerHandlers = self._attackInfo:getAttackPointHandlers()

	for i = #attackerHandlers, 1, -1 do
		if OOPUtil.isInstanceOf(attackerHandlers[i], EntitiesAddedAttackPointHandler) then
			table.insert(self._summonHandlers, attackerHandlers[i])
			table.remove(attackerHandlers, i)
		end
	end
end

function M:endPerformance(callback, callbackSelf)
	self:_clear()
	Handler:executeCallback(callback, callbackSelf)
end

function M:interrupt()
	self:_clear()
end

function M:_clear()
	self:_setEvent(false)
	self:_removeUnitFromCharacterRoot()

	if self._groupEntityAddCommand then
		self._groupEntityAddCommand:stop()
	end

	for k, player in pairs(self._part1TimelinePlayerList) do
		player:returnSelf()
	end

	BattleTableUtil.clearTable(self._part1TimelinePlayerList)
	BattleTableUtil.clearTable(self._summonHandlers)

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
	self._skillAudioName = false
end

function M:_onResLoaded()
	self:_buildPart1TimelineInstance()
end

function M:_buildPart1TimelineInstance()
	self._part1FinishCount = 0
	self._part1TotalCount = 0

	local unitMgr = BattleMgr.instance:getUnitMgr()

	for entityId, url in pairs(self._holdResPathList) do
		local unit = unitMgr:getUnit(entityId)

		if unit then
			local resource = self._resLoader:getResource(url)
			local asset = resource:GetAsset(nil, nil)
			local goTimeline = goutil.clone(asset)

			goutil.setActive(goTimeline, false)

			self._part1TimelinePlayerList[entityId] = SimpleTimelinePlayer:createInstance()

			self._part1TimelinePlayerList[entityId]:buildTimelineInstance(goTimeline, self._onPart1TimelineFinish, self, unit)
			goutil.addChildToParent(goTimeline, kSceneRoot)

			self._part1TotalCount = self._part1TotalCount + 1

			if self._attackerEntityId == entityId then
				unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle, UnitAnimState.UniqueSpecial)
				unit.meshModelMover:mapBaseAnimation(UnitAnimState.React, UnitAnimState.UniqueSpecial)
			end
		end
	end

	self._entityRetain = self._part1TotalCount - 1
end

function M:_onPart1Finish()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._attackerEntityId)

	if unit then
		unit.meshModelMover:resetBaseMappedAnimation(UnitAnimState.Idle)
		unit.meshModelMover:resetBaseMappedAnimation(UnitAnimState.React)
		unit.meshModel:play(UnitAnimState.Idle, true, true)
	end
end

function M:_onPart1TimelineFinish()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._attackerEntityId)

	if unit then
		unit.meshModel:play(UnitAnimState.UniqueSpecial, true, true)
	end

	self._part1FinishCount = self._part1FinishCount + 1

	if self._part1TotalCount <= self._part1FinishCount then
		self._handler:callAndClear()
	end
end

function M:_buildPart2TimelineInstance()
	local resource = self._resLoader:getResource(self._part2Url)
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

function M:_buildAttackPointContext()
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

function M:_setTimelineBindings()
	SkillPerformanceAssistant:setupTimelineBindings(self._directorSetter, self._goTimeline, self._attackInfo)
end

function M:_cleanTimelineBindings()
	SkillPerformanceAssistant:cleanupTimelineBindings(self._directorSetter, self._attackInfo)
end

function M:_addUnitToCharacterRoot()
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

function M:_startAttack()
	self._attackPointIndex = 0

	self._directorSetter:Play()
	self._directorSetter:SetPlaySpeed(BattleTime.timeScale)
	self._directorSetter:GenHitAnimationNotification(nil)
	SkillPerformanceAssistant:playSkillAudio(self._attackInfo:getAttacker(), self._skillAudioName)
	SkillPerformanceAssistant:playSkillSpeech(self._attackInfo:getAttacker(), self._timelineResPath)
	SkillPerformanceMgr.instance:syncVSInfo(self._attackInfo)
end

function M:_removeUnitFromCharacterRoot()
	local unitsRoot = BattleGameObjectRootUtil.unitsRoot
	local victims = self._attackInfo:getVictims()

	for _, victim in ipairs(victims) do
		GameObjectUtils.MoveChildToParent(victim:getGameObject(), unitsRoot)
		self:_resetUnitTransform(victim)
	end

	BattleUnitDOFadeCommand:createAndExecuteCommand(self._fadeUnitList, false)
	BattleTableUtil.clearTable(self._fadeUnitList)
end

function M:_resetUnitTransform(unit)
	local x, z = unit.mover:getPos()

	unit.mover:setPosDirectly(x, z)

	local dx, dy, dz = unit.meshModel:getLookAtDir()

	unit.meshModel:lookAtDir(dx, dy, dz)
end

function M:_onTimelineStop()
	SkillAttackPointHandlerUtil.clearAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext)

	if #self._summonHandlers > 0 then
		local attacker = self._attackInfo:getAttacker()

		self._groupEntityAddCommand = BattleGroupEntityAddCommand:create(attacker.property:getEntityId(), self._summonHandlers)

		self._groupEntityAddCommand:setCommandHandler(self)
		self._groupEntityAddCommand:execute(BattleMgr.instance:getActiveBattleFlow())
	else
		self:_onAllFinished()
	end
end

function M:onCommandFinish()
	self._groupEntityAddCommand = false

	self:_onAllFinished()
end

function M:_onAllFinished()
	self._handler:callAndClear()
end

function M:_onTimelineEvent(eventName, param)
	if eventName == BattleTimelineEventName.Stopped then
		self:_onTimelineStop()
	elseif eventName == BattleTimelineEventName.AttackPoint then
		self:_handleAttackPoint(param)
	elseif eventName == BattleTimelineEventName.EventHitAnimation then
		local victim = self._attackInfo:getFirstVictim()

		self._lastHitVoiceTimeStamp = SkillPerformanceAssistant:handleHitVoice(victim, param, self._lastHitVoiceTimeStamp)
	end
end

function M:_handleAttackPoint(weight)
	if not self:_checkAttackPoint() then
		return
	end

	self._attackPointIndex = self._attackPointIndex + 1

	SkillAttackPointHandlerUtil.executeAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext, weight)
	SkillPerformanceMgr.instance:syncVSInfo(self._attackInfo)
	self:_checkDeadPerformance()
end

function M:_checkAttackPoint()
	if self._attackPointIndex >= self._totalAttackPoint then
		if BattleLog.enableError then
			BattleLog.error(string.format("M::attack point[%s] is not equal，skill [%s]", self._totalAttackPoint, self._attackInfo:getSkillId()))
		end

		return false
	end

	return true
end

function M:_checkDeadPerformance()
	if self._attackPointIndex < self._totalAttackPoint then
		return
	end

	SkillAttackPointHandlerUtil.executeLastAttackPointHandlers(self._attackInfo:getAttackPointHandlers(), self._attackPointContext)
end

return M
