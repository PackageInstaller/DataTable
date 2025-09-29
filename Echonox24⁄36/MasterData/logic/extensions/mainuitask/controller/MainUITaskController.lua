-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainuitask/controller/MainUITaskController.lua

module("logic.extensions.mainuitask.controller.MainUITaskController", package.seeall)

local M = class("MainUITaskController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
	self:setEvent(true)
end

function M:onReset()
	self:setChaseTask(nil, false)
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:setChaseTask(taskId, broadcast)
	self._chaseTaskId = taskId

	if broadcast then
		GlobalDispatcher:dispatchEvent(EventType.UPDATE_HOME_CHASE_TASK, self._chaseTaskId)
	end
end

function M:getChaseTask()
	return self._chaseTaskId or 0
end

M.instance = M.New()

return M
