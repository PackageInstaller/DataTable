-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbietask/view/NewbieTaskWeekTab.lua

module("logic.extensions.newbietask.view.NewbieTaskWeekTab", package.seeall)

local M = class("NewbieTaskWeekTab", ViewComponent)

function M:init(taskView)
	self._taskView = taskView
	self._tabComp = taskView.tabComp
	self._activeIndex = 1
end

function M:setPage(tabIndex)
	local samePage = self._activeIndex == tabIndex
	local duration = samePage and 0 or 0.3

	duration = self._activeIndex and math.abs(self._activeIndex - tabIndex) <= 1 and 0.2 or duration
	self._activeIndex = tabIndex

	if not samePage then
		self._taskView:refreshWeekDay(tabIndex)
		self._tabComp:MoveSelectMark(tabIndex, duration)
	end
end

function M:getSelectWeek()
	return self._activeIndex or 1
end

return M
