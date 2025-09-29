-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/WelfareMainView.lua

module("logic.extensions.welfare.view.WelfareMainView", package.seeall)

local M = class("WelfareMainView", ViewComponent)
local CamCode_TV = 14
local CamEnterTime = 0.5

function M:ctor()
	M.super.ctor(self)

	self._allActMO = {}
	self._curPageTabId = nil
	self._tabIdList = {}
	self._isNormalClose = true
end

function M:buildUI()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Wekfare)

	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._btnReturn1 = self:getBtn("1&title_view_-878360263")
	self._btnHome = self:getBtn("1&title_view_1398742689")
	self.btn_btnActivityTips = self:getBtn("wekfare_main_view_copy_1317878687")
	self._rectViewRoot = self:getRectTransform("wekfare_main_view_copy_-1095131565")
	self._viewPager = ViewPager.New(self._rectViewRoot.gameObject)

	self._viewPager:setViewPresentor(self._viewPresentor)
	self._viewPager:setPageChangeCallBack(self._onPageChanged, self)

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setTabCheckFunc(function(tabIndex)
		self:_sendBuryPoint(tabIndex)

		return self:_tabCheckFunc(tabIndex)
	end)

	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("0&left_tab_list_-1767715410"), LeftTabListComp)
end

function M:destroyUI()
	if self._toggleTabControl then
		self._toggleTabControl:destroy()
	end

	self._toggleTabControl = nil

	if self._viewPager then
		self._viewPager:destroy()
	end

	self._viewPager = nil
	self._allActMO = nil
	self._curPageTabId = nil
	self._tabIdList = nil
	self._isNormalClose = nil

	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Wekfare)
end

function M:bindEvents()
	self._btnReturn1:AddClickListener(self._onClickBack, self)
	self.btn_btnActivityTips:AddClickListener(self._onClickTips, self)
	self._btnHome:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnReturn1:RemoveClickListener()
	self.btn_btnActivityTips:RemoveClickListener()
	self._btnHome:RemoveClickListener()
end

function M:onEnter(reasonTyp)
	local scene = SceneMgr.instance:getCurScene()
	local isRoomScene = scene and scene:getSceneType() == SceneType.Room
	local quickCloseType = reasonTyp == WindowType.WindowCloseReasonType.QuickCloseType

	self:_updateEnter()
end

function M:_enterAnimCompeled()
	goutil.setActive(self.mainGO, true)
	self._viewPresentor:playEnterAnimation()
	self:_updateEnter()
end

function M:_updateEnter()
	self:_setEvent(true)
	self._tabComp:onEnter()
	self:refreshData()
	self:refreshEntryTab(self._curPageTabId)
end

function M:onExit(reasonTyp)
	self:_setEvent(false)
	self._tabComp:onExit()
end

function M:onExitFinished()
	if self._isNormalClose then
		-- block empty
	end
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_MAIN_SCENE_JUMP_MAIN_VIEW_BLACK_FADE_IN, self._handleMainSceneJumpMainViewBlackFadeIn, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_MAIN_SCENE_JUMP_MAIN_VIEW_BLACK_FADE_IN, self._handleMainSceneJumpMainViewBlackFadeIn, self)
	end
end

function M:_handleMainSceneJumpMainViewBlackFadeIn()
	self:close()
end

function M:_tabCheckFunc(tabIndex)
	return true
end

function M:_onPageChanged(index)
	self._curPageTabId = self._tabIdList[index]

	local tipId = WelfareConfig.instance:getTabTipsId(self._curPageTabId)
	local guideImgCfg = GuideConfig.instance:getGuideFullScreenCfg(tipId)

	goutil.setActive(self.btn_btnActivityTips.gameObject, guideImgCfg ~= nil)
end

function M:_onClickBack()
	self:back()
end

function M:_onClickClose()
	local mainViewOpen = ViewMgr.instance:isOpen(ViewName.MainUIView)

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)

	if not mainViewOpen then
		self:close()
	end
end

function M:_onClickTips()
	local tipId = WelfareConfig.instance:getTabTipsId(self._curPageTabId)
	local guideImgCfg = GuideConfig.instance:getGuideFullScreenCfg(tipId)

	if not guideImgCfg or not guideImgCfg.param then
		return
	end

	ViewMgr.instance:open(ViewName.ImageGuide, {
		tipId
	})
end

function M:_onClickHome()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:refreshData()
	local info = self:getFirstParam() or {}

	if self._viewPresentor:getIsBackOpen() then
		self._curPageTabId = self._curPageTabId or info.tabId or nil
	else
		self._curPageTabId = info.tabId or nil
	end

	table.clear(self._tabIdList)

	local actMOLst = ActivityModel.instance:getActivityDataList()

	for index, actMO in ipairs(actMOLst or {}) do
		local logicType = actMO:getType()
		local planId = actMO:getConfigId()
		local tabId = WelfareConfig.instance:getActivityTabId(logicType, planId)

		if tabId and WelfareUtil.isShowActivity(actMO) then
			table.insert(self._tabIdList, tabId)
		end
	end

	self._tabIdList = table.unique(self._tabIdList, true)

	WelfareUtil.sortActivityById(self._tabIdList)
end

function M:refreshEntryTab(oldTabId)
	self._viewPager:clear()

	local adapter = DynamicPagerAdapter.New()

	self._viewPager:setAdapter(adapter)
	self._toggleTabControl:clear()
	self._toggleTabControl:setViewPager(self._viewPager)
	self._tabComp:resetTabList()

	local tabIndex = 1

	for i = 1, #self._tabIdList do
		local tabId = self._tabIdList[i]
		local tabCfg = WelfareConfig.instance:getActivityTabCfg(tabId)

		self:_createActivityTab(tabId)

		local className = tabCfg and tabCfg.program or ""

		adapter:registerView(tabCfg.preform, _G[className], tabId)

		if oldTabId and oldTabId == tabId then
			tabIndex = i
		end
	end

	if #self._tabIdList > 0 then
		self._toggleTabControl:selectTab(tabIndex)
	end
end

function M:_createActivityTab(tabId)
	local tabCfg = WelfareConfig.instance:getActivityTabCfg(tabId)
	local activityList = WelfareUtil.getActivityListByTabId(tabId)

	if not tabCfg or not activityList then
		return
	end

	local redDotKeyList = {}

	for _, activityData in ipairs(activityList) do
		local actRedDotKey = WelfareUtil.getActivityRedPointKey(activityData:getId(), true)
		local actTaskRedDotKey = WelfareUtil.getActivityRedPointKey(activityData:getId(), false)

		table.insert(redDotKeyList, actRedDotKey)
		table.insert(redDotKeyList, actTaskRedDotKey)
	end

	local tabCell = self._tabComp:createTabCell(LeftTabListCellMO.New({
		tabName = tabCfg.name,
		tabIcon = tabCfg.tabIcon,
		iconType = IconType.activityTabIcon,
		redDotKeyList = redDotKeyList
	}))

	self._toggleTabControl:addToggleTab(tabCell:getToggleTab())
end

function M:_sendBuryPoint(tabIndex)
	local now = os.clock()

	if self._lastTime and now - self._lastTime < 0.05 then
		return
	end

	self._lastTime = now

	local toggle = self._toggleTabControl:getTab(tabIndex)

	if not toggle then
		return
	end

	local txtTitle = goutil.findChildTextComponent(toggle.gameObject, "select/layout/txtTitle")

	if not txtTitle then
		return
	end

	UserUtil.activitySecondTabName = txtTitle.text

	UserUtil.uploadActivityTabBuryPoint("", txtTitle.text, "")
end

return M
