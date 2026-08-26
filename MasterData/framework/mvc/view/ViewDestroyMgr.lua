-- chunkname: @framework/mvc/view/ViewDestroyMgr.lua

module("framework.mvc.view.ViewDestroyMgr", package.seeall)

local ViewDestroyMgr = class("ViewDestroyMgr")

ViewDestroyMgr.TickInterval = 0.03

function ViewDestroyMgr:init()
	self._isRunning = false
	self._dict = {}
	self._priorityQueue = PriorityQueue.New(function(viewObj1, viewObj2)
		return viewObj1.destroyTime < viewObj2.destroyTime
	end)

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function ViewDestroyMgr:destroyImmediately()
	while self._priorityQueue:getSize() > 0 do
		local viewObj = self._priorityQueue:getFirst()

		self._priorityQueue:getFirstAndRemove()
		ViewMgr.instance:destroyView(viewObj.viewName)
	end

	self._isRunning = false

	TaskDispatcher.cancelTask(self._tick, self)
end

function ViewDestroyMgr:_onOpenView(viewName)
	if self._dict[viewName] then
		self._dict[viewName] = nil

		self._priorityQueue:markRemove(function(viewObj)
			return viewObj.viewName == viewName
		end)
	end
end

function ViewDestroyMgr:_onCloseViewFinish(viewName)
	local viewSetting = ViewMgr.instance:getSetting(viewName)
	local destroyTime = Time.realtimeSinceStartup + ((not viewSetting.destroy or nil) and ViewDestroyMgr.TickInterval)

	self._dict[viewName] = true

	self._priorityQueue:add({
		viewName = viewName,
		destroyTime = destroyTime
	})

	if not self._isRunning then
		self._isRunning = true

		TaskDispatcher.runRepeat(self._tick, self, ViewDestroyMgr.TickInterval)
	end
end

function ViewDestroyMgr:_tick()
	local nowTime = Time.realtimeSinceStartup

	while self._priorityQueue:getSize() > 0 do
		local viewObj = self._priorityQueue:getFirst()

		if nowTime > viewObj.destroyTime then
			self._priorityQueue:getFirstAndRemove()
			ViewMgr.instance:destroyView(viewObj.viewName)
		else
			break
		end
	end

	if self._priorityQueue:getSize() == 0 then
		self._isRunning = false

		TaskDispatcher.cancelTask(self._tick, self)
	end
end

ViewDestroyMgr.instance = ViewDestroyMgr.New()

return ViewDestroyMgr
