-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/tag/impl/SkillTagPerformanceCmd.lua

module("logic.battle.skill.tag.impl.SkillTagPerformanceCmd", package.seeall)

local SkillTagPerformanceCmd = class("SkillTagPerformanceCmd", BattleCommandBase)
local kSceneRoot = SceneMgr.instance:getSceneRoot()

function SkillTagPerformanceCmd:parseServerCommand(cmdParser, tagNO)
	return
end

function SkillTagPerformanceCmd:onInit()
	self._attackerId = false
	self._goSourceTimeline = false
	self._goTimelineList = {}
	self._effectCommand = false
	self._centerUnionIndex = false
	self._centerUnionIndexList = {}
	self._effectScale = false
	self._rotationY = 0
	self._effectResPath = false
	self._effectFinished = false
	self._commandsFinished = false
	self._tagId = false
	self._range = false
	self._continuousIndex = false
	self._timelineTask = TimelineTask.New()
end

function SkillTagPerformanceCmd:onClear(interrupt)
	for i, goTimeline in ipairs(self._goTimelineList) do
		goutil.destroy(goTimeline)
	end

	BattleTableUtil.clearTable(self._goTimelineList)

	self._goSourceTimeline = false

	if self._effectCommand then
		self._effectCommand:safeInterrupt()

		self._effectCommand = false
	end

	self._attackerId = false
	self._goSourceTimeline = false
	self._centerUnionIndex = false

	BattleTableUtil.clearTable(self._centerUnionIndexList)

	self._effectScale = false
	self._rotationY = 0
	self._effectResPath = false
	self._effectFinished = false
	self._commandsFinished = false
	self._tagId = false
	self._range = false
	self._continuousIndex = false

	self._timelineTask:clear()
end

function SkillTagPerformanceCmd:setTagIdAndContinuousIndex(tagId, continuousIndex)
	self._tagId = tagId
	self._continuousIndex = continuousIndex
end

function SkillTagPerformanceCmd:setRange(range)
	self._range = range
end

function SkillTagPerformanceCmd:setAttackerId(attackerId)
	self._attackerId = attackerId
end

function SkillTagPerformanceCmd:getAttackerId()
	return self._attackerId
end

function SkillTagPerformanceCmd:setEffectRes(go)
	self._goSourceTimeline = go
end

function SkillTagPerformanceCmd:setEffectCmd(cmd)
	self._effectCommand = cmd
end

function SkillTagPerformanceCmd:setEffectResPath(path)
	self._effectResPath = path
end

function SkillTagPerformanceCmd:getEffectResPath()
	return self._effectResPath
end

function SkillTagPerformanceCmd:addCenterIndex(idx)
	table.insert(self._centerUnionIndexList, idx)
end

function SkillTagPerformanceCmd:setEffectScale(scale)
	self._effectScale = scale or 1
end

function SkillTagPerformanceCmd:getEffectScale()
	return self._effectScale
end

function SkillTagPerformanceCmd:setRotationY(y)
	self._rotationY = y
end

function SkillTagPerformanceCmd:onCommandFinish(cmd, success)
	self._commandsFinished = true

	self:_tryFinishCmd()
end

function SkillTagPerformanceCmd:execute()
	local attackPointTime, duration = self:_getAttackPointTimeAndDuration()

	self._timelineTask:clear()
	self._timelineTask:addTask(0, self._playCast, self)
	self._timelineTask:addTask(0.5, self._playEffect, self)
	self._timelineTask:addTask(attackPointTime, self._executeCmd, self)
	self._timelineTask:addTask(duration - attackPointTime)
	self._timelineTask:addFinishListener(self._onFinishTimeline, self)
	self._timelineTask:setTimeScale(BattleTime.timeScale)
	self._timelineTask:start()
end

function SkillTagPerformanceCmd:_getAttackPointTimeAndDuration()
	local playableDirector = self._goSourceTimeline:GetComponent(ComponentType.PlayableDirector)

	if playableDirector then
		local attackPointTime = PlayableDirectorUtil.GetAttackPointTimeAndAmplitude(playableDirector, 1, 0, 0)

		return attackPointTime, playableDirector.duration
	end

	return 0, 1
end

function SkillTagPerformanceCmd:_onFinishTimeline()
	self._effectCommand = false
	self._effectFinished = true

	self:_tryFinishCmd()
end

function SkillTagPerformanceCmd:_tryFinishCmd()
	if self._commandsFinished and self._effectFinished then
		self:finish(true)
	end
end

function SkillTagPerformanceCmd:_playCast()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._attackerId)

	if unit and BattleSkillTriggeredCommand:needPlayCastAnimation(unit) then
		unit.meshModel:playAndAutoIdleIfExists(UnitAnimState.Cast)
	end
end

function SkillTagPerformanceCmd:_playEffect()
	for i, unionIndex in ipairs(self._centerUnionIndexList) do
		local x, y, z = self:_getCellXYZ(unionIndex)
		local goTimeline = goutil.clone(self._goSourceTimeline)

		goutil.addChildToParent(goTimeline, kSceneRoot)
		Astral.TransformUtil.SetPos(goTimeline.transform, x, y, z)
		Astral.TransformUtil.SetLocalScale(goTimeline.transform, self._effectScale, 1, self._effectScale)
		Astral.TransformUtil.SetLocalRotation(goTimeline.transform, 0, self._rotationY, 0)
		goutil.setActive(goTimeline, true)
		self:_setEffectPlaySpeed(goTimeline)
		table.insert(self._goTimelineList, goTimeline)
	end

	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._attackerId)
	local unionIndex = self._centerUnionIndex
	local name = self:_getEffectName()

	BattleUnitUtil.play3dAudio(unit, name)
end

function SkillTagPerformanceCmd:_setEffectPlaySpeed(goTimeline)
	local playableDirector = goTimeline:GetComponent(ComponentType.PlayableDirector)

	if playableDirector then
		playableDirector:SetPlaySpeed(BattleTime.timeScale)
	else
		local effectControl = EffectControl.Get(goTimeline)

		effectControl:SetPlaySpeed(BattleTime.timeScale)
	end
end

function SkillTagPerformanceCmd:_getEffectName()
	local strs = string.split(self._goSourceTimeline.name, "(Clone)")

	return strs[1]
end

function SkillTagPerformanceCmd:_getCellXYZ(unionIndex)
	local boardMgr = BattleMgr.instance:getBoardMgr()

	return boardMgr:getCellPositionXYZ(unionIndex)
end

function SkillTagPerformanceCmd:_executeCmd()
	BattleSideHintViewFacade.instance:showTagHint(self._tagId, self._continuousIndex)
	SkillTagUtils.shake(self._attackerId, self._tagId, self._range)

	local command = self._effectCommand
	local cmdExecuter = BattleMgr.instance:getCmdExecuter()

	cmdExecuter:executeCommand(command, self)
end

function SkillTagPerformanceCmd:toString()
	return string.format("[battle tag performance attacker = %s]", self._attackerId)
end

return SkillTagPerformanceCmd
