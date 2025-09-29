-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/model/ManualTaskMo.lua

module("logic.extensions.controlaction.model.ManualTaskMo", package.seeall)

local M = class("ManualTaskMo", TaskMo)

function M:ctor()
	M.super.ctor(self)
end

function M:initData(taskId, count, isFinish)
	self._id = taskId
	self._count = count
	self._isFinish = isFinish
	self._taskCO = ControlActionConfig.instance:getManualTaskCfg(taskId)

	if not self._taskCO then
		printError("===not find taskId in t_control_action_task,taskId == ", taskId)

		return
	end

	self._text = self._taskCO.text
	self._content = self._taskCO.content
	self._param = self._taskCO.param
	self._isOnline = self._taskCO.isOnline
	self._rewardId = checknumber(self._taskCO.reward)
	self._rewardList = self:_parseReward()

	self:_parseTask()
end

return M
