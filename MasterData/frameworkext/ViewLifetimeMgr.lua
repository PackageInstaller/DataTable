-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/view/ViewLifetimeMgr.lua

module("frameworkext.lmvc.view.ViewLifetimeMgr", package.seeall)

local ViewLifetimeMgr = class("ViewLifetimeMgr")

function ViewLifetimeMgr:ctor()
	self._viewCloseTimeDict = {}
	self._isTicking = false
	self._isPaused = false
	self._tickInterval = 1
end

function ViewLifetimeMgr:onOpenView(view)
	if ViewSetting.instance:getAutoDestroyTime(view) <= 0 then
		return
	end

	self._viewCloseTimeDict[view] = nil

	if table.nums(self._viewCloseTimeDict) < 1 then
		self._isTicking = false

		removetimer(ViewLifetimeMgr._onTick, self)
	end
end

function ViewLifetimeMgr:onCloseView(view)
	if ViewSetting.instance:getAutoDestroyTime(view) <= 0 then
		return
	end

	if self._viewCloseTimeDict[view] then
		return
	end

	self._viewCloseTimeDict[view] = Time.time

	if not self._isTicking then
		self._isTicking = true

		settimer(self._tickInterval, ViewLifetimeMgr._onTick, self)
	end
end

function ViewLifetimeMgr:_onTick()
	if self._isPaused then
		return
	end

	local tempList = {}
	local nowTime = Time.time

	for k, v in pairs(self._viewCloseTimeDict) do
		local lifetime = ViewSetting.instance:getAutoDestroyTime(k)
		local time = v + lifetime

		if time < nowTime then
			table.insert(tempList, k)
		end
	end

	local count = #tempList

	for i = 1, count do
		self._viewCloseTimeDict[tempList[i]] = nil

		ViewMgr.instance:destroy(tempList[i])
	end

	tempList = nil

	if table.nums(self._viewCloseTimeDict) < 1 then
		self._isTicking = false

		removetimer(ViewLifetimeMgr._onTick, self)
	end
end

function ViewLifetimeMgr:destroyAllCloseView()
	if self._viewCloseTimeDict then
		for k, _ in pairs(self._viewCloseTimeDict) do
			if k and self._viewCloseTimeDict[k] and self._viewCloseTimeDict[k] > 1 then
				self._viewCloseTimeDict[k] = 1
			end
		end
	end
end

function ViewLifetimeMgr:pauseTick()
	self._isPaused = true
end

function ViewLifetimeMgr:resumeTick()
	self._isPaused = false
end

ViewLifetimeMgr.instance = ViewLifetimeMgr.New()

return ViewLifetimeMgr
