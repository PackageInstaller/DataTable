-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/view/RoomMainAtmosValueTipView.lua

module("logic.extensions.housemain.view.RoomMainAtmosValueTipView", package.seeall)

local M = class("RoomMainAtmosValueTipView", ViewComponent)

function M:buildUI()
	local registry = self._viewPresentor._viewElementsRegistry

	self._viewPager = ViewPager.New(self.mainGO)

	self._viewPager:setAdapter(StaticPagerAdapter.New(registry))
	self._viewPager:setViewPresentor(self._viewPresentor)

	local pagerAdapter = self._viewPager:getAdapter()

	pagerAdapter:addFragmentView(RoomMainTotalAtmosFragmentView.New(self:getGo("atmosphere_value_tips_-40165589"), self._viewPresentor))
	pagerAdapter:addFragmentView(RoomMainSpAtmosFragmentView.New(self:getGo("atmosphere_value_tips_-398854971"), self._viewPresentor))

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self._viewPager)
	self._toggleTabControl:addToggleTab(self:getUIComponent("atmosphere_value_tips_-1805305230", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("atmosphere_value_tips_-236216505", UIComponentType.SpaceXToggle))
	goutil.setActive(self:getGo("atmosphere_value_tips_-236216505"), true)
	goutil.setActive(self:getGo("atmosphere_value_tips_-1039618544"), false)

	self._closeBtn = self:getBtn("1&middle_tips_common_bg_-1205189576")
end

function M:destroyUI()
	self._viewPager:destroy()
	self._toggleTabControl:destroy()

	self._viewPager = nil
	self._toggleTabControl = nil
	self._closeBtn = nil
end

function M:bindEvents()
	self._closeBtn:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._closeBtn:RemoveClickListener()
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	self._toggleTabControl:selectTab(1)
end

function M:onExit()
	self._viewPager:clear()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Room)
end

function M:_onClickClose()
	self:close()
end

return M
