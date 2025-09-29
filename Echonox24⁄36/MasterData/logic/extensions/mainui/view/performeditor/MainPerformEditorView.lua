-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/MainPerformEditorView.lua

module("logic.extensions.mainui.view.performeditor.MainPerformEditorView", package.seeall)

local M = class("MainPerformEditorView", ViewComponent)

M.PageType = {
	AirtightTime = 2,
	Point = 4,
	Test = 5,
	Base = 1,
	Preview = 6,
	BattleHero = 7,
	Cam = 3
}

function M:ctor()
	M.super.ctor(self)
end

function M:getViewRegistry()
	return self._viewPresentor._viewElementsRegistry
end

function M:buildUI()
	self._rectContentRoot = self:getUIComponent("main_perform_editor_view_115271765", UIComponentType.RectTransform)
	self._btnShow = self:getBtn("main_perform_editor_view_942841972")
	self._btnClose = self:getBtn("main_perform_editor_view_1285594230")
	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:setTabCheckFunc(function(index)
		return self:_subTabCheckFunc(index)
	end)

	local rectTabRoot = self:getUIComponent("main_perform_editor_view_1827654113", UIComponentType.RectTransform)

	for i = 0, rectTabRoot.childCount - 1 do
		self._toggleTabControl:addToggleTab(rectTabRoot:GetChild(i):GetComponent(UIComponentType.SpaceXToggle))
	end

	self._panelGoLst = {
		[M.PageType.Base] = {
			go = self:getGo("main_perform_editor_view_1846428575"),
			view = Astral.SimpleLuaComponentContainer.Add(self:getGo("main_perform_editor_view_1846428575"), MainPerformEditorSubViewBase)
		},
		[M.PageType.AirtightTime] = {
			go = self:getGo("main_perform_editor_view_-301487861"),
			view = Astral.SimpleLuaComponentContainer.Add(self:getGo("main_perform_editor_view_-301487861"), MainPerformEditorSubViewAirtightTime)
		},
		[M.PageType.Cam] = {
			go = self:getGo("main_perform_editor_view_-1198197806"),
			view = Astral.SimpleLuaComponentContainer.Add(self:getGo("main_perform_editor_view_-1198197806"), MainPerformEditorSubViewCam)
		},
		[M.PageType.Point] = {
			go = self:getGo("main_perform_editor_view_1045874306"),
			view = Astral.SimpleLuaComponentContainer.Add(self:getGo("main_perform_editor_view_1045874306"), MainPerformEditorSubViewPointBase)
		},
		[M.PageType.Test] = {
			go = self:getGo("main_perform_editor_view_1741590135"),
			view = Astral.SimpleLuaComponentContainer.Add(self:getGo("main_perform_editor_view_1741590135"), MainPerformEditorSubViewTest)
		},
		[M.PageType.Preview] = {
			go = self:getGo("main_perform_editor_view_-161010069"),
			view = Astral.SimpleLuaComponentContainer.Add(self:getGo("main_perform_editor_view_-161010069"), MainPerformEditorSubViewHeroPreview)
		},
		[M.PageType.BattleHero] = {
			go = self:getGo("main_perform_editor_view_-278356142"),
			view = Astral.SimpleLuaComponentContainer.Add(self:getGo("main_perform_editor_view_-278356142"), MainPerformEditorSubViewBattleHero)
		}
	}

	for _, comp in pairs(self._panelGoLst) do
		comp.view:setHandler(self)
		comp.view:init(self:getViewRegistry())
	end
end

function M:getView(pageType)
	local comp = self._panelGoLst[pageType]

	if comp then
		return comp.view
	end

	return nil
end

function M:destroyUI()
	for _, comp in pairs(self._panelGoLst) do
		comp.view:onExit()
	end

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
	self._panelGoLst = nil
end

function M:bindEvents()
	self._btnShow:AddClickListener(self._onClickShow, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnShow:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	self:setPanelShow(false)
end

function M:onExit()
	self:setEvent(false)

	for _, comp in pairs(self._panelGoLst) do
		comp.view:onExit()
	end

	self._activeIndex = nil
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_EDITOR_HIDE, self._handleMainSceneEditorHide, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_EDITOR_HIDE, self._handleMainSceneEditorHide, self)
	end
end

function M:_handleMainSceneEditorHide(e, hide)
	self:setPanelShow(not hide)
end

function M:_subTabCheckFunc(index)
	local activeIndex = self:getActiveIndex()

	if activeIndex and activeIndex == index then
		return true
	end

	local view = self:getView(activeIndex)

	if view and view.getActiveSubPageDirty then
		local isDataDirty = view:getActiveSubPageDirty(true)

		if isDataDirty then
			return false
		end
	end

	return true
end

function M:_onClickShow()
	self:setPanelShow(not self._contentShow)
end

function M:_onClickClose()
	local simulateCanTabCheck = self:_subTabCheckFunc(-1)

	if simulateCanTabCheck then
		ViewMgr.instance:close(ViewName.MainPerformEditorView)
	end
end

function M:setPanelShow(show)
	self._contentShow = show

	if show then
		RectTransformUtils.SetAnchoredPosition(self._rectContentRoot, -275, 0)

		local activeIndex = self:getActiveIndex()

		if not activeIndex then
			self._toggleTabControl:selectTab(self.PageType.Base)
		end

		for _type, comp in pairs(self._panelGoLst) do
			goutil.setActive(comp.go, _type == self:getActiveIndex())
		end
	else
		RectTransformUtils.SetAnchoredPosition(self._rectContentRoot, 215, 0)

		for _, comp in pairs(self._panelGoLst) do
			goutil.setActive(comp.go, false)
		end
	end

	goutil.setActive(self._btnClose.gameObject, not show)
end

function M:getActiveIndex()
	return self._activeIndex
end

function M:setPage(index, ...)
	local activeIndex = self:getActiveIndex()

	if activeIndex and activeIndex == index then
		return
	end

	local lastViewIndex = self._activeIndex

	self._activeIndex = index

	for _type, comp in pairs(self._panelGoLst) do
		goutil.setActive(comp.go, _type == self:getActiveIndex())
	end

	if lastViewIndex then
		local view = self:getView(lastViewIndex)

		view:onExit()
	end

	self:getView(self._activeIndex):onEnter()
end

return M
