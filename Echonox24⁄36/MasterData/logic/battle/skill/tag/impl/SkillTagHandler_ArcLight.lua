-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/tag/impl/SkillTagHandler_ArcLight.lua

module("logic.battle.skill.tag.impl.SkillTagHandler_ArcLight", package.seeall)

local M = class("SkillTagHandler_ArcLight", SkillTagHandler_MoonRing)
local kSceneRoot = SceneMgr.instance:getSceneRoot()

function M:ctor()
	M.super.ctor(self)

	self._chain2FromEntity = {}
	self._isParabolaUp = true
end

function M:reset()
	M.super.reset(self)
	BattleTableUtil.clearTable(self._chain2FromEntity)

	self._isParabolaUp = true
end

function M:parseServerEventNO(cmdParser, tagNO)
	local resultCollection = false
	local eventNOList = tagNO.events
	local performanceCmd = false
	local attackerId = cmdParser:getParam(BattleCmdParser.Param_SkillTriggerAttackerId)
	local continuousIndex = 0

	for _, eventNO in ipairs(eventNOList) do
		if BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_groupEvent) then
			local buildPerformance = false

			for i1, shootEvent in ipairs(eventNO.groupEvent.events) do
				if BattleCmdUtil.hasField(shootEvent, BattleCmdUtil.cmd_shoot) then
					local chain = shootEvent.shoot.chain
					local toEntityId = shootEvent.shoot.eId
					local fromEntityId = self._chain2FromEntity[chain] or attackerId

					if buildPerformance then
						self:_parseGroupShootEvent(performanceCmd, fromEntityId, toEntityId, true)
					else
						if resultCollection then
							self:_parseResultCollection(performanceCmd, cmdParser, resultCollection)
						end

						continuousIndex = continuousIndex + 1
						performanceCmd = SkillTagShootPerformanceCmd:createInstance()

						performanceCmd:setTagIdAndContinuousIndex(self._tagId, continuousIndex)
						performanceCmd:setAttackerId(attackerId)
						performanceCmd:setRange(1)

						buildPerformance = true

						table.insert(self._performanceCmdList, performanceCmd)

						resultCollection = BattlePerformanceResultCollection:createInstance()

						self:_parseGroupShootEvent(performanceCmd, fromEntityId, toEntityId)
					end

					resultCollection:parseEventNOList(shootEvent.shoot.events)

					self._chain2FromEntity[chain] = toEntityId
				end
			end
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

function M:_parseGroupShootEvent(performanceCmd, fromEntityId, toEntityId, ignoreParabolaChange)
	performanceCmd:addFromAndToEntityId(fromEntityId, toEntityId)
	performanceCmd:setParabolaUpStatus(self._isParabolaUp)

	if not ignoreParabolaChange then
		self._isParabolaUp = not self._isParabolaUp
	end
end

function M:_onTimelineFinished()
	self._currentIndex = self._currentIndex + 1

	if self._currentIndex > #self._performanceCmdList then
		return
	end

	self:_executePerformance()
end

function M:onCommandFinish(cmd, success)
	self._finishedCount = self._finishedCount + 1

	self:_tryFinishHandler()
end

function M:tryNextCommand()
	self:_onTimelineFinished()
end

function M:_tryFinishHandler()
	if self._finishedCount >= #self._performanceCmdList then
		self._handler:callAndClear()
	end
end

function M:_executePerformance()
	self:_performOneTag()
end

function M:_performOneTag()
	local currentIndex = self._currentIndex
	local cmd = self._performanceCmdList[currentIndex]
	local cmdExecuter = BattleMgr.instance:getCmdExecuter()
	local scale = 1

	cmd:setEffectRes(self._goTimeline)
	cmd:setEffectScale(scale)
	cmd:setPlayCast(currentIndex == 1)
	cmdExecuter:executeCommand(cmd, self)
end

function M:_getEffectUrl()
	local uniqueRes = self:_checkForUniqueModelRes()

	if uniqueRes then
		return uniqueRes
	end

	return GameUrl.get3dEffectSceneCommonUrl("biaoqian_huguang_1")
end

return M
