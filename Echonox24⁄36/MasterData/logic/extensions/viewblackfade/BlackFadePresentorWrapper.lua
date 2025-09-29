-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/viewblackfade/BlackFadePresentorWrapper.lua

module("logic.extensions.viewblackfade.BlackFadePresentorWrapper", package.seeall)

local M = class("BlackFadePresentorWrapper")

function M.extend(presentor)
	presentor.open = M.open
	presentor._blackFade_handleFadeFinish = M._blackFade_handleFadeFinish
	presentor._blackFade_duelOpen = M._blackFade_duelOpen
end

function M:open(param, windowOpenReasonType, isBackOpen)
	self._openParam = param
	self._isBackOpen = isBackOpen
	self._openReasonType = windowOpenReasonType

	if not isBackOpen and ViewBlackFadeController.instance:getNeedBlackFade(self:getViewName()) then
		GlobalDispatcher:addEventListener(EventType.ON_VIEW_BLACK_FADE_FINISH, self._blackFade_handleFadeFinish, self)
	else
		self:_blackFade_duelOpen()
	end
end

function M:_blackFade_handleFadeFinish(e, fadeIn)
	if fadeIn then
		GlobalDispatcher:removeEventListener(EventType.ON_VIEW_BLACK_FADE_FINISH, self._blackFade_handleFadeFinish, self)
		self:_blackFade_duelOpen()
	end
end

function M:_blackFade_duelOpen()
	local WindowOpType = WindowType.WindowOpType
	local WindowStatusType = WindowType.WindowStatusType
	local WindowCloseReasonType = WindowType.WindowCloseReasonType

	if not self._isResLoaded and self._opType ~= WindowOpType.ViewOpOpen then
		self._opType = WindowOpType.ViewOpOpen

		if self._resLoader == nil then
			self:loadViewResources()
		end

		return
	end

	if self._status == WindowStatusType.ViewStatusClose then
		self:_doOpen(self._openReasonType)
	elseif self._status == WindowStatusType.ViewStatusClosing then
		self._opType = WindowOpType.ViewOpOpen

		self:playCloseAnimation(WindowCloseReasonType.QuickCloseType)
		self:_doOpen(self._openReasonType)
	elseif self._status == WindowStatusType.ViewStatusIniting then
		self._opType = WindowOpType.ViewOpOpen
	else
		self._opType = WindowOpType.ViewOpNone
	end
end

return M
