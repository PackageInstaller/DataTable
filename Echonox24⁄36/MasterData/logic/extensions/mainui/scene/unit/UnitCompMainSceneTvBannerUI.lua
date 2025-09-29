-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitCompMainSceneTvBannerUI.lua

module("logic.extensions.mainui.scene.unit.UnitCompMainSceneTvBannerUI", package.seeall)

local M = class("UnitCompMainSceneTvBannerUI", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:onInit()
	self._resLoaderTvUI = MultiResLoader.New()
	self._resDictTvUI = {}

	self:tryInitUI()
	GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._handleViewCloseOpenEvent, self)
	GlobalDispatcher:addEventListener(EventType.FW_VIEW_OPEN_OVER_EVENT, self._handleViewCloseOpenEvent, self)
end

function M:OnEnable()
	M.super.OnEnable(self)
end

function M:OnDisable()
	M.super.OnDisable(self)
end

function M:onDestroy()
	GlobalDispatcher:removeEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._handleViewCloseOpenEvent, self)
	GlobalDispatcher:removeEventListener(EventType.FW_VIEW_OPEN_OVER_EVENT, self._handleViewCloseOpenEvent, self)
	self:_clear()

	self._resLoaderTvUI = nil
	self._resDictTvUI = nil
	self._goRedPoint = nil
end

function M:onLeaveScene(needUnloadRes)
	self:showUI(false)
end

function M:onReturnScene(needUnloadRes)
	return
end

function M:onReturnSceneFinished(needUnloadRes)
	self:showUI(true)
end

function M:_handleViewCloseOpenEvent(e)
	local mainUIOpen = ViewMgr.instance:isOpen(ViewName.MainUIView)

	self:showUI(mainUIOpen)
end

function M:tryInitUI()
	return
end

function M:_clear()
	self:unbindUI()

	for _resTyp, go in pairs(self._resDictTvUI or {}) do
		goutil.destroy(go)
	end

	self._resDictTvUI = {}

	self._resLoaderTvUI:clear()
end

function M:getInst(resPath)
	if self._resDictTvUI then
		return self._resDictTvUI[resPath]
	end

	return nil
end

function M:_onAllLoadedTvUI(loader)
	self._resLoaderTvUI:clear()
end

function M:_onLoadedTvUI(res)
	if not self._resDictTvUI then
		self._resDictTvUI = {}
	end

	if res.IsSuccess then
		res:Retain()

		if not self._resDictTvUI[res.ResPath] then
			local inst = goutil.cloneAndSetParent(res:GetAsset(nil, nil), self._unit.mainGO.transform)

			self._resDictTvUI[res.ResPath] = inst

			goutil.setActive(inst.gameObject, true)
			self:_buildUI(inst)
		end
	end
end

function M:showUI(show)
	return
end

function M:_buildUI(mainGO)
	if not mainGO then
		return
	end
end

function M:unbindUI()
	return
end

function M:_setEvent(add)
	if add then
		-- block empty
	end
end

function M:_refreshRedDot()
	return
end

return M
