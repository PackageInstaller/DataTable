-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/AirWorkShopDynMsgView.lua

module("logic.extensions.airworkshop.view.AirWorkShopDynMsgView", package.seeall)

local M = class("AirWorkShopDynMsgView", ViewComponent)

M.SubViewType = {
	Msg = 1,
	Defence = 3,
	Like = 2
}
M.Page2MapNewType = {
	[M.SubViewType.Msg] = GameEnum.AirMapNewsEnum.Comment,
	[M.SubViewType.Like] = GameEnum.AirMapNewsEnum.Like,
	[M.SubViewType.Defence] = GameEnum.AirMapNewsEnum.Defence
}

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._tabComp = Astral.LuaComponentContainer.Add(goutil.findChild(self.mainGO, "left_tab_content"), LeftTabComp)

	self._tabComp:setRedPointTypeWeakly()

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:addToggleTab(goutil.findChildComponent(self.mainGO, "left_tab_content/rightTabList/tab_1", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(goutil.findChildComponent(self.mainGO, "left_tab_content/rightTabList/tab_2", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(goutil.findChildComponent(self.mainGO, "left_tab_content/rightTabList/tab_3", UIComponentType.SpaceXToggle))

	self._redPointMap = {
		[M.SubViewType.Msg] = goutil.findChild(self.mainGO, "left_tab_content/rightTabList/tab_1/red_point"),
		[M.SubViewType.Like] = goutil.findChild(self.mainGO, "left_tab_content/rightTabList/tab_2/red_point"),
		[M.SubViewType.Defence] = goutil.findChild(self.mainGO, "left_tab_content/rightTabList/tab_3/red_point")
	}
	self._txtHint = self:getUIComponent("air_workshop_dynamics_view_1941603421", UIComponentType.Text)
	self._goEmpty = self:getGo("air_workshop_dynamics_view_-1933579750")
	self._scroll = self:getUIComponent("air_workshop_dynamics_view_-126413411", UIComponentType.ScrollRect)
	self._loopList = LoopListHelper.New(self._scroll.gameObject)

	self._loopList:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._toggleTabControl:destroy()

	self._toggleTabControl = nil

	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter(reasonTyp)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Battle)

	local isNormal = not self._viewPresentor:getIsBackOpen() and reasonTyp ~= WindowType.WindowOpenReasonType.QuickOpenType

	self._isEnter = true
	self._canvasGroup.interactable = true

	self:setEvent(true)

	if self._activeIndex then
		self._defualtTabIndex = self._activeIndex
	else
		self._defualtTabIndex = M.SubViewType.Msg
	end

	self:_refreshRedDot()
	self._toggleTabControl:selectTab(self._defualtTabIndex)
	self._tabComp:setCanvasGroupShow(true)
	self._tabComp:onEnter()
	self._tabComp:playGuiAniTab(true, isNormal, self._defualtTabIndex)

	if not isNormal then
		local mapNewType = M.Page2MapNewType[self._defualtTabIndex]

		AirWorkShopDefAgent.instance:sendGetAirMapNewsRequest({
			mapNewType
		})
	end
end

function M:onExit(reasonTyp)
	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	self._isEnter = false
	self._canvasGroup.interactable = false

	self:setEvent(false)
	self._tabComp:onExit()
	self._tabComp:setCanvasInteractable(false)
	self._tabComp:playGuiAniTab(false, isNormalClose)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Battle)

	if isNormalClose then
		self._activeIndex = nil
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
		GlobalDispatcher:addEventListener(EventType.AIRWORKSHOP_MANAGER_EXIT, self._handleManagerViewExit, self)
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_GET_AIR_MAP_NEWS_REPLY, self._handleOnGetAirMapNewsReply, self)
	else
		GlobalDispatcher:removeEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
		GlobalDispatcher:removeEventListener(EventType.AIRWORKSHOP_MANAGER_EXIT, self._handleManagerViewExit, self)
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_GET_AIR_MAP_NEWS_REPLY, self._handleOnGetAirMapNewsReply, self)
	end
end

function M:_handleOnGetAirMapNewsReply(e, newsList)
	if not self._isEnter then
		return
	end

	local mapNewType = M.Page2MapNewType[self._activeIndex]
	local list = AirWorkShopModel.instance:getAirMapNews(mapNewType)

	self:refreshList(list, true)

	for _pageType, _go in pairs(self._redPointMap or {}) do
		local isActive = AirWorkShopModel.instance:getAirMapNewsCountByType(M.Page2MapNewType[_pageType]) > 0

		goutil.setActive(_go, isActive)
	end
end

function M:_handleManagerViewExit(e)
	if not self._isEnter then
		return
	end

	AirWorkShopDefAgent.instance:sendGetAllAirMapNewsReq()
end

function M:_refreshRedDot()
	if not self._isEnter then
		return
	end

	for _pageType, _go in pairs(self._redPointMap or {}) do
		local isActive = self:_getRedDotActive(_pageType)

		goutil.setActive(_go, isActive)
	end
end

function M:_getRedDotActive(pageType)
	local mapNewType = M.Page2MapNewType[pageType]
	local isActive = false
	local redPointLstFromServer = RedDotModel.instance:getRedDotDetailList(GameEnum.RedPointEnum.AirMapNews) or {}

	for _, idStr in ipairs(redPointLstFromServer) do
		if not isActive and tonumber(idStr) == mapNewType then
			isActive = true
		end
	end

	return isActive
end

function M:setPage(tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = orgIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		local mapNewType = M.Page2MapNewType[tabIndex]

		AirWorkShopDefAgent.instance:sendGetAirMapNewsRequest({
			mapNewType
		})

		if self:_getRedDotActive(tabIndex) then
			AirWorkShopDefAgent.instance:sendReadMapNewsRequest({
				mapNewType
			})
		end
	end

	local duration = needReflash and 0.3 or 0

	self._tabComp:MoveSelectMark(tabIndex, duration)
end

function M:refreshList(listAirMapNews, resetPos)
	self._listAirMapNews = listAirMapNews

	local len = listAirMapNews and #listAirMapNews or 0

	if len > 0 then
		if resetPos then
			self._loopList:ClearCells()
		end

		self._loopList:SetListItemCount(len, resetPos)
		self._loopList:RefreshAllShownItem()
	else
		self._loopList:ClearCells()
	end

	goutil.setActive(self._goEmpty, len == 0)
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local mapNewType = M.Page2MapNewType[self._activeIndex]
	local data = self._listAirMapNews[curIndex]
	local dataMapNewType = data:getType()

	if dataMapNewType ~= mapNewType then
		printWarn("!!!!!!!!!!!!类型不匹配")
	end

	local prefabName = "air_workshop_dynamics_item"
	local item = self._loopList:NewListViewItem(prefabName)
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, AirWorkShopDynMsgCell)

	if dataMapNewType == GameEnum.AirMapNewsEnum.Comment then
		shower:updateDataMsg(data, dataMapNewType)
	elseif dataMapNewType == GameEnum.AirMapNewsEnum.Like then
		shower:updateDataLike(data, dataMapNewType)
	elseif dataMapNewType == GameEnum.AirMapNewsEnum.Defence then
		shower:updateDataDefence(data, dataMapNewType)
	end

	return item
end

return M
