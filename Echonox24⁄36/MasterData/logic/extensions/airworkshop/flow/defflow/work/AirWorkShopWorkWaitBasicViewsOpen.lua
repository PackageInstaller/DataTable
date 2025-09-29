-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/work/AirWorkShopWorkWaitBasicViewsOpen.lua

module("logic.extensions.airworkshop.flow.defflow.work.AirWorkShopWorkWaitBasicViewsOpen", package.seeall)

local M = class("AirWorkShopWorkWaitBasicViewsOpen", WorkBase)

function M:onEnter(context)
	if AirWorkShopDefSceneModel.instance:getDefMainViewOpenStatus() then
		self:onDone(WorkResult.Succeed)

		return
	end

	self:_setEvent(true)
end

function M:onExit(isInterrupt)
	self:_setEvent(false)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.FW_VIEW_OPENING_EVENT, self._onViewOpen, self)
	else
		GlobalDispatcher:removeEventListener(EventType.FW_VIEW_OPENING_EVENT, self._onViewOpen, self)
	end
end

function M:_onViewOpen(evt, viewName)
	if viewName == ViewName.AirWorkShopDefSceneMainView then
		self:onDone(WorkResult.Succeed)
	end
end

return M
