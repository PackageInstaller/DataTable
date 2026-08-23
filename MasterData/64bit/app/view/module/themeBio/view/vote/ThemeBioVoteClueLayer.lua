local var_0_0 = g.core.config.theme_biography_item_info
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.ThemeBioConst
local var_0_3 = 8
local var_0_4 = {
	nil,
	nil,
	nil,
	nil,
	3,
	1,
	nil,
	2
}
local var_0_5 = g.core.common.Goods
local var_0_6 = g.core.model.User.bagData
local var_0_7 = g.core.model.User.themeData
local var_0_8 = g.core.const.ConstMgr.ThemeConst
local ThemeBioVoteClueLayer = class("ThemeBioVoteClueLayer", require("app.fairyGUI.themeBio.UI_ThemeBioVoteClueLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/themeBio/themeBio",
		resName = "ThemeBioVoteClueLayer",
		pkgName = "themeBio"
	}, ...)
end)

function ThemeBioVoteClueLayer:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._activeThemeValue = arg_2_1.themeValue
	self._chapterId = arg_2_1.chapterId
	self._curSelIndex = 0
	self._tabCompList = {}
	self._selectedTabIndex = self.m_tabController:getSelectedIndex()

	for iter_2_0 = 1, 3 do
		if self["m_tabComp" .. iter_2_0] then
			self._tabCompList[#self._tabCompList + 1] = self["m_tabComp" .. iter_2_0]

			self["m_tabComp" .. iter_2_0]:addClickListener(handler(self, function()
				self:_onClickTabComp(iter_2_0, true)
			end))
		end
	end

	self._clueList = {}

	for iter_2_1 = 1, 3 do
		self._clueList[iter_2_1] = self._clueList[iter_2_1] or {}

		for iter_2_2 = 1, var_0_3 do
			if self["m_clueComp_" .. iter_2_1 .. "_" .. iter_2_2] then
				self._clueList[iter_2_1][iter_2_2] = self["m_clueComp_" .. iter_2_1 .. "_" .. iter_2_2]
			end
		end
	end

	self:_initData()
	self:_initView()
	self:addBg("bg/theme/bg_hd_dance_xiansuo.jpg")
	self.m_topBar:setResInfoById(236)
end

function ThemeBioVoteClueLayer:_initData()
	self._themeBioData = var_0_7:getThemeData(self._activeThemeValue):getThemeBioData()
	self._chapterInfos = {}
	self._chapterIds = self._themeBioData:getChapterIds()
	self._chapterIdxMap = {}

	for iter_4_0 = 1, #self._chapterIds do
		self._chapterIdxMap[self._chapterIds[iter_4_0]] = iter_4_0
	end

	self._chapterModelMap = {}

	if self._themeBioData then
		for iter_4_1 = 1, #self._chapterIds do
			if self._chapterIds[iter_4_1] > 0 then
				local var_4_0 = self._themeBioData:getChapter(self._chapterIds[iter_4_1])

				if var_4_0 then
					self._chapterInfos[#self._chapterInfos + 1] = var_4_0
				end
			end
		end
	end

	self:_initClueData()
end

function ThemeBioVoteClueLayer:_initView()
	for iter_5_0, iter_5_1 in ipairs(self._tabCompList) do
		local var_5_0 = self._chapterInfos[iter_5_0]

		if self._chapterInfos[iter_5_0] then
			iter_5_1:setTitle(var_5_0.name)

			local var_5_1, var_5_2, var_5_3 = self._themeBioData:getChapterUnlockStateAndTip(var_5_0)
			local var_5_4 = var_5_1 == var_0_1.ThemeBioConst.BIO_CHAPTER_UNLOCK

			iter_5_1:setCtrlState("open", {
				index = var_5_1 == var_0_1.ThemeBioConst.BIO_CHAPTER_UNLOCK and 1 or 0
			})

			if var_5_0.id == self._chapterId then
				iter_5_1:setCtrlState("icon", {
					index = 2
				})
				self.m_tabController:setSelectedIndex(iter_5_0)
			else
				iter_5_1:setCtrlState("icon", {
					index = var_5_4 and 1 or 0
				})
			end
		end
	end

	self._selectedTabIndex = self.m_tabController:getSelectedIndex()

	self:_onClickTabComp(self._selectedTabIndex)
	self:_refreshRedPoint()
end

function ThemeBioVoteClueLayer:_refreshRedPoint()
	for iter_6_0, iter_6_1 in ipairs(self._tabCompList) do
		if self._chapterInfos[iter_6_0] then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = iter_6_1:getChild("redPointComp"),
				customData = {
					themeValue = self._activeThemeValue,
					chapterId = self._chapterInfos[iter_6_0].id
				}
			})
		end
	end
end

function ThemeBioVoteClueLayer:_refreshTabRedPoint()
	for iter_7_0, iter_7_1 in ipairs(self._tabCompList) do
		if self._chapterInfos[iter_7_0] then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = iter_7_1:getChild("redPointComp"),
				customData = {
					themeValue = self._activeThemeValue,
					chapterId = self._chapterInfos[iter_7_0].id
				}
			})
		end
	end
end

function ThemeBioVoteClueLayer:_updateAllClue(arg_8_1)
	local var_8_0 = self.m_clueController:getSelectedIndex()

	for iter_8_0 = 1, #self._clueList[var_8_0] do
		self._clueData[self._selectedTabIndex] = self._clueData[self._selectedTabIndex] or {}

		if self._clueList[var_8_0][iter_8_0] and self._clueData[self._selectedTabIndex][iter_8_0] then
			self._clueList[var_8_0][iter_8_0]:updateClue(self._clueData[self._selectedTabIndex][iter_8_0], self._activeThemeValue)

			if var_0_6:isOwnItem(var_0_5.TYPE_THEME_BIO_ITEM, self._clueData[self._selectedTabIndex][iter_8_0].id) and arg_8_1 then
				self._clueList[var_8_0][iter_8_0]:refreshRedPoint()

				if self._themeBioData:judgeBioChapterRecordByType(self._clueData[self._selectedTabIndex][iter_8_0].id, "_CLUE_UNLOCK") then
					self._themeBioData:setBioChapterRecordByType(self._clueData[self._selectedTabIndex][iter_8_0].id, "_CLUE_UNLOCK")
					self._clueList[var_8_0][iter_8_0]:playClueUnlockEffect()
				end

				if self._themeBioData:judgeBioChapterRecordByType(self._clueData[self._selectedTabIndex][iter_8_0].id, "_NEW_ITEM") then
					self._themeBioData:setBioChapterRecordByType(self._clueData[self._selectedTabIndex][iter_8_0].id, "_NEW_ITEM")
				end
			end
		end
	end
end

function ThemeBioVoteClueLayer:_initClueData()
	self._clueData = {}

	for iter_9_0, iter_9_1 in var_0_0.ipairs() do
		if self._chapterIdxMap[iter_9_1.chapter_id] and iter_9_1.num > 0 then
			self._clueData[self._chapterIdxMap[iter_9_1.chapter_id]] = self._clueData[self._chapterIdxMap[iter_9_1.chapter_id]] or {}
			self._clueData[self._chapterIdxMap[iter_9_1.chapter_id]][#self._clueData[self._chapterIdxMap[iter_9_1.chapter_id]] + 1] = iter_9_1
		end
	end

	for iter_9_2 = 1, #self._clueData do
		if self._clueData[iter_9_2] then
			self._chapterModelMap[iter_9_2] = var_0_4[#self._clueData[iter_9_2]]
		end
	end
end

function ThemeBioVoteClueLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	self.m_enterTransition:play(handler(self, self._onEnterAnimEnd))
end

function ThemeBioVoteClueLayer:_onCrossDayUpdate()
	local var_11_1 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(var_0_8.THEME_TYPE, self._themeValue)

	if not ((var_11_1 and var_11_1:isOpen() or nil) and true) then
		g.core.module.ModuleManager:popToRoot()

		return
	end
end

function ThemeBioVoteClueLayer:_onEnterAnimEnd()
	self:_onClickTabComp(self._selectedTabIndex, true)
end

function ThemeBioVoteClueLayer:_showClueInfo(arg_13_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.themeBio.view.vote.pop.ThemeBioVoteClueDetailPop").new({
		info = arg_13_1
	}), {
		hideContinue = false,
		touchDisappear = true,
		withoutAni = false
	})
end

function ThemeBioVoteClueLayer:receiveCompEvent(arg_14_1, arg_14_2)
	arg_14_2 = arg_14_2 or {}

	if arg_14_1 == "ThemeBioVoteClueComp_onClickClue" then
		if arg_14_2.info then
			self:_showClueInfo(arg_14_2.info)
		end
	end
end

function ThemeBioVoteClueLayer:onUnload()
	self.m_backTransition:play()
end

function ThemeBioVoteClueLayer:_onClickTabComp(arg_16_1, arg_16_2)
	local var_16_0 = self.m_tabController:getSelectedIndex()

	if arg_16_2 then
		self:_refreshTabRedPoint()
	end

	if self._chapterInfos[arg_16_1] then
		local var_16_1, var_16_2, var_16_3 = self._themeBioData:getChapterUnlockStateAndTip(self._chapterInfos[arg_16_1])

		if var_16_1 == var_0_2.BIO_CHAPTER_UNLOCK then
			if self._tabCompList[self._selectedTabIndex] then
				self._tabCompList[self._selectedTabIndex]:setCtrlState("icon", {
					index = 1
				})
			end

			if self._tabCompList[var_16_0] then
				self._tabCompList[var_16_0]:setCtrlState("icon", {
					index = 2
				})
			end

			self._selectedTabIndex = var_16_0

			self.m_clueController:setSelectedIndex(self._chapterModelMap[arg_16_1])
			self:_updateAllClue(arg_16_2)
		else
			g.core.module.ModuleManager:tip(var_16_3)
			self.m_tabController:setSelectedIndex(self._selectedTabIndex)
		end
	end
end

return ThemeBioVoteClueLayer
