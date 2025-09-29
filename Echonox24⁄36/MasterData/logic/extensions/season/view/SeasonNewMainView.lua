-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonNewMainView.lua

module("logic.extensions.season.view.SeasonNewMainView", package.seeall)

local M = class("SeasonNewMainView", ViewComponent)

M.PageType = {
	Judge = 2,
	Achievements = 1
}
M.kViewUrls = {
	[M.PageType.Achievements] = ResName.Secret_secret_time_achievements_panel,
	[M.PageType.Judge] = ResName.Secret_secret_time_judge_panel
}
M.kViewClass = {
	[M.PageType.Achievements] = SeasonNewAchievementPanel,
	[M.PageType.Judge] = SeasonNewJudgePanel
}
M.kSystemOpenEnumList = {
	[M.PageType.Achievements] = GameEnum.SystemEnum.Task,
	[M.PageType.Judge] = GameEnum.SystemEnum.Task
}

function M:buildUI()
	local adapter = DynamicPagerAdapter.New()

	for index, _ in ipairs(self.kViewUrls) do
		adapter:registerView(self.kViewUrls[index], self.kViewClass[index])
	end

	self._viewPager = ViewPager.New(self:getGoByPath("panel"))

	self._viewPager:setViewPresentor(self._viewPresentor)
	self._viewPager:setAdapter(adapter)
	self._viewPager:setPageChangeCallBack(self.setPage, self)

	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("0&left_tab_content_-399612422"), LeftTabComp)

	self._tabComp:setActiveTabIndexLst({
		1,
		2
	})

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self._viewPager)
	self._toggleTabControl:addToggleTab(self:getGo("0&left_tab_content_-242000516"):GetComponent(UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getGo("0&left_tab_content_-1578871314"):GetComponent(UIComponentType.SpaceXToggle))

	self._goRedPointTask = self:getGo("0&1&red_point_-1414002736")
	self._goRedPointLv = self:getGo("0&2&red_point_-1414002736")
end

function M:destroyUI()
	self._viewPager:clear()
	self._viewPager:destroy()

	self._viewPager = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:_setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SEASON_INFO_UPDATE, self._onSeasonInfoUpdate, self)
		GlobalDispatcher:addEventListener(EventType.SEASON_TASK_UPDATE, self._refreshRedPoint, self)
		GlobalDispatcher:addEventListener(EventType.SEASON_RECEIVE_TASK, self._refreshRedPoint, self)
		GlobalDispatcher:addEventListener(EventType.SEASON_TASK_PROGRESS_UPDATE, self._refreshRedPoint, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SEASON_INFO_UPDATE, self._onSeasonInfoUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.SEASON_TASK_UPDATE, self._refreshRedPoint, self)
		GlobalDispatcher:removeEventListener(EventType.SEASON_RECEIVE_TASK, self._refreshRedPoint, self)
		GlobalDispatcher:removeEventListener(EventType.SEASON_TASK_PROGRESS_UPDATE, self._refreshRedPoint, self)
	end
end

function M:onEnter()
	SeasonAgent.instance:sendSeasonInfoRequest()
	SeasonAgent.instance:sendSeasonListTaskRequest()
	SeasonAgent.instance:sendReportRequest()

	local targetTabIdx, subIdx = self:_getOpenIndex()
	local isBackOpen = self._viewPresentor:getIsBackOpen()

	self._defaultTabIndex = self._activeIndex or targetTabIdx

	self._tabComp:setCanvasGroupShow(true)
	self._toggleTabControl:selectTab(self._defaultTabIndex)
	self._tabComp:onEnter()
	self._tabComp:playGuiAniTab(true, not isBackOpen, self._defaultTabIndex)

	local panel = self._viewPager:getAdapter():getView(self._defaultTabIndex)

	if isBackOpen then
		panel:playGuiAni("open")
	end

	panel:setParam(subIdx)
	self:_setEvents(true)
end

function M:_getOpenIndex()
	local tabIdx = M.PageType.Achievements
	local subIdx = 1
	local info = self:getFirstParam()

	if info then
		tabIdx = info.index or tabIdx
		subIdx = info.subIndex or subIdx
	elseif SeasonModel.instance:hasDailyReward() then
		tabIdx = M.PageType.Judge
		subIdx = SeasonNewJudgePanel.PageType.Day
	elseif SeasonModel.instance:hasWeeklyReward() then
		tabIdx = M.PageType.Judge
		subIdx = SeasonNewJudgePanel.PageType.Weekly
	elseif SeasonModel.instance:hasAchievementReward() then
		tabIdx = M.PageType.Achievements
		subIdx = 1
	elseif SeasonModel.instance:hasFixedReward() then
		tabIdx = M.PageType.Judge
		subIdx = SeasonNewJudgePanel.PageType.Fixed
	end

	return tabIdx, subIdx
end

function M:onExit(reasonTyp)
	self:_setEvents(false)

	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	self._tabComp:onExit()

	if isNormalClose then
		self:playDynamicPageTimeLineAni("close", isNormalClose)

		self._activeIndex = nil
	else
		self:playDynamicPageTimeLineAni(nil, false)
	end

	self._tabComp:playGuiAniTab(false, isNormalClose)
end

function M:playDynamicPageTimeLineAni(animName, isNormal)
	local index = self._viewPager:getPage()
	local view = self._viewPager:getAdapter():getView(index)

	if view and view.playGuiAni then
		view:playGuiAni(animName, isNormal)
	end
end

function M:setPage(tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = orgIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		self:_updatePageData(orgIndex, tabIndex)
	end
end

function M:_updatePageData(orgIndex, tabIndex)
	self._tabComp:MoveSelectMark(tabIndex, 0)
end

function M:_refreshRedPoint()
	goutil.setActive(self._goRedPointTask, SeasonModel.instance:hasLvActive())
	goutil.setActive(goutil.findChild(self._goRedPointTask, "type1"), true)
	goutil.setActive(goutil.findChild(self._goRedPointTask, "type2"), false)
	goutil.setActive(goutil.findChild(self._goRedPointTask, "type3"), false)
	goutil.setActive(self._goRedPointLv, SeasonModel.instance:hasTaskActive() or SeasonModel.instance:hasTaskProgressActive())
	goutil.setActive(goutil.findChild(self._goRedPointLv, "type1"), true)
	goutil.setActive(goutil.findChild(self._goRedPointLv, "type2"), false)
	goutil.setActive(goutil.findChild(self._goRedPointLv, "type3"), false)
end

function M:_refreshActivityOpen()
	if SeasonFacade.instance:isSeasonOpen() then
		self._tabComp:setLock(1, false, true, true)
		self._tabComp:setLock(2, false, true, true)
	else
		self._tabComp:setLock(1, true, true, true)
		self._tabComp:setLock(2, true, true, true)
	end
end

function M:_onSeasonInfoUpdate()
	self:_refreshRedPoint()
end

return M
