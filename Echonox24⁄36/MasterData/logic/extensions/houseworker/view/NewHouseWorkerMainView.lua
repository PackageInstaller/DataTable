-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/NewHouseWorkerMainView.lua

module("logic.extensions.houseworker.view.NewHouseWorkerMainView", package.seeall)

local M = class("NewHouseWorkerMainView", ViewComponent)
local kViewUrls = {
	ResName.Job_settled_panel,
	ResName.Dorm_settled_panel
}
local kViewClass = {
	HouseJobFragmentView,
	HouseDormFragmentView
}

function M:buildUI()
	self._titleGo = self:getGo("2&title_view_-478490097")
	self._moneyPanelGo = self:getGo("1&top_currency_1050779625")
	self._txtTitleName = self:getText("2&title_view_-788888785")

	self:initViewPage()

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self._viewPager)
	self._toggleTabControl:addToggleTab(self:getUIComponent("room_settled_view_339173136", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("room_settled_view_1145067394", UIComponentType.SpaceXToggle))
end

function M:initViewPage()
	local adapter = DynamicPagerAdapter.New()

	for index, _ in ipairs(kViewUrls) do
		adapter:registerView(kViewUrls[index], kViewClass[index])
	end

	self._viewPager = ViewPager.New(self:getGo("room_settled_view_-14501239"))

	self._viewPager:setViewPresentor(self._viewPresentor)
	self._viewPager:setAdapter(adapter)
	self._viewPager:setPageChangeCallBack(self._onPageChange, self)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:_bindEvents()
	return
end

function M:_unbindEvents()
	return
end

function M:onEnter()
	self:_bindEvents()
	self._toggleTabControl:selectTab(1)
end

function M:onExit()
	self:_unbindEvents()
	self._viewPager:clear()
end

function M:destroyUI()
	self._viewPager:destroy()
end

function M:_onPageChange(index)
	self._tabIndex = index

	if self._tabIndex == 1 then
		self._txtTitleName.text = lang("tip_work_in")
	else
		self._txtTitleName.text = lang("tip_dormitory_in")
	end
end

return M
