-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/TaskMo.lua

module("logic.extensions.task.model.TaskMo", package.seeall)

local M = class("TaskMo")

function M:ctor()
	self._id = false
	self._count = false
	self._canGetReward = false
	self._isFinish = false
	self._taskCO = false
	self._tabId = false
	self._name = false
	self._text = false
	self._content = false
	self._param = false
	self._rewardId = false
	self._point = false
	self._jump = false
	self._weight = false
	self._priority = false
	self._startTime = false
	self._endTime = false
	self._preTask = false
	self._noShow = false
	self._canGetReward = false
	self._canJump = false
	self._taskDesc = false
	self._isTaskGroup = false
	self._maxCount = false
	self._rewardList = false
	self._isLimitTask = false
	self._icon = false
end

function M:initData(taskId, count, isFinish, taskCO)
	self._id = taskId
	self._count = count
	self._isFinish = isFinish
	self._taskCO = taskCO

	if not self._taskCO then
		return
	end

	self._tabId = self._taskCO.label
	self._name = self._taskCO.name
	self._text = self._taskCO.text
	self._content = self._taskCO.content
	self._param = self._taskCO.param
	self._rewardId = checknumber(self._taskCO.reward)
	self._point = self._taskCO.point
	self._jump = self._taskCO.jump
	self._weight = self._taskCO.weight
	self._priority = self._taskCO.priority
	self._startTime = self._taskCO.startTime
	self._endTime = self._taskCO.endTime
	self._preTask = self._taskCO.preTask
	self._noShow = self._taskCO.noShow
	self._icon = self._taskCO.icon

	self:isExpired()

	self._canJump = not string.nilorempty(self._jump)
	self._rewardList = self:_parseReward()

	self:_parseTask()
end

function M:_parseReward()
	local rewardId = tonumber(self._rewardId)
	local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardId)
	local tempList = {}

	if rewardCO then
		for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
			table.insert(tempList, {
				itemId = v.code,
				num = v.num
			})
		end
	end

	return tempList
end

function M:_parseTask()
	if not string.nilorempty(self._param) and self._content > 0 then
		self._taskDesc, self._maxCount, self._isTaskGroup = TaskUtil.parseContent(self._content, self._param)
	elseif enableErrorLog then
		printError(string.format("策划杨昊大佬说任务配的是个皮皮虾,任务ID:%s,任务内容或者统计参量为空！", self._id))
	end

	if not self._count or not self._maxCount then
		printError("task count cloud not be nil", self._id)
	end

	self._canGetReward = tonumber(self._count) >= tonumber(self._maxCount)

	if not string.nilorempty(self._text) then
		self._taskDesc = self._text
	end
end

function M:getCurCount()
	return self._count
end

function M:getMaxCount()
	return self._maxCount
end

function M:getShowDesc()
	return self._taskDesc
end

function M:updateData(count, isFinish)
	self._count = count
	self._isFinish = isFinish
	self._canGetReward = tonumber(self._count) >= tonumber(self._maxCount)
end

function M:getTaskId()
	return self._id
end

function M:getPreTask()
	return self._preTask
end

function M:getSortIndex()
	return self._priority
end

function M:getName()
	return self._name
end

function M:getJumpId()
	return self._jump
end

function M:getIsFinish()
	return self._isFinish
end

function M:canGetReward()
	return self._canGetReward
end

function M:canShow()
	return not self._noShow
end

function M:canJump()
	return self._canJump
end

function M:isExpired()
	local canOnLine = false
	local beginT = false
	local endT = false

	if not string.nilorempty(self._startTime) then
		beginT = TimeUtil.instance:dateStr2TimeStamp(self._startTime)
	end

	if not string.nilorempty(self._endTime) then
		endT = TimeUtil.instance:dateStr2TimeStamp(self._endTime)
	end

	if beginT then
		if endT then
			if endT > ServerTime.now() and beginT <= ServerTime.now() then
				canOnLine = true
				self._isLimitTask = true
			end
		elseif beginT <= ServerTime.now() then
			canOnLine = true
		end
	elseif endT then
		if endT > ServerTime.now() then
			canOnLine = true
			self._isLimitTask = true
		end
	else
		canOnLine = true
	end

	return not canOnLine
end

function M:getRewardList()
	return self._rewardList
end

function M:getIsLimitTask()
	return self._isLimitTask
end

function M:getTaskDebugInfo()
	local debugInfo = string.format("任务ID:%s , 复合任务:%s ,任务当前进度:%s,任务总进度:%s,任务状态:%s,是否过期:%s", self._id, self._isTaskGroup, self._count, self._maxCount, self._isFinish, self:isExpired())

	return debugInfo
end

function M:getIcon()
	return self._icon
end

function M:getPoint()
	return self._point
end

return M
