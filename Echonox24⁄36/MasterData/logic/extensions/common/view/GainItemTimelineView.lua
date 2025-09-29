-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/GainItemTimelineView.lua

module("logic.extensions.common.view.GainItemTimelineView", package.seeall)

local M = class("GainItemTimelineView", ViewComponent)

function M:ctor()
	return
end

function M:buildUI()
	return
end

function M:destroyUI()
	removetimer(self._setOpenAniFinish, self)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._isEnter = true
	self._openAniFinish = false

	self:setEvent(true)
end

function M:onExit()
	removetimer(self._setOpenAniFinish, self)

	self._isEnter = false
	self._openAniFinish = false

	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	else
		self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	end
end

function M:_handlePointerPressed(_, position)
	self:_tryDealClick()
end

function M:_handleViewAniDoneEvent(key, tagName, reason)
	if tagName == "open" then
		self._openAniFinish = true
	end
end

function M:getOpenAniFinish()
	return self._openAniFinish
end

function M:onClickEvent()
	if not self._isEnter then
		return
	end

	if self:getOpenAniFinish() then
		self:close()
	else
		self._viewPresentor:jumpOpenAniToEnd()
		self:localNotify(EventType.ON_UI_TIMELINE_JUMP_TO_END)
	end
end

return M
