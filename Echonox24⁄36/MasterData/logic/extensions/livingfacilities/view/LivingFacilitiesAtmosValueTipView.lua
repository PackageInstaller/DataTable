-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesAtmosValueTipView.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesAtmosValueTipView", package.seeall)

local M = class("LivingFacilitiesAtmosValueTipView", ViewComponent)
local LivingRoomType = HouseEnum.LivingRoomType

function M:buildUI()
	local registry = self._viewPresentor._viewElementsRegistry

	self._viewPager = ViewPager.New(self.mainGO)

	self._viewPager:setAdapter(StaticPagerAdapter.New(registry))
	self._viewPager:setViewPresentor(self._viewPresentor)

	local pagerAdapter = self._viewPager:getAdapter()

	pagerAdapter:addFragmentView(LivingFacilitiesBasicAtmosFragmentView.New(self:getGo("atmosphere_value_tips_-40165589"), self._viewPresentor))
	pagerAdapter:addFragmentView(LivingFacilitiesRoomAtmosFragmentView.New(self:getGo("atmosphere_value_tips_-1847078916"), self._viewPresentor))

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self._viewPager)
	self._toggleTabControl:addToggleTab(self:getUIComponent("atmosphere_value_tips_-1805305230", UIComponentType.SpaceXToggle))

	self._toggleDormitory = self:getUIComponent("atmosphere_value_tips_-1039618544", UIComponentType.SpaceXToggle)

	self._toggleTabControl:addToggleTab(self._toggleDormitory)

	local specialTab = self:getUIComponent("atmosphere_value_tips_-236216505")

	goutil.setActive(specialTab, false)

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
	local curZoneMO = LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	goutil.setActive(self._toggleDormitory.gameObject, HouseSceneUtil.isDormitoryRoom(curZoneMO:getType()))
	self._toggleTabControl:selectTab(1)
end

function M:onExit()
	self._viewPager:clear()
end

function M:_onClickClose()
	self:close()
end

return M
