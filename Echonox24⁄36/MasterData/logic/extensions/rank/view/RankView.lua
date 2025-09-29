-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/RankView.lua

module("logic.extensions.rank.view.RankView", package.seeall)

local M = class("RankView", ViewComponent)
local subViewUrl = {
	[CommEnum.RankEnum.Collection] = ResName.CollectionRankView,
	[CommEnum.RankEnum.Level] = ResName.LevelRankView,
	[CommEnum.RankEnum.ClimbTower] = ResName.ClimbTowerRankView,
	[CommEnum.RankEnum.AirWorkShop] = ResName.AirWorkShopRankView,
	[CommEnum.RankEnum.MainLine] = ResName.MainLineRankView
}
local subViewClass = {
	[CommEnum.RankEnum.Collection] = CollectionRankPanel,
	[CommEnum.RankEnum.Level] = LevelRankPanel,
	[CommEnum.RankEnum.ClimbTower] = ClimbTowerRankPanel,
	[CommEnum.RankEnum.AirWorkShop] = AirWorkShopRankPanel,
	[CommEnum.RankEnum.MainLine] = MainLineRankPanel
}

function M:ctor()
	M.super.ctor(self)

	self._typeTorankIdsDic = {}
	self._tabItemGoList = {}
	self._viewPager = nil
	self._showRankTypes = nil
	self._validRnakTypes = {}
	self._toggleTabControl = nil
	self._tabComp = nil
	self._activeIndex = 1
end

function M:buildUI()
	self.go_panel = self:getGo("player_ranking_list_view_1363819981")
	self.tr_tabParent = self:getRectTransform("0&left_tab_content_-205429629")
	self.go_tab = self:getGo("0&left_tab_content_-242000516")
	self.go_left_tab_content = self:getGo("0&left_tab_content_-399612422")
	self.btn_btnReturn = self:getBtn("1&title_view_-878360263")
	self.btn_btnHome = self:getBtn("1&title_view_1398742689")
end

function M:bindEvents()
	self.btn_btnReturn:AddClickListener(self._onClickReturn, self)
	self.btn_btnHome:AddClickListener(self._onClickHome, self)
end

function M:unbindEvents()
	self.btn_btnReturn:RemoveClickListener()
	self.btn_btnHome:RemoveClickListener()
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKHOUR, self._onTickHour, self)
	GlobalDispatcher:addEventListener(EventType.GET_VALID_RANK, self._onGetValidRank, self)

	local validRankIds = self:getFirstParam()

	if not validRankIds then
		return
	end

	self:_buildListTab(validRankIds)
	self._toggleTabControl:selectTab(self._activeIndex)

	local isBackOpen = self._viewPresentor:getIsBackOpen()

	self._tabComp:setCanvasGroupShow(true)
	self._tabComp:onEnter()
	self._tabComp:playGuiAniTab(true, not isBackOpen, self._activeIndex)
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKHOUR, self._onTickHour, self)
	GlobalDispatcher:removeEventListener(EventType.GET_VALID_RANK, self._onGetValidRank, self)

	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	self._tabComp:onExit()
	self._tabComp:playGuiAniTab(false, isNormalClose)
end

function M:_buildListTab(rankIds)
	if not rankIds or self._viewPager then
		return
	end

	self:_updateTypeTorankIds(rankIds)

	self._showRankTypes = self:_getShowRankTypes(self._typeTorankIdsDic)

	if not self._showRankTypes or #self._showRankTypes <= 0 then
		return
	end

	self._viewPager = ViewPager.New(self.go_panel)

	local adapter = DynamicPagerAdapter.New()

	self._toggleTabControl = ToggleTabControl.New()

	self._viewPager:setViewPresentor(self._viewPresentor)
	self._viewPager:setAdapter(adapter)
	self._viewPager:setPageChangeCallBack(self.setPage, self)
	self._toggleTabControl:setViewPager(self._viewPager)

	self._tabComp = Astral.LuaComponentContainer.Add(self.go_left_tab_content, LeftTabComp)

	for index, rankType in ipairs(self._showRankTypes) do
		adapter:registerView(subViewUrl[rankType], subViewClass[rankType], rankType)

		local tabGo = self:_generateTab(rankType, index)

		self._toggleTabControl:addToggleTab(tabGo:GetComponent(UIComponentType.SpaceXToggle))
	end

	self._toggleTabControl:setTabCheckFunc(function(tabIndex)
		return self:_tabCheckFunc(tabIndex)
	end)
end

function M:_generateTab(rankType, index)
	local tabGo

	if index <= self.tr_tabParent.childCount - 1 then
		tabGo = self.tr_tabParent:GetChild(index).gameObject
	else
		tabGo = goutil.cloneAndSetParent(self.go_tab, self.tr_tabParent, tostring(rankType))
	end

	goutil.setActive(tabGo, true)

	local noramlTxt = goutil.findChildTextComponent(tabGo, "normal/Text1")
	local selectTxt = goutil.findChildTextComponent(tabGo, "select/Text1")
	local tabName = RankConfig.instance:getTabName(rankType)

	noramlTxt.text = tabName
	selectTxt.text = tabName

	return tabGo
end

function M:_updateTypeTorankIds(rankIds)
	for _, value in ipairs(rankIds) do
		if RankController.instance:isMainViewRank(value) then
			local rankType = RankConfig.instance:getRankType(value)

			if not self._typeTorankIdsDic[rankType] then
				self._typeTorankIdsDic[rankType] = {}
			end

			local rankIdList = self._typeTorankIdsDic[rankType]

			if not table.indexof(rankIdList, value) then
				table.insert(rankIdList, value)
			end
		end
	end
end

function M:_getShowRankTypes(typeTorankIdsDic)
	local rankTypes = {}

	table.clear(self._validRnakTypes)

	for type, rankIds in pairs(typeTorankIdsDic) do
		table.insert(rankTypes, type)

		for _, rankId in ipairs(rankIds) do
			local rankType = RankConfig.instance:getRankType(rankId)

			table.insert(self._validRnakTypes, rankType)

			break
		end
	end

	table.sort(rankTypes, function(a, b)
		return a < b
	end)

	return rankTypes
end

function M:_tabCheckFunc(tabIndex)
	local rankType = self._showRankTypes[tabIndex]

	if not rankType then
		FloatWordMgr.instance:show(lang("rank_no_open"))

		return false
	end

	for _, validRnakType in ipairs(self._validRnakTypes) do
		if rankType == validRnakType then
			return true
		end
	end

	FloatWordMgr.instance:show(lang("rank_no_open"))

	return false
end

function M:_onTickHour()
	RankAgent.instance:sendGetRankInfoRequest()
end

function M:_onGetValidRank(_, validRanks)
	self._validRnakTypes = {}

	if not validRanks then
		return
	end

	for i = 1, #validRanks do
		local rankId = validRanks[i]

		if RankController.instance:isMainViewRank(rankId) then
			local rankType = RankConfig.instance:getRankType(rankId)

			if not table.indexof(self._validRnakTypes, rankType) then
				table.insert(self._validRnakTypes, rankType)
			end
		end
	end

	self:_checkJumpValidTab()
end

function M:_checkJumpValidTab()
	local curRankType = self._showRankTypes[self._activeIndex]

	if table.indexof(self._validRnakTypes, curRankType) then
		return
	end

	for index, value in ipairs(self._showRankTypes) do
		if table.indexof(self._validRnakTypes, value) then
			self._toggleTabControl:selectTab(index)

			return
		end
	end
end

function M:_onClickReturn()
	self:back()
end

function M:_onClickHome()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:setPage(tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = orgIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		self._tabComp:MoveSelectMark(tabIndex, 0)
	end
end

function M:destroyUI()
	self._viewPager:clear()
	self._viewPager:destroy()
	self._toggleTabControl:destroy()

	self._typeTorankIdsDic = nil
	self._tabItemGoList = nil
	self._viewPager = nil
	self._showRankTypes = nil
	self._validRnakTypes = nil
	self._toggleTabControl = nil
	self._tabComp = nil
	self._activeIndex = nil
end

return M
