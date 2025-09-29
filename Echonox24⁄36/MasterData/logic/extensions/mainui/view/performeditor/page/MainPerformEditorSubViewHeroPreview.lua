-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/page/MainPerformEditorSubViewHeroPreview.lua

module("logic.extensions.mainui.view.performeditor.page.MainPerformEditorSubViewHeroPreview", package.seeall)

local M = class("MainPerformEditorSubViewHeroPreview")

M.PageType = {
	Hero = 3,
	Pos = 2,
	Cam = 1
}

function M:ctor(mainGo)
	self.mainGO = mainGo
end

function M:init(viewRegistry)
	self._viewRegistry = viewRegistry

	self:buildUI()
	self:bindEvents()
end

function M:Awake()
	return
end

function M:OnEnable()
	return
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

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:setTabCheckFunc(function(index)
		return self:_subTabCheckFunc(index)
	end)

	local tabRoot = registry:findUIElement("main_perform_editor_view_911811842", UIComponentType.RectTransform)

	for i = 0, tabRoot.childCount - 1 do
		self._toggleTabControl:addToggleTab(tabRoot:GetChild(i):GetComponent(UIComponentType.SpaceXToggle))
	end

	local camGo = registry:findUIElement("main_perform_editor_view_-149420890")
	local posGo = registry:findUIElement("main_perform_editor_view_1586038613")
	local heroGo = registry:findUIElement("main_perform_editor_view_-938643379")

	self._panelGoList = {
		[M.PageType.Cam] = {
			go = camGo,
			view = Astral.SimpleLuaComponentContainer.Add(camGo, MainPerformEditorPreviewCamComp)
		},
		[M.PageType.Pos] = {
			go = posGo,
			view = Astral.SimpleLuaComponentContainer.Add(posGo, MainPerformEditorPreviewPosComp)
		},
		[M.PageType.Hero] = {
			go = heroGo,
			view = Astral.SimpleLuaComponentContainer.Add(heroGo, MainPerformEditorPreviewHeroComp)
		}
	}
end

function M:getView(pageType)
	local comp = self._panelGoList[pageType]

	if comp then
		return comp.view
	end

	return nil
end

function M:destroyUI()
	for _, comp in pairs(self._panelGoList) do
		comp.view:onExit()
	end

	self:setHandler(nil)

	self.mainGO = nil
	self._viewRegistry = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
	self._panelGoList = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:onEnter()
	self._toggleTabControl:selectTab(1)
end

function M:onExit()
	for _, comp in pairs(self._panelGoList) do
		comp.view:onExit()
	end

	self._activeIndex = nil
end

function M:getActiveSubPageDirty()
	return false
end

function M:_subTabCheckFunc(index)
	local activeIndex = self:getActiveIndex()

	if activeIndex and activeIndex == index then
		return true
	end

	local view = self:getView(activeIndex)

	if view and view.IsDataDirty then
		local isDataDirty = view:IsDataDirty()

		if isDataDirty then
			return false
		end
	end

	return true
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

	for _type, comp in pairs(self._panelGoList) do
		goutil.setActive(comp.go, _type == self:getActiveIndex())
	end

	if lastViewIndex then
		local view = self:getView(lastViewIndex)

		view:onExit()
	end

	self:getView(self._activeIndex):onEnter()
end

return M
