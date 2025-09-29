-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/PlayerInfoMainView.lua

module("logic.extensions.playerinfo.view.PlayerInfoMainView", package.seeall)

local M = class("PlayerInfoMainView", ViewComponent)

M.SubViewType = {
	IllustratedBook = 5,
	Player = 1,
	Course = 3,
	Monument = 4,
	Achievement = 2
}

local KSystemOpenList = {
	GameEnum.SystemEnum.DisplayCard,
	GameEnum.SystemEnum.Achievement,
	GameEnum.SystemEnum.PlayerDisplay,
	GameEnum.SystemEnum.Cup,
	GameEnum.SystemEnum.Gallery
}
local kViewUrls = {
	ResName.Playerinfo_panel,
	ResName.Playerinfo_achievement_list_panel,
	ResName.Playerinfo_course_panel,
	ResName.Playerinfo_syndrome_card_panel,
	ResName.Playerinfo_handbook_panel
}
local kViewClass = {
	PlayerInfoBaseFragmentView,
	AchievementSkillFragmentView,
	PlayerCourseFragmentView,
	MonumentFragmentView,
	HandbookEntryFragmentView
}

function M:ctor()
	self._viewPager = false
	self._toggleTabControl = false
	self._guideCode = false
end

function M:buildUI()
	local panelGo = goutil.findChild(self.mainGO, "panel")

	self._viewPager = ViewPager.New(panelGo)
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._btnReturn = self:getBtn("0&title_view_-878360263")
	self._btnHome = self:getBtn("0&title_view_1398742689")

	goutil.setActive(self._btnHome.gameObject, false)

	self._btnExplain = self:getBtn("0&title_view_-636449388")
	self._txtTitle = self:getText("0&title_view_-788888785")
	self._goTitleView = self:getGo("0&title_view_-478490097")
	self._leftTabGo = self:getGo("8&left_tab_content_-399612422")
	self._tabComp = Astral.LuaComponentContainer.Add(self._leftTabGo, LeftTabComp)

	self._tabComp:setRedPointTypeStrong()
	self._tabComp:setRedPointWeaklyByIndex(1)
	self._tabComp:setRedPointWeaklyByIndex(4)

	self._tabCanvasGroup = goutil.addComponentOnce(self._leftTabGo, ComponentType.CanvasGroup)
	self._titleCanvasGroup = goutil.addComponentOnce(self._goTitleView, ComponentType.CanvasGroup)
	self._statusRedPoint = self:getGo("8&1&red_point_-1414002736")

	self:_buildRedDot()
	self:_bindRedDot(true)
end

function M:_buildRedDot()
	self._redDotComp = {}

	table.insert(self._redDotComp, {
		dotNode = self:getGo("8&2&red_point_-1414002736"),
		keyList = {
			GameEnum.RedPointEnum.Achievement
		}
	})
	table.insert(self._redDotComp, {
		dotNode = self:getGo("8&3&red_point_-1414002736"),
		keyList = {
			GameEnum.RedPointEnum.MainlineDiary
		}
	})
	table.insert(self._redDotComp, {
		dotNode = self:getGo("8&4&red_point_-1414002736"),
		keyList = {
			GameEnum.RedPointEnum.Cup
		}
	})
	table.insert(self._redDotComp, {
		dotNode = self:getGo("8&1&red_point_-1414002736"),
		keyList = {
			GameEnum.RedPointEnum.PlayerCardAttribute
		}
	})
end

function M:_bindRedDot(bind)
	if bind then
		for _, data in ipairs(self._redDotComp) do
			RedDotModel.instance:createDotView({
				dotNode = data.dotNode,
				keyList = data.keyList
			})
		end
	else
		for _, data in ipairs(self._redDotComp) do
			RedDotModel.instance:createDotView({
				dotNode = data.dotNode,
				keyList = {}
			})
		end
	end
end

function M:bindTagGroup()
	self._toggleTabControl:clear()
	self._toggleTabControl:setViewPager(self._viewPager)

	if self._isSelf then
		local finished = MonumentModel.instance:getFinishedMonuments()

		if #finished > 0 then
			self._tabComp:setActiveTabIndexLst({
				1,
				2,
				3,
				4,
				5
			})
			self._tabComp:setSystemOpenLst(M.kSystemOpenEnumList)
		else
			self._tabComp:setActiveTabIndexLst({
				1,
				2,
				3,
				5
			})
			self._tabComp:setSystemOpenLst(M.kSystemOpenEnumList)
		end

		for i = 1, 5 do
			local tab = self._tabComp:getToggleTab(i)

			if tab then
				self._toggleTabControl:addToggleTab(tab)
			end
		end

		local isopen = SystemOpenFacade.instance:isOpen(KSystemOpenList[M.SubViewType.Course], false)

		self._tabComp:setLock(M.SubViewType.Course, isopen)
	else
		self._tabComp:setActiveTabIndexLst({
			1,
			3
		})
		self._tabComp:setSystemOpenLst(M.kSystemOpenEnumList)

		for i = 1, 3 do
			local tab = self._tabComp:getToggleTab(i)

			if tab then
				self._toggleTabControl:addToggleTab(tab)
			end
		end
	end

	for i = 1, 5 do
		local tab = self._tabComp:getToggleTab(i)

		if tab then
			local isopen = SystemOpenFacade.instance:isOpen(KSystemOpenList[i], false)
			local online = SystemOpenModel.instance:getSystemIsOnline(KSystemOpenList[i], true)
			local showOnLock = SystemOpenFacade.instance:isShowOnLock(KSystemOpenList[i])

			self._tabComp:setLock(i, not isopen, online, showOnLock)

			if M.SubViewType.Monument == i then
				local finished = MonumentModel.instance:getFinishedMonuments()

				self._tabComp:setLock(i, #finished == 0 or not isopen, online, false)
			end
		end
	end
end

function M:bindEvents()
	self._viewPager:setPageChangeCallBack(self._onPageChanged, self)
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnExplain:AddClickListener(self._onClickExplain, self)
	GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_UI_MODEL, self._onChangePlayerUI, self)
	GlobalDispatcher:addEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self._handleHandbookUnreadInfoChange, self)
	GlobalDispatcher:addEventListener(EventType.PLAYER_MAINVIEW_ANI, self._playAni, self)
	GlobalDispatcher:addEventListener(EventType.UPDATA_MONUMENT, self.bindTagGroup, self)
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._updateRedPoint, self)
	GlobalDispatcher:addEventListener(EventType.PLAYER_ATTR_OPEN_CLOSE, self._onHandleAttrPanel, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_UI_MODEL, self._onChangePlayerUI, self)
	GlobalDispatcher:removeEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self._handleHandbookUnreadInfoChange, self)
	GlobalDispatcher:removeEventListener(EventType.PLAYER_MAINVIEW_ANI, self._playAni, self)
	GlobalDispatcher:removeEventListener(EventType.UPDATA_MONUMENT, self.bindTagGroup, self)
	GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._updateRedPoint, self)
	GlobalDispatcher:removeEventListener(EventType.PLAYER_ATTR_OPEN_CLOSE, self._onHandleAttrPanel, self)
end

function M:onEnter()
	GlobalDispatcher:dispatchEvent(EventType.PLAYER_INFO_MAIN_OPEN)

	self._isBase = true

	local params = self:getFirstParam() or {}
	local index = params.index

	self._isSelf = params.isSelf or false

	if Astral.OSDef.isEditor then
		TableUtil.dump(params)
	end

	if params.index == nil then
		local viewInfo = GalleryModel.instance:getPlayerInfoViewMsg()

		index = viewInfo.playerInfoMain.index
		self._isSelf = viewInfo.playerInfoMain.isSelf
	else
		if self._curPageIndex then
			index = self._curPageIndex
		end

		local viewInfo = GalleryModel.instance:getPlayerInfoViewMsg()

		viewInfo.playerInfoMain = {
			index = index,
			isSelf = self._isSelf
		}

		GalleryModel.instance:setPlayerInfoViewMsg(viewInfo)
	end

	local adapter = DynamicPagerAdapter.New()

	if self._isSelf then
		for index, _ in ipairs(kViewUrls) do
			adapter:registerView(kViewUrls[index], kViewClass[index])
		end
	else
		adapter:registerView(kViewUrls[M.SubViewType.Player], kViewClass[M.SubViewType.Player])
		adapter:registerView(kViewUrls[M.SubViewType.Course], kViewClass[M.SubViewType.Course])
	end

	self._viewPager:setViewPresentor(self._viewPresentor)
	self._viewPager:setAdapter(adapter)

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setTabCheckFunc(self._tabEntryCheckFunc)
	self._toggleTabControl:setViewPager(self._viewPager)
	self:bindTagGroup()
	self:_bindRedDot(self._isSelf)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_ResourcesExplore)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Task)
	self._toggleTabControl:selectTab(index)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
	self._tabComp:setCanvasGroupShow(true)
	self._tabComp:onEnter()
	self._tabComp:playGuiAniTab(true, not self._viewPresentor:getIsBackOpen(), index)
	self:_updateRedPoint()
end

function M:onExit(reasonTyp)
	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	self._viewPager:clear()
	self._tabComp:onExit()
	self._tabComp:playGuiAniTab(false, isNormalClose)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Task)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")
end

function M:destroyUI()
	self._redDotComp = nil

	self._viewPager:destroy()
	GlobalDispatcher:dispatchEvent(EventType.PLAYER_INFO_MAIN_DESTROY)
end

function M:refreshRightTabRedPoint()
	for keyStr, valTypInt in pairs(self.SubViewType) do
		local redPointNum = self:_getRedPointNum(valTypInt)
	end
end

function M:_playAni(_, name)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName(name)
end

function M._tabEntryCheckFunc(index)
	if KSystemOpenList[index] then
		return SystemOpenFacade.instance:isOpen(KSystemOpenList[index], true)
	end

	return true
end

function M:_onPageChanged(index)
	local samePage = self._curPageIndex == index
	local duration = samePage and 0 or 0.3

	duration = self._curPageIndex and math.abs(self._curPageIndex - index) <= 1 and 0.2 or duration
	self._curPageIndex = index

	self._tabComp:MoveSelectMark(index, duration)

	local viewInfo = GalleryModel.instance:getPlayerInfoViewMsg()

	viewInfo.playerInfoMain.index = index

	GalleryModel.instance:setPlayerInfoViewMsg(viewInfo)

	if self._curPageIndex == M.SubViewType.Player then
		goutil.setActive(self._btnExplain.gameObject, true)

		self._guideCode = CommEnum.GuideID.PlayerMain
	elseif self._curPageIndex == M.SubViewType.Achievement then
		goutil.setActive(self._btnExplain.gameObject, true)

		self._guideCode = CommEnum.GuideID.PlayerAchievement
	else
		goutil.setActive(self._btnExplain.gameObject, false)
	end
end

function M:_onClickReturn()
	if self._isBase then
		self:back()
	else
		GlobalDispatcher:dispatchEvent(EventType.HIDE_PLAYER_DISPLAYCARD)
		self:_onChangePlayerUI(nil, true)
	end
end

function M:_onClickHome()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_onChangePlayerUI(key, isBase)
	self._isBase = isBase

	self:_onChangeTitle(isBase)
end

function M:_onChangeTitle(isBase)
	if isBase then
		self._txtTitle.text = "信息"
	else
		self._txtTitle.text = "玩家信息"
	end
end

function M:_handleHandbookUnreadInfoChange(e)
	local redPoint_Gallery = self:_getRedPointNum(self.SubViewType.IllustratedBook)
end

function M:_getRedPointNum(subPageTyp)
	local redPointNum = 0

	if subPageTyp == self.SubViewType.Player then
		-- block empty
	elseif subPageTyp == self.SubViewType.Achievement then
		-- block empty
	elseif subPageTyp == self.SubViewType.Course then
		-- block empty
	elseif subPageTyp == self.SubViewType.Monument then
		-- block empty
	elseif subPageTyp == self.SubViewType.IllustratedBook then
		for keyStr, valTypInt in pairs(HandbookConfig.instance:getAllUnlockTyp()) do
			redPointNum = redPointNum + GalleryModel.instance:getTypUnReadCount(valTypInt)
		end
	end

	return redPointNum
end

function M:_updateRedPoint()
	return
end

function M:_reqCourseData()
	local userId = PlayerCourseModel.instance:getCourseUserId()

	if userId then
		PlayerCourseAgent.instance:sendGetPlayerDisplayInfoRequest(userId)
	end
end

function M:_onHandleAttrPanel(e, param)
	local isOpen = param
	local value = isOpen and 0 or 1

	self._tabCanvasGroup.alpha = isOpen and 1 or 0
	self._titleCanvasGroup.alpha = isOpen and 1 or 0

	goutil.setActive(self._goTitleView, true)
	goutil.setActive(self._leftTabGo, true)
	self._tabCanvasGroup:DOKill(false)
	self._titleCanvasGroup:DOKill(false)
	self._tabCanvasGroup:DOFade(value, 0.5)
	self._titleCanvasGroup:DOFade(value, 0.5)
	settimer(0.5, function()
		goutil.setActive(self._goTitleView, not isOpen)
		goutil.setActive(self._leftTabGo, not isOpen)
	end, self, false)
end

function M:_onClickExplain()
	if self._guideCode then
		ViewMgr.instance:open(ViewName.ImageGuide, {
			self._guideCode
		})
	end
end

return M
