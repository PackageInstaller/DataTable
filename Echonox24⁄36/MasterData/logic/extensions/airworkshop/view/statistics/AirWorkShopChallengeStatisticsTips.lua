-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/statistics/AirWorkShopChallengeStatisticsTips.lua

module("logic.extensions.airworkshop.view.statistics.AirWorkShopChallengeStatisticsTips", package.seeall)

local M = class("AirWorkShopChallengeStatisticsTips", ViewComponent)

M.SubViewTyp = {
	Pass = 1,
	Defence = 2
}

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	local registry = self._viewPresentor._viewElementsRegistry

	self._viewGroup = {}
	self._viewGroup[self.SubViewTyp.Pass] = AirWorkShopChallengeStatisticsPassFragmentView.New(self:getGo("challenge_schema_statistics_tips_1877978284"), self._viewPresentor)
	self._viewGroup[self.SubViewTyp.Defence] = AirWorkShopChallengeStatisticsDefenceFragmentView.New(self:getGo("challenge_schema_statistics_tips_1712746145"), self._viewPresentor)
	self._viewPager = ViewPager.New(self.mainGO)

	self._viewPager:setAdapter(StaticPagerAdapter.New(registry))
	self._viewPager:setViewPresentor(self._viewPresentor)

	local pagerAdapter = self._viewPager:getAdapter()

	pagerAdapter:addFragmentView(self._viewGroup[self.SubViewTyp.Pass])
	pagerAdapter:addFragmentView(self._viewGroup[self.SubViewTyp.Defence])

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self._viewPager)
	self._toggleTabControl:addToggleTab(self:getUIComponent("challenge_schema_statistics_tips_-566951762", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("challenge_schema_statistics_tips_167227593", UIComponentType.SpaceXToggle))

	self._btnClose = self:getBtn("7&middle_tips_common_bg_-1205189576")
end

function M:destroyUI()
	self._viewPager:destroy()
	self._toggleTabControl:destroy()

	self._viewPager = nil
	self._toggleTabControl = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)

	local info = self:getFirstParam()

	self._mapId = info.id

	local defaultPage = M.SubViewTyp.Pass

	self._toggleTabControl:selectTab(defaultPage)
	AirWorkShopController.instance:getMapStatistics(self:getMapId())
end

function M:onExit()
	self:setEvent(false)
	self._viewPager:clear()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_BATTLE_STATISTICS_REPLY, self._handleStatisticsReply, self)
	else
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_BATTLE_STATISTICS_REPLY, self._handleStatisticsReply, self)
	end
end

function M:_onClickClose()
	self:close()
end

function M:_handleStatisticsReply(e, mapId)
	if self:getMapId() ~= mapId then
		return
	end

	local statisticsMo = AirWorkShopStatisticsModel.instance:getMapData(mapId)

	self._viewGroup[self.SubViewTyp.Pass]:setData(statisticsMo:getAttackDataLst())
	self._viewGroup[self.SubViewTyp.Defence]:setData(statisticsMo:getDefDataLst())

	local curPage = self._viewPager:getPage()

	self._viewGroup[curPage]:refreshView()
end

function M:getMapId()
	return self._mapId
end

return M
