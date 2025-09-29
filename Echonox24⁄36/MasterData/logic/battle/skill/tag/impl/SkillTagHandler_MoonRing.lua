-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/tag/impl/SkillTagHandler_MoonRing.lua

module("logic.battle.skill.tag.impl.SkillTagHandler_MoonRing", package.seeall)

local M = class("SkillTagHandler_MoonRing", ISkillTagHandler)
local kSceneRoot = SceneMgr.instance:getSceneRoot()

function M:ctor()
	self._shapeType = false
	self._shapeRange = false
	self._scale = false
	self._resLoader = SingleResLoader.New()
	self._handler = Handler.New()
	self._goTimeline = false
	self._currentIndex = 0
	self._timelineTask = TimelineTask.New()
	self._finishedCount = 0
	self._performanceCmdList = {}
end

function M:reset()
	if self._goTimeline then
		goutil.destroy(self._goTimeline)

		self._goTimeline = false
	end

	BattleTableUtil.clearTable(self._performanceCmdList)
	self._resLoader:clear()
	self._handler:clear()
	self._timelineTask:clear()

	self._finishedCount = 0
end

function M:_clear(isInterrupt)
	if isInterrupt then
		for i, cmd in ipairs(self._performanceCmdList) do
			if cmd and not cmd:isDestroyed() then
				cmd:clear(true)
			end
		end
	end
end

function M:destroy()
	self:reset()
end

function M:parseServerEventNO(cmdParser, tagNO)
	local shapeTagNO = tagNO.base.shapeTag

	self._shapeType = SkillTagUtils.getShapeType(shapeTagNO.shape)
	self._shapeRange = SkillTagUtils.getShapeRange(shapeTagNO.shape)

	local resultCollection = false
	local eventNOList = tagNO.events
	local performanceCmd = false
	local attackerId = cmdParser:getParam(BattleCmdParser.Param_SkillTriggerAttackerId)
	local continuousIndex = 0

	for _, eventNO in ipairs(eventNOList) do
		if BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_groupEvent) then
			if resultCollection then
				self:_parseResultCollection(performanceCmd, cmdParser, resultCollection)
			end

			continuousIndex = continuousIndex + 1
			performanceCmd = SkillTagPerformanceCmd:createInstance()

			performanceCmd:setRange(self._shapeRange)
			performanceCmd:setAttackerId(attackerId)
			performanceCmd:setTagIdAndContinuousIndex(self._tagId, continuousIndex)
			table.insert(self._performanceCmdList, performanceCmd)

			resultCollection = BattlePerformanceResultCollection:createInstance()

			resultCollection:parseEventNO(eventNO)
			self:_parseGroupEvent(performanceCmd, eventNO, shapeTagNO.shape)
		else
			if not resultCollection then
				resultCollection = BattlePerformanceResultCollection:createInstance()

				if BattleLog.enableError then
					BattleLog.error("unexpect eventNO")
				end
			end

			resultCollection:parseEventNO(eventNO)
		end
	end

	if resultCollection then
		self:_parseResultCollection(performanceCmd, cmdParser, resultCollection)
	end
end

function M:_parseGroupEvent(performanceCmd, groupDamagedEvent, shapeNO)
	self:_getCenterUnionIndex(performanceCmd, groupDamagedEvent, shapeNO)
end

function M:_getCenterUnionIndex(performanceCmd, eventNO, shapeNO)
	if self._shapeType == BattleEnum.Shape.MultipleShape then
		for i, centerShapeNO in ipairs(shapeNO.multipleShape.centerShapes) do
			local unionIndex = BoardIndexConverter.cellNOToUnionIndex(centerShapeNO.center)

			performanceCmd:addCenterIndex(unionIndex)
		end
	else
		local groupEventNO = eventNO[BattleCmdUtil.cmd_groupEvent]
		local unionIndex = BoardIndexConverter.cellNOToUnionIndex(groupEventNO.center)

		performanceCmd:addCenterIndex(unionIndex)
	end
end

function M:startPerformance(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self._resLoader:load(self:_getEffectUrl(), self._onResLoaded, self)
end

function M:stopPerformance(isInterrupt)
	self:_clear(isInterrupt)
end

function M:onCommandFinish(cmd, success)
	self._finishedCount = self._finishedCount + 1

	self:_tryFinishHandler()
end

function M:_onResLoaded()
	self._currentIndex = 1
	self._goTimeline = self._resLoader:getResInstance()

	goutil.setActive(self._goTimeline, false)

	if #self._performanceCmdList == 0 then
		self:_tryFinishHandler()

		return
	end

	self:_executePerformance()
end

function M:_onTimelineFinished()
	self._currentIndex = self._currentIndex + 1

	if self._currentIndex > #self._performanceCmdList then
		return
	end

	self:_executePerformance()
end

function M:_tryFinishHandler()
	if self._finishedCount >= #self._performanceCmdList then
		self._handler:callAndClear()
	end
end

function M:_executePerformance()
	self._timelineTask:clear()
	self._timelineTask:addTask(0, self._performOneTag, self)
	self._timelineTask:addTask(1)
	self._timelineTask:addFinishListener(self._onTimelineFinished, self)
	self._timelineTask:setTimeScale(BattleTime.timeScale)
	self._timelineTask:start()
end

function M:_performOneTag()
	local currentIndex = self._currentIndex
	local cmd = self._performanceCmdList[currentIndex]
	local cmdExecuter = BattleMgr.instance:getCmdExecuter()

	cmd:setEffectRes(self._goTimeline)
	cmd:setEffectScale(self._scale)
	cmdExecuter:executeCommand(cmd, self)
end

function M:_executeCmd()
	local command = self._effectCommand
	local cmdExecuter = BattleMgr.instance:getCmdExecuter()

	cmdExecuter:executeCommand(command, self)
end

function M:_getEffectUrl()
	local uniqueRes, scale = self:_checkForUniqueModelRes()

	if uniqueRes then
		self._scale = scale

		return uniqueRes
	end

	if self._shapeRange >= 3 then
		self._scale = self._shapeRange / 3

		return GameUrl.get3dEffectSceneCommonUrl("biaoqian_zhendang_3")
	end

	if self._shapeRange >= 2 then
		return GameUrl.get3dEffectSceneCommonUrl("biaoqian_zhendang_2")
	end

	return GameUrl.get3dEffectSceneCommonUrl("biaoqian_zhendang_1")
end

function M:_checkForUniqueModelRes()
	local unitMgr = BattleMgr.instance:getUnitMgr()

	if #self._performanceCmdList == 0 then
		return
	end

	local cmd = self._performanceCmdList[1]
	local attacker = unitMgr:getUnit(cmd:getAttackerId())

	if not attacker then
		return
	end

	local entityCode = attacker.property:getEntityCode()
	local modelCode = attacker.property:getModelCode()

	return SkillTagUtils.getTagResourceUrl(entityCode, modelCode, self._tagId, self._shapeType, self._shapeRange)
end

function M:_parseResultCollection(performanceCmd, cmdParser, resultCollection)
	if not resultCollection then
		return
	end

	resultCollection:tryMergeDamage()

	local sequenceCommand = SkillTagUtils.createSequenceCommand(cmdParser, resultCollection)

	performanceCmd:setEffectCmd(sequenceCommand)
end

return M
