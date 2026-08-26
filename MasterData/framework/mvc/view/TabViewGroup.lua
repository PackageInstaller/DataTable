-- chunkname: @framework/mvc/view/TabViewGroup.lua

module("framework.mvc.view.TabViewGroup", package.seeall)

local TabViewGroup = class("TabViewGroup", BaseView)

function TabViewGroup:ctor(tabContainerId, tabGOContainerPath)
	TabViewGroup.super.ctor(self)

	self._tabContainerId = tabContainerId or 1
	self._tabGOContainerPath = tabGOContainerPath
	self._tabGOContainer = nil
	self._tabAbLoaders = {}
	self._tabCanvasGroup = {}
	self._tabViews = nil
	self._curTabId = nil
	self._hasOpenFinish = false
	self._UIBlockKey = nil
end

function TabViewGroup:onInitView()
	self._UIBlockKey = self.viewName .. UIBlockKey.TabViewOpening .. self._tabContainerId
	self._tabGOContainer = self.viewGO

	if not string.nilorempty(self._tabGOContainerPath) then
		self._tabGOContainer = gohelper.findChild(self.viewGO, self._tabGOContainerPath)
	end

	if not self._tabGOContainer then
		logError(self.viewName .. " tabGOContainer not exist: " .. self._tabGOContainerPath)
	end

	self._tabViews = self.viewContainer:buildTabViews(self._tabContainerId)
end

function TabViewGroup:onOpen()
	self.viewContainer:registerCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)

	if self.viewParam and type(self.viewParam) == "table" and self.viewParam.defaultTabIds then
		if not self.viewParam.defaultTabIds[self._tabContainerId] then
			local defaultTabId = 1

			self:_openTabView(defaultTabId)
		end
	end
end

function TabViewGroup:onOpenFinish()
	if self:_hasLoaded(self._curTabId) then
		self._tabViews[self._curTabId]:onOpenFinishInternal()
	else
		self._hasOpenFinish = true
	end
end

function TabViewGroup:onUpdateParam()
	if self:_hasLoaded(self._curTabId) then
		self._tabViews[self._curTabId]:onUpdateParamInternal()
	end
end

function TabViewGroup:onClose()
	self._hasOpenFinish = false

	self.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
	self:_closeTabView()
end

function TabViewGroup:onCloseFinish()
	if self:_hasLoaded(self._curTabId) then
		self._tabViews[self._curTabId]:onCloseFinishInternal()
	end

	self._curTabId = nil
end

function TabViewGroup:removeEvents()
	if self._tabViews then
		for tabId, item in pairs(self._tabViews) do
			local tabLoader = self._tabAbLoaders[tabId]

			if tabLoader and not tabLoader.isLoading then
				item:removeEventsInternal()
			end
		end
	end
end

function TabViewGroup:onDestroyView()
	if self._tabViews then
		for tabId, item in pairs(self._tabViews) do
			local tabLoader = self._tabAbLoaders[tabId]

			if tabLoader and not tabLoader.isLoading then
				item:onDestroyViewInternal()
				item:tryCallMethodName("__onDispose")
			end
		end
	end

	for _, tabLoader in pairs(self._tabAbLoaders) do
		tabLoader:dispose()
	end

	self._tabAbLoaders = nil
	self._tabCanvasGroup = nil
	self._tabGOContainer = nil
	self._tabViews = nil
end

function TabViewGroup:getTabContainerId()
	return self._tabContainerId
end

function TabViewGroup:getCurTabId()
	return self._curTabId
end

function TabViewGroup:isHasTryCallFail()
	if self._tabViews then
		for tabId, item in pairs(self._tabViews) do
			if item and item:isHasTryCallFail() then
				return true
			end
		end
	end

	return false
end

function TabViewGroup:_toSwitchTab(tabContainerId, tabId)
	if tabContainerId == self._tabContainerId then
		self:_openTabView(tabId)
	end
end

function TabViewGroup:_openTabView(tabId)
	self:_closeTabView()

	self._curTabId = tabId

	ViewMgr.instance:dispatchEvent(ViewEvent.BeforeOpenTabView, {
		tabGroupView = self,
		viewName = self.viewName,
		tabView = self._tabViews[self._curTabId]
	})

	if self._tabAbLoaders[self._curTabId] then
		self:_setVisible(self._curTabId, true)
		self._tabViews[self._curTabId]:onOpenInternal()
	else
		local loader = MultiAbLoader.New()

		self._tabAbLoaders[self._curTabId] = loader

		local tabRes = self.viewContainer:getSetting().tabRes

		if tabRes then
			::label_14_0::

			local var_14_0 = tabRes[self._tabContainerId]

			if tabRes[self._tabContainerId] then
				local curTabRes = tabRes[self._tabContainerId][self._curTabId]

				if curTabRes then
					UIBlockMgr.instance:startBlock(self._UIBlockKey)
					loader:setPathList(curTabRes)
					loader:startLoad(self._finishCallback, self)
				else
					logError(string.format("TabView no res: tabContainerId_%d, tabId_%d", self._tabContainerId, self._curTabId))
				end
			end
		end
	end
end

function TabViewGroup:_closeTabView()
	if self._curTabId then
		if self._curTabId then
			if self._curTabId.isLoading then
				self._curTabId:dispose()

				self._tabAbLoaders[self._curTabId] = nil

				UIBlockMgr.instance:endBlock(self._UIBlockKey)
			else
				self._tabViews[self._curTabId]:onCloseInternal()
				self:_setVisible(self._curTabId, false)
			end
		end
	end
end

function TabViewGroup:_setVisible(tabId, isVisible)
	local canvasGroup = self._tabCanvasGroup[tabId]

	if not canvasGroup then
		local viewGO = self._tabViews[tabId].viewGO

		canvasGroup = gohelper.onceAddComponent(viewGO, typeof(UnityEngine.CanvasGroup))
		self._tabCanvasGroup[tabId] = canvasGroup
	end

	if isVisible then
		canvasGroup.alpha = 1
		canvasGroup.interactable = true
		canvasGroup.blocksRaycasts = true
	else
		canvasGroup.alpha = 0
		canvasGroup.interactable = false
		canvasGroup.blocksRaycasts = false
	end
end

function TabViewGroup:_finishCallback(loader)
	UIBlockMgr.instance:endBlock(self._UIBlockKey)

	local firstAssetItem = loader:getFirstAssetItem()
	local tabPrefab = firstAssetItem:GetResource()
	local viewGO = gohelper.clone(tabPrefab, self._tabGOContainer)
	local tabView = self._tabViews[self._curTabId]

	if tabView then
		tabView:__onInit()

		tabView.rootGO = self.viewGO
		tabView.viewGO = viewGO
		tabView.tabContainer = self
		tabView.viewContainer = self.viewContainer
		tabView.viewName = self.viewName
		tabView.viewParam = self.viewParam

		self:_setVisible(self._curTabId, true)
		tabView:onInitViewInternal()
		tabView:addEventsInternal()
		tabView:onOpenInternal()

		if self._hasOpenFinish then
			tabView:onOpenFinishInternal()
		end
	else
		logError(string.format("TabView not exist: tabContainerId_%d, tabId_%d", self._tabContainerId, self._curTabId))
	end
end

function TabViewGroup:_hasLoaded(tabId)
	if self._tabAbLoaders then
		return self._tabAbLoaders and not self._tabAbLoaders.isLoading
	end
end

return TabViewGroup
