-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/controller/SeasonTopTipsController.lua

module("logic.extensions.season.controller.SeasonTopTipsController", package.seeall)

local M = class("SeasonTopTipsController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self._dataQueue = Queue.create()
	self._isRunning = false
	self._timer = SchedulerCtrl.New(self._showView, self)
end

function M:onLateInit()
	return
end

function M:onReset()
	self:stop()
	self._dataQueue:clear()
end

function M:enqueueData(data)
	self._dataQueue:enqueue(data)
	self:showNext()
end

function M:showNext(delayTime)
	if self._isRunning and self._dataQueue:size() > 0 then
		delayTime = delayTime or -1

		self._timer:restart(delayTime, false)
	end
end

function M:stop()
	self._timer:stop()

	self._isRunning = false
end

function M:resume()
	self._isRunning = true

	self:showNext()
end

function M:_showView()
	if not ViewMgr.instance:isOpen(ViewName.SeasonTopTips) then
		local data = self._dataQueue:dequeue()

		if data and SeasonFacade.instance:isSysTaskOpen() then
			ViewMgr.instance:openSpecialView(ViewName.SeasonTopTips, data)
		end
	end
end

M.instance = M.New()

return M
