-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/CommonEquipFilterView.lua

module("logic.extensions.charactersystem.view.equip.CommonEquipFilterView", package.seeall)

local M = class("CommonEquipFilterView", ViewComponent)

function M:buildUI()
	local registry = self._viewPresentor._viewElementsRegistry

	self._viewPager = ViewPager.New(self.mainGO)

	self._viewPager:setAdapter(StaticPagerAdapter.New(registry))
	self._viewPager:setViewPresentor(self._viewPresentor)

	local pagerAdapter = self._viewPager:getAdapter()

	self._baseFilterFragmentView = CommonEquipBaseFilterFragmentView.New(self:getGo("backpack_filter_tips_2_1692466750"), self._viewPresentor)

	pagerAdapter:addFragmentView(self._baseFilterFragmentView)

	self._d6FilterFragmentView = CommonEquipD6FilterFragmentView.New(self:getGo("backpack_filter_tips_2_1047256366"), self._viewPresentor)

	pagerAdapter:addFragmentView(self._d6FilterFragmentView)

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self._viewPager)
	self._toggleTabControl:addToggleTab(self:getUIComponent("backpack_filter_tips_2_-2120100740", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("backpack_filter_tips_2_368830958", UIComponentType.SpaceXToggle))

	self._d6FilterGo = self:getGo("backpack_filter_tips_2_368830958")
	self._btnClose = self:getBtn("40&middle_tips_common_bg_-1205189576")
	self._btnReset = self:getBtn("backpack_filter_tips_2_866352753")
	self._btnEnsure = self:getBtn("backpack_filter_tips_2_-1091144780")
end

function M:destroyUI()
	self._viewPager:destroy()
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnEnsure:AddClickListener(self._onClickEnsure, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnEnsure:RemoveClickListener()
end

function M:onEnter()
	local firstParam = self:getFirstParam()

	self._filterCfg = firstParam.filterCfg
	self._filterEvent = firstParam.filterEvent

	self._baseFilterFragmentView:setViewData(firstParam.items, firstParam.filterCfg)
	self._d6FilterFragmentView:setViewData(firstParam.filterCfg)
	self._toggleTabControl:selectTab(firstParam.index or 1)

	local isOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.EquipD6, false)

	self._d6FilterGo:SetActive(isOpen)
end

function M:onExit()
	self._viewPager:clear()
end

function M:_onClickClose()
	self._baseFilterFragmentView:backToLast()
	self._d6FilterFragmentView:backToLast()
	self:back()
end

function M:_onClickReset()
	if self._toggleTabControl:getTab(1).IsOn then
		self._baseFilterFragmentView:doReset()
	else
		self._d6FilterFragmentView:doReset()
	end
end

function M:_onClickEnsure()
	if self._filterEvent then
		GlobalDispatcher:dispatchEvent(self._filterEvent, self._filterCfg)
	end

	self:back()
end

return M
