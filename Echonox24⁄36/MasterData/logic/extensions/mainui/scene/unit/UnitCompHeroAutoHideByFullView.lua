-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitCompHeroAutoHideByFullView.lua

module("logic.extensions.mainui.scene.unit.UnitCompHeroAutoHideByFullView", package.seeall)

local M = class("UnitCompHeroAutoHideByFullView", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:onInit()
	self:onReset()
	self:setEvent(true)
end

function M:onDestroy()
	self:onReset()
	self:setEvent(false)
end

function M:isDestroyed()
	if self._unit then
		return self._unit:isDestroyed()
	end

	return true
end

function M:onReset()
	self:setEvent(false)
	self:clear()
end

function M:onReuse()
	self:setEvent(true)
end

function M:clear()
	return
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.FW_VIEW_OEPN_FULL_SCREEN_EVENT, self._handleFullViewOpenEvent, self)
	else
		GlobalDispatcher:removeEventListener(EventType.FW_VIEW_OEPN_FULL_SCREEN_EVENT, self._handleFullViewOpenEvent, self)
	end
end

function M:_handleFullViewOpenEvent(e, viewName)
	local isNeedShowCamera = not ViewSetting.instance:isOnlyFullScreen(viewName)

	self._unit.meshModel:setModelActive(isNeedShowCamera)
end

return M
