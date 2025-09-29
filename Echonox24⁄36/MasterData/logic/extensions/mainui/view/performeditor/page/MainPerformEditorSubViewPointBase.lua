-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/page/MainPerformEditorSubViewPointBase.lua

module("logic.extensions.mainui.view.performeditor.page.MainPerformEditorSubViewPointBase", package.seeall)

local M = class("MainPerformEditorSubViewPointBase")
local PageTyp = {
	DropChange = 1,
	AnimFace = 7,
	PosData = 2,
	AnimChange = 5,
	AnimStep = 3,
	BgFormat = 6,
	AllCfg = 4
}
local PageName = {
	[PageTyp.DropChange] = "基础",
	[PageTyp.PosData] = "位置",
	[PageTyp.AnimStep] = "随机动作",
	[PageTyp.AllCfg] = "所有配置",
	[PageTyp.AnimChange] = "动作切换",
	[PageTyp.BgFormat] = "背景角色配置",
	[PageTyp.AnimFace] = "表情"
}

function M:ctor(mainGo)
	self.mainGO = mainGo
end

function M:init(viewRegistry)
	self._viewRegistry = viewRegistry

	self:buildUI()
	self:bindEvents()

	self._isInit = true
end

function M:Awake()
	return
end

function M:OnEnable()
	if not self._isInit then
		return
	end
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._viewRegistry
end

function M:buildUI()
	local registry = self:getRegistry()

	self._txtHeroStatus = registry:findUIElement("main_perform_editor_view_525766795", UIComponentType.Text)
	self._toggleMoveCamPoint = registry:findUIElement("main_perform_editor_view_-1811733250", UIComponentType.SpaceXToggle)
	self._compAniSelectTips = Astral.SimpleLuaComponentContainer.Add(registry:findUIElement("main_perform_editor_view_724597016"), MainPerformEditorAniSelectTipsComp)
	self._compCamSelectTips = Astral.SimpleLuaComponentContainer.Add(registry:findUIElement("main_perform_editor_view_-1380468098"), MainPerformEditorCamSelectTipsComp)
	self._page = {}
	self._page[PageTyp.DropChange] = Astral.SimpleLuaComponentContainer.Add(registry:findUIElement("main_perform_editor_view_380882038"), MainPerformEditorDropChangeComp)
	self._page[PageTyp.PosData] = Astral.SimpleLuaComponentContainer.Add(registry:findUIElement("main_perform_editor_view_1796277961"), MainPerformEditorPosInfoComp)
	self._page[PageTyp.AnimStep] = Astral.SimpleLuaComponentContainer.Add(registry:findUIElement("main_perform_editor_view_-977480984"), MainPerformEditorAniStepComp)
	self._page[PageTyp.AllCfg] = Astral.SimpleLuaComponentContainer.Add(registry:findUIElement("main_perform_editor_view_1726201471"), MainPerformEditorAllCfgComp)
	self._page[PageTyp.AnimChange] = Astral.SimpleLuaComponentContainer.Add(registry:findUIElement("main_perform_editor_view_-1701632720"), MainPerformEditorAnimChangeComp)
	self._page[PageTyp.BgFormat] = Astral.SimpleLuaComponentContainer.Add(registry:findUIElement("main_perform_editor_view_-1186176312"), MainPerformEditorBgFormatComp)
	self._page[PageTyp.AnimFace] = Astral.SimpleLuaComponentContainer.Add(registry:findUIElement("main_perform_editor_view_-1010560773"), MainPerformEditorFaceAniComp)

	for _pTyp, _p in pairs(self._page) do
		_p:setHandler(self)
	end

	local tabRootPoint = registry:findUIElement("main_perform_editor_view_-231540617", UIComponentType.RectTransform)

	self._tabPointViewPager = self:buildPointViewPager()
	self._toggleTabCtrlPoint = ToggleTabControl.New()

	self._toggleTabCtrlPoint:setViewPager(self._tabPointViewPager)
	self._toggleTabCtrlPoint:setTabCheckFunc(function(index)
		local isDataDirty = self:getActiveSubPageDirty(true)

		if isDataDirty then
			return false
		end

		return true
	end)

	for i = 0, tabRootPoint.childCount - 1 do
		self._toggleTabCtrlPoint:addToggleTab(tabRootPoint:GetChild(i):GetComponent(UIComponentType.SpaceXToggle))
	end

	local tabRoot = registry:findUIElement("main_perform_editor_view_-1481983889", UIComponentType.RectTransform)

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:setTabCheckFunc(function(index)
		return self:_subTabCheckFunc(index)
	end)

	for i = 0, tabRoot.childCount - 1 do
		self._toggleTabControl:addToggleTab(tabRoot:GetChild(i):GetComponent(UIComponentType.SpaceXToggle))
	end

	self._toggleMoveCamPoint.IsOn = false
end

function M:destroyUI()
	self:setHandler(nil)

	self.mainGO = nil
	self._viewRegistry = nil
	self._page = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
	self._tabPointViewPager = nil
end

function M:bindEvents()
	self._toggleMoveCamPoint:AddListener(self._onToggleMoveCamPoint, self)
end

function M:unbindEvents()
	self._toggleMoveCamPoint:RemoveListener()
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:onEnter()
	self:setEvent(true)

	for _pTyp, _p in pairs(self._page) do
		local tab = self._toggleTabControl:getTab(_pTyp)
		local show = _p:canShow()

		goutil.setActive(tab.gameObject, show)
	end

	local pointIndex = self._tabPointViewPager.getActiveIndex()

	self._toggleTabCtrlPoint:selectTab(pointIndex and pointIndex or 1)

	self._needCheckSaveState = true

	self:refreshView()
end

function M:onExit()
	self:setEvent(false)

	self._activeIndex = nil

	self._tabPointViewPager.setActiveIndex(nil)
end

function M:refreshView()
	self:resetData()

	if self._toggleMoveCamPoint.IsOn then
		self:_onToggleMoveCamPoint(nil, true)
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_SHOW_UP, self.handleMainSceneHeroShowUp, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_SHOW_UP, self.handleMainSceneHeroShowUp, self)
	end
end

function M:handleMainSceneHeroShowUp(e, point, heroId, unit, defaultAnimState)
	self:onEditHeroChange(heroId, unit)
end

function M:getActiveIndex()
	return self._activeIndex
end

function M:getActiveSubPageDirty(showToast)
	local toastStr
	local activeIndex = self:getActiveIndex()

	if activeIndex and activeIndex > 0 then
		local isDataDirty = self._page[activeIndex]:IsDataDirty()

		if isDataDirty then
			if showToast then
				FloatWordMgr.instance:show(string.format("交互点[%s]页签[%s][%s]尚未保存或重置", self:getPoint(), activeIndex, PageName[activeIndex]))
			end

			return true
		end
	end

	return false
end

function M:_subTabCheckFunc(index)
	local activeIndex = self:getActiveIndex()

	if activeIndex and activeIndex == index then
		return true
	end

	if self._needCheckSaveState then
		local isDataDirty = self:getActiveSubPageDirty(true)

		if isDataDirty then
			return false
		end
	end

	return true
end

function M:resetData()
	if not SceneFace.instance:isCurScene(SceneType.Room) then
		printWarn("非主场景，不响应操作")

		self._txtHeroStatus.text = "非主场景"

		return
	end

	local point = self:getPoint()
	local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)
	local heroId = unitHero and unitHero:getHeroId() or nil

	self:onEditHeroChange(heroId, unitHero)
end

function M:onEditHeroChange(heroId, unit)
	if unit then
		local modelId = unit:getModelId()
		local name = MainScenePerformUtil.getHeroName(heroId)
		local skinId = unit:getSkinId()

		if skinId > 0 then
			local cfgSkin = HeroSkinConfig.instance:getInfo(skinId)

			if cfgSkin then
				name = string.format("%s-%s", name, cfgSkin.name)
			end
		end

		self._txtHeroStatus.text = string.format("%s %s", modelId, name)
	else
		self._txtHeroStatus.text = "没有角色"
	end

	for _pTyp, _p in pairs(self._page) do
		if _p:canShow() then
			_p:onEditHeroChange(heroId)
		end
	end
end

function M:openAniSelectTips(point, heroId, stateName, onlyFliterElement, filterMatchStr, callBackFunc, callBackHandler)
	self._compAniSelectTips:show(point, heroId, stateName, onlyFliterElement, filterMatchStr, callBackFunc, callBackHandler)
end

function M:openCamCodeSelectTips(camCode, callBackFunc, callBackHandler)
	self._compCamSelectTips:show(camCode, callBackFunc, callBackHandler)
end

function M:setPage(tabIndex)
	local activeIndex = self:getActiveIndex()

	if activeIndex and activeIndex == tabIndex then
		return
	end

	self._activeIndex = tabIndex

	for _pTyp, _p in pairs(self._page) do
		_p:activeView(_pTyp == tabIndex)
	end
end

function M:_getMainUICanvasGroup()
	local uiroot = self:getMainGo().transform.parent.parent
	local trMainUI = goutil.findChild(uiroot, "HUD/main_view(Clone)")

	if trMainUI then
		local canvasGroup = trMainUI:GetComponent(ComponentType.CanvasGroup)

		return canvasGroup
	end

	return nil
end

function M:_onToggleMoveCamPoint(_, isOn)
	local sceneType = SceneMgr.instance:getCurSceneType()

	if sceneType ~= SceneType.Room then
		printWarn("非主场景，不响应操作")

		return
	end

	local scene = SceneMgr.instance:getCurScene()
	local sceneCam = scene.camera

	if sceneCam then
		local point = self:getPoint()
		local camCode = isOn and (point + 1) * -1 or 0
		local _duration = 0.4

		sceneCam:releaseCamTween()
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CAM_OFFSET_CTRL, _duration - 0.1)
		sceneCam:tweenCam(camCode, _duration, nil, true)
	end
end

function M:getPoint()
	local activeIndex = self._tabPointViewPager.getActiveIndex() or 1
	local point = activeIndex - 1

	return point
end

function M:buildPointViewPager()
	local pager = {}

	pager._activeIndex = nil

	function pager.setPage(pagerSelf, index)
		pager._activeIndex = index
		self._needCheckSaveState = false

		self._toggleTabControl:selectTab(1)

		self._needCheckSaveState = true

		self:refreshView()
	end

	function pager.getActiveIndex()
		return pager._activeIndex
	end

	function pager.setActiveIndex(index)
		pager._activeIndex = index
	end

	return pager
end

return M
