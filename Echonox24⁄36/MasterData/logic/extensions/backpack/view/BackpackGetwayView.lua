-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackGetwayView.lua

module("logic.extensions.backpack.view.BackpackGetwayView", package.seeall)

local M = class("BackpackGetwayView", ViewComponent)

function M:ctor()
	self._btnGetWays = false
	self._getWaysList = false
	self._btnGetWaysRayCast = false
	self._getWaysRayCastNode = false
	self._waysListView = false
	self._btnGetWaysTog = false
	self._globalTouchTrigger = false
end

function M:buildUI()
	self._btnGetWays = self:getBtn("0&prop_panel_1101829130")
	self._btnGetWaysTog = self:getUIComponent("0&prop_panel_1101829130", UIComponentType.SpaceXToggle)
	self._getWaysList = self:getGo("0&prop_panel_1870046118")
	self._waysListView = ListBinderView.New(SystemJumpModel.instance:getJumpModelListData(), self._getWaysList, self:getResInstance(BackpackViewViewPresentor.Url_Getway_Item), GetwayCell)

	self._waysListView:buildUI()
	self._waysListView:setViewPresentor(self._viewPresentor)

	self._globalTouchTrigger = Astral.UIGlobalTouchTrigger.Get(self._getWaysList)
end

function M:bindEvents()
	self._btnGetWays:AddClickListener(self._showGetWays, self)
	self._globalTouchTrigger:AddIgnoreTargetListener(self._dealGetWaysRayCast, self)
end

function M:unbindEvents()
	self._btnGetWays:RemoveClickListener()
	self._globalTouchTrigger:RemoveIgnoreTargetListener()
end

function M:onEnter()
	self._waysListView:onEnter()
end

function M:_dealGetWaysRayCast()
	self._btnGetWaysTog:ForceSetOn(false)
	goutil.setActive(self._getWaysList, false)
end

function M:_showGetWays()
	goutil.setActive(self._getWaysList, true)

	local getWays = SystemJumpModel.instance:getCurrSelectJumpIds()

	SystemJumpModel.instance:updateJumpModelListData(getWays)
end

return M
