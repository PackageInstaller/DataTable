-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/task/AirWorkTaskMo.lua

module("logic.extensions.airworkshop.model.task.AirWorkTaskMo", package.seeall)

local M = class("AirWorkTaskMo", TaskMo)

function M:ctor()
	M.super.ctor(self)
end

function M:initData(taskId, count, isFinish)
	self._id = taskId
	self._count = count
	self._isFinish = isFinish
	self._taskCO = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirStudioTask, taskId)

	if not self._taskCO then
		printError("===not find taskId in t_air_studio_task,taskId == ", taskId)

		return
	end

	self._seasonId = self._taskCO.seasonId
	self._type = self._taskCO.type
	self._text = self._taskCO.text
	self._content = self._taskCO.content
	self._param = self._taskCO.param
	self._rewardId = self._taskCO.reward
	self._rewardList = self:_parseReward()

	self:_parseTask()

	self._jump = self._taskCO.jump
	self._priority = self._taskCO.priority
	self._isOnline = self._taskCO.isOnline
end

function M:getSeasonId()
	return self._seasonId
end

function M:getType()
	return self._type
end

function M:isOnline()
	return self._isOnline
end

function M:getSortIndex()
	return self._priority
end

return M
