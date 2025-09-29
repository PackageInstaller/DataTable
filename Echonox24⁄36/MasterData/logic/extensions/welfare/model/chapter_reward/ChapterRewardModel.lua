-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/chapter_reward/ChapterRewardModel.lua

module("logic.extensions.welfare.model.chapter_reward.ChapterRewardModel", package.seeall)

local M = class("ChapterRewardModel", BaseModel)

function M:ctor()
	self._taskList = {}
end

function M:onInit()
	return
end

function M:onReset()
	self._taskList = {}
end

function M.sortTaskFunc(aTaskMO, bTaskMO)
	local aReward = aTaskMO:canGetReward()
	local bReward = bTaskMO:canGetReward()

	if aReward ~= bReward then
		return aReward
	end

	local aFinish = aTaskMO:getIsFinish()
	local bFinish = bTaskMO:getIsFinish()

	if aFinish ~= bFinish then
		return not aFinish
	end

	local aPriority = aTaskMO:getPriority()
	local bPriority = bTaskMO:getPriority()

	if aPriority ~= bPriority then
		return bPriority < aPriority
	end

	return aTaskMO:getId() < bTaskMO:getId()
end

function M:setTaskList(tasks)
	table.clear(self._taskList)

	for _, taskNO in ipairs(tasks) do
		local taskMO = ActivityTaskMO.New()

		taskMO:initByTaskNO(taskNO)

		self._taskList[#self._taskList + 1] = taskMO
	end
end

function M:getTaskList(activityId)
	local result = {}

	for _, taskMO in ipairs(self._taskList) do
		if taskMO:getConfigId() == activityId then
			result[#result + 1] = taskMO
		end
	end

	return result
end

function M:receiveReward(taskId)
	for _, taskMO in ipairs(self._taskList) do
		if taskMO:getId() == taskId then
			taskMO:setIsFinish(true)

			return true
		end
	end

	return true
end

function M:onTaskChange(taskNO)
	for _, taskMO in ipairs(self._taskList) do
		if taskMO:getId() == taskNO.id then
			taskMO:initByTaskNO(taskNO)

			return true
		end
	end

	return false
end

M.instance = M.New()

return M
