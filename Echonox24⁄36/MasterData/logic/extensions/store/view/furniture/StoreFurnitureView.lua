-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/furniture/StoreFurnitureView.lua

module("logic.extensions.store.view.furniture.StoreFurnitureView", package.seeall)

local M = class("StoreFurnitureView", DynamicFragmentView)

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

function M:onEnter()
	self._isEnter = true

	GlobalDispatcher:dispatchEvent(EventType.CLICK_STORE_RIGHT_TAB, self.callBackFunc, self)
end

function M:callBackFunc(tabCfg)
	self._tabCfg = tabCfg
end

function M:onExit()
	self._isEnter = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SIGN_IN_INFO_CHANGE, self._handleSignInInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SIGN_IN_INFO_CHANGE, self._handleSignInInfoChange, self)
	end
end

return M
