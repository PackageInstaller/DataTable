-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/view/newview/ClimbingTowerEntryView.lua

module("logic.extensions.climbingtower.view.newview.ClimbingTowerEntryView", package.seeall)

local M = class("ClimbingTowerEntryView", ViewComponent)

function M:buildUI()
	return
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter(reasonTyp)
	return
end

function M:onExit(reasonTyp)
	return
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self.handleClockTickDailyRefresh, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self.handleClockTickDailyRefresh, self)
	end
end

function M:refreshDarkLeftList()
	return
end

function M:handleClockTickDailyRefresh(e, enum)
	return
end

function M:onClickReturn()
	self:back()
end

function M:onClickHome()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:onClickExplain()
	return
end

function M:getPage(pageTyp)
	return
end

function M:changePage(pageTyp)
	return
end

function M:exitPage(pageCell)
	return
end

return M
