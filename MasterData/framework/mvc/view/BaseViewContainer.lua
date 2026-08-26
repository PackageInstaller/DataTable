-- chunkname: @framework/mvc/view/BaseViewContainer.lua

module("framework.mvc.view.BaseViewContainer", package.seeall)

local BaseViewContainer = class("BaseViewContainer", UserDataDispose)

BaseViewContainer.Status_None = 0
BaseViewContainer.Status_ResLoading = 1
BaseViewContainer.Status_Opening = 2
BaseViewContainer.Status_Open = 3
BaseViewContainer.Status_Closing = 4
BaseViewContainer.Status_Close = 5
BaseViewContainer.Stage_onOpen = 1
BaseViewContainer.Stage_onOpenFinish = 2
BaseViewContainer.Stage_onClose = 3
BaseViewContainer.Stage_onCloseFinish = 4
BaseViewContainer.ViewLoadingCount = 0
BaseViewContainer.CloseTypeManual = 1

function BaseViewContainer:ctor()
	LuaEventSystem.addEventMechanism(self)

	self._views = nil
	self._tabViews = nil
	self._viewSetting = nil
	self._isOpenImmediate = false
	self._isCloseImmediate = false
	self._viewStatus = BaseViewContainer.Status_None
	self._isVisible = true
	self._abLoader = nil
	self._canvasGroup = nil
	self.viewName = nil
	self.viewParam = nil
	self.viewGO = nil
	self._closeType = nil
end

function BaseViewContainer:setCloseType(type)
	self._closeType = type
end

function BaseViewContainer:isManualClose()
	return self._closeType == BaseViewContainer.CloseTypeManual
end

function BaseViewContainer:setSetting(viewName, viewSetting)
	self.viewName = viewName
	self._viewSetting = viewSetting
end

function BaseViewContainer:getSetting()
	return self._viewSetting
end

function BaseViewContainer:openInternal(viewParam, isImmediate)
	self.viewParam = viewParam
	self._isOpenImmediate = isImmediate

	if self._viewStatus == BaseViewContainer.Status_ResLoading or self._viewStatus == BaseViewContainer.Status_Opening or self._viewStatus == BaseViewContainer.Status_Open then
		return
	end

	ViewMgr.instance:dispatchEvent(ViewEvent.BeforeOpenView, self.viewName, self.viewParam)

	if not self._abLoader then
		self:_setVisible(true)

		self._viewStatus = BaseViewContainer.Status_ResLoading

		self:_loadViewRes()

		return
	end

	if self._viewStatus == BaseViewContainer.Status_Closing then
		self:onPlayCloseTransitionFinish()
	end

	self:_setVisible(true)
	self:_reallyOpen()
end

function BaseViewContainer:closeInternal(isImmediate)
	self._isCloseImmediate = isImmediate

	if self._viewStatus == BaseViewContainer.Status_ResLoading then
		if self._abLoader then
			self._abLoader:dispose()

			self._abLoader = nil
			BaseViewContainer.ViewLoadingCount = BaseViewContainer.ViewLoadingCount - 1

			if BaseViewContainer.ViewLoadingCount <= 0 then
				UIBlockMgr.instance:endBlock(UIBlockKey.ViewOpening)
			end
		end

		self._viewStatus = BaseViewContainer.Status_None
	elseif self._viewStatus == BaseViewContainer.Status_Closing then
		if isImmediate then
			self:onPlayCloseTransitionFinish()
		end
	elseif self._viewStatus == BaseViewContainer.Status_Opening then
		self:onPlayOpenTransitionFinish()
		self:_reallyClose()
	elseif self._viewStatus == BaseViewContainer.Status_Open then
		self:_reallyClose()
	end
end

function BaseViewContainer:setVisibleInternal(isVisible)
	self:_setVisible(isVisible)
end

function BaseViewContainer:onUpdateParamInternal(viewParam)
	self:_setVisible(true)

	self.viewParam = viewParam

	if self._views then
		for _, item in ipairs(self._views) do
			item.viewParam = viewParam

			item:onUpdateParamInternal()
		end
	end

	self:onContainerUpdateParam()
end

function BaseViewContainer:onClickModalMaskInternal()
	if self._views then
		for _, item in ipairs(self._views) do
			item:onClickModalMaskInternal()
		end
	end

	self:onContainerClickModalMask()
end

function BaseViewContainer:isOpen()
	return self:isOpening() or self:isOpenFinish()
end

function BaseViewContainer:isOpening()
	return self._viewStatus == BaseViewContainer.Status_ResLoading or self._viewStatus == BaseViewContainer.Status_Opening
end

function BaseViewContainer:isOpenFinish()
	return self._viewStatus == BaseViewContainer.Status_Open
end

function BaseViewContainer:isClosing()
	return self._viewStatus == BaseViewContainer.Status_Closing
end

function BaseViewContainer:destroyView()
	if self._views then
		for _, item in ipairs(self._views) do
			item:removeEventsInternal()
			item:onDestroyViewInternal()
			item:tryCallMethodName("__onDispose")
		end
	end

	if self.viewGO then
		gohelper.destroy(self.viewGO)

		self.viewGO = nil
	end

	if self._abLoader then
		self._abLoader:dispose()

		self._abLoader = nil
	end

	self:onContainerDestroy()
end

function BaseViewContainer:closeThis()
	ViewMgr.instance:closeView(self.viewName)
end

function BaseViewContainer:getRes(resPath)
	local assetItem = self._abLoader:getAssetItem(resPath)

	if assetItem then
		return assetItem:GetResource(resPath)
	end

	return nil
end

function BaseViewContainer:getResInst(resPath, parentGO, name)
	local assetItem = self._abLoader:getAssetItem(resPath)

	if assetItem then
		local prefab = assetItem:GetResource(resPath)

		if prefab then
			return gohelper.clone(prefab, parentGO, name)
		else
			logError(self.__cname .. " prefab not exist: " .. resPath)
		end
	else
		logError(self.__cname .. " resource not load: " .. resPath)
	end

	return nil
end

function BaseViewContainer:_loadViewRes()
	local mainResPath = self._viewSetting.mainRes
	local otherResPath = self._viewSetting.otherRes
	local allResPath = {
		mainResPath
	}

	if otherResPath then
		for _, k in pairs(otherResPath) do
			table.insert(allResPath, k)
		end
	end

	if self._viewSetting.preloader then
		if not self._viewSetting.preloader[self.viewName] then
			local preloader

			if preloader then
				preloader(allResPath)
			end

			if self.viewParam and type(self.viewParam) == "table" and self.viewParam.defaultTabIds and self._viewSetting.tabRes then
				for tabContainerId, defaultTabId in ipairs(self.viewParam.defaultTabIds) do
					local tabContainerRes = self._viewSetting.tabRes[tabContainerId]
					local defaultTabRes = tabContainerRes and tabContainerRes[defaultTabId]

					if defaultTabRes then
						for _, resPath in pairs(defaultTabRes) do
							table.insert(allResPath, resPath)
						end
					end
				end
			end

			if not string.nilorempty(self._viewSetting.anim) and string.find(self._viewSetting.anim, ".controller") then
				table.insert(allResPath, self._viewSetting.anim)
			end

			BaseViewContainer.ViewLoadingCount = BaseViewContainer.ViewLoadingCount + 1

			UIBlockMgr.instance:startBlock(UIBlockKey.ViewOpening)

			self._abLoader = MultiAbLoader.New()

			self._abLoader:setPathList(allResPath)
			self._abLoader:startLoad(self._onResLoadFinish, self)
		end
	end
end

function BaseViewContainer:_onResLoadFinish(multiAbLoader)
	local uiLayerGO = ViewMgr.instance:getUILayer(self._viewSetting.layer)
	local assetItem = self._abLoader:getAssetItem(self._viewSetting.mainRes)
	local mainPrefab = assetItem:GetResource(self._viewSetting.mainRes)

	self.viewGO = gohelper.clone(mainPrefab, uiLayerGO, self.viewName)
	self._views = self:buildViews()

	if self._views then
		for _, item in ipairs(self._views) do
			if isTypeOf(item, TabViewGroup) then
				self._tabViews = self._tabViews or {}
				self._tabViews[item:getTabContainerId()] = item
			end

			item:tryCallMethodName("__onInit")

			item.viewGO = self.viewGO
			item.viewContainer = self
			item.viewName = self.viewName

			item:onInitViewInternal()
			item:addEventsInternal()
		end
	end

	self:onContainerInit()

	BaseViewContainer.ViewLoadingCount = BaseViewContainer.ViewLoadingCount - 1

	if BaseViewContainer.ViewLoadingCount <= 0 then
		UIBlockMgr.instance:endBlock(UIBlockKey.ViewOpening)
	end

	self:_reallyOpen()
end

function BaseViewContainer:_setVisible(isVisible)
	self._isVisible = isVisible

	if not self.viewGO then
		return
	end

	self._canvasGroup = self._canvasGroup or gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))

	if isVisible then
		self._canvasGroup.alpha = 1
		self._canvasGroup.interactable = true
		self._canvasGroup.blocksRaycasts = true

		recthelper.setAnchorX(self.viewGO.transform, 0)
	else
		self._canvasGroup.alpha = 0
		self._canvasGroup.interactable = false
		self._canvasGroup.blocksRaycasts = false

		recthelper.setAnchorX(self.viewGO.transform, 10000)
	end
end

function BaseViewContainer:_reallyOpen()
	self.viewGO.transform:SetAsLastSibling()
	self:_setVisible(self._isVisible)

	self._viewStatus = BaseViewContainer.Status_Opening

	self:_onViewStage(BaseViewContainer.Stage_onOpen)

	if self._viewStatus ~= BaseViewContainer.Status_Opening then
		if isDebugBuild then
			logError(self.viewName .. " status change while opening " .. self._viewStatus)
		end

		return
	end

	if self._isOpenImmediate then
		self:onPlayOpenTransitionFinish()
	else
		self:playOpenTransition()
	end
end

function BaseViewContainer:_reallyClose()
	self._viewStatus = BaseViewContainer.Status_Closing

	self:_onViewStage(BaseViewContainer.Stage_onClose)

	if self._viewStatus ~= BaseViewContainer.Status_Closing then
		if isDebugBuild then
			logError(self.viewName .. " status change while closing " .. self._viewStatus)
		end

		return
	end

	if self._isCloseImmediate then
		self:onPlayCloseTransitionFinish()
	else
		self:playCloseTransition()
	end
end

function BaseViewContainer:_onViewStage(viewStage)
	if self._views then
		for _, item in ipairs(self._views) do
			if viewStage == BaseViewContainer.Stage_onOpen then
				item.viewParam = self.viewParam

				item:onOpenInternal()
			elseif viewStage == BaseViewContainer.Stage_onOpenFinish then
				item:onOpenFinishInternal()
			elseif viewStage == BaseViewContainer.Stage_onClose then
				item:onCloseInternal()
			elseif viewStage == BaseViewContainer.Stage_onCloseFinish then
				item:onCloseFinishInternal()
			end
		end
	end

	if viewStage == BaseViewContainer.Stage_onOpen then
		ViewMgr.instance:dispatchEvent(ViewEvent.OnOpenView, self.viewName, self.viewParam)

		if self._viewSetting.viewType == ViewType.Full then
			ViewMgr.instance:dispatchEvent(ViewEvent.OnOpenFullView, self.viewName, self.viewParam)
		elseif self._viewSetting.viewType == ViewType.Modal then
			ViewMgr.instance:dispatchEvent(ViewEvent.OnOpenModalView, self.viewName, self.viewParam)
		end

		self:onContainerOpen()
	elseif viewStage == BaseViewContainer.Stage_onOpenFinish then
		ViewMgr.instance:dispatchEvent(ViewEvent.OnOpenViewFinish, self.viewName, self.viewParam)

		if self._viewSetting.viewType == ViewType.Full then
			ViewMgr.instance:dispatchEvent(ViewEvent.OnOpenFullViewFinish, self.viewName, self.viewParam)
		elseif self._viewSetting.viewType == ViewType.Modal then
			ViewMgr.instance:dispatchEvent(ViewEvent.OnOpenModalViewFinish, self.viewName, self.viewParam)
		end

		self:onContainerOpenFinish()
	elseif viewStage == BaseViewContainer.Stage_onClose then
		ViewMgr.instance:dispatchEvent(ViewEvent.OnCloseView, self.viewName, self.viewParam)

		if self._viewSetting.viewType == ViewType.Full then
			ViewMgr.instance:dispatchEvent(ViewEvent.OnCloseFullView, self.viewName, self.viewParam)
		elseif self._viewSetting.viewType == ViewType.Modal then
			ViewMgr.instance:dispatchEvent(ViewEvent.OnCloseModalView, self.viewName, self.viewParam)
		end

		self:onContainerClose()
	elseif viewStage == BaseViewContainer.Stage_onCloseFinish then
		ViewMgr.instance:dispatchEvent(ViewEvent.OnCloseViewFinish, self.viewName, self.viewParam)

		if self._viewSetting.viewType == ViewType.Full then
			ViewMgr.instance:dispatchEvent(ViewEvent.OnCloseFullViewFinish, self.viewName, self.viewParam)
		elseif self._viewSetting.viewType == ViewType.Modal then
			ViewMgr.instance:dispatchEvent(ViewEvent.OnCloseModalViewFinish, self.viewName, self.viewParam)
		end

		self:onContainerCloseFinish()
	end
end

function BaseViewContainer:getTabContainer(tabContainerId)
	return self._tabViews and self._tabViews[tabContainerId]
end

function BaseViewContainer:isHasTryCallFail()
	if self._views then
		for _, item in ipairs(self._views) do
			if item:isHasTryCallFail() then
				return true
			end
		end
	end

	return false
end

function BaseViewContainer:playOpenTransition()
	self:onPlayOpenTransitionFinish()
end

function BaseViewContainer:onPlayOpenTransitionFinish()
	self._viewStatus = BaseViewContainer.Status_Open

	self:_onViewStage(BaseViewContainer.Stage_onOpenFinish)
end

function BaseViewContainer:playCloseTransition()
	self:onPlayCloseTransitionFinish()
end

function BaseViewContainer:onPlayCloseTransitionFinish()
	self:_setVisible(false)

	self._viewStatus = BaseViewContainer.Status_Close

	self:_onViewStage(BaseViewContainer.Stage_onCloseFinish)
	self:setCloseType(nil)
end

function BaseViewContainer:onAndroidBack()
	return
end

function BaseViewContainer:buildViews()
	return
end

function BaseViewContainer:buildTabViews(tabContainerId)
	return
end

function BaseViewContainer:onContainerInit()
	return
end

function BaseViewContainer:onContainerDestroy()
	return
end

function BaseViewContainer:onContainerOpen()
	return
end

function BaseViewContainer:onContainerOpenFinish()
	return
end

function BaseViewContainer:onContainerClose()
	return
end

function BaseViewContainer:onContainerCloseFinish()
	return
end

function BaseViewContainer:onContainerUpdateParam()
	return
end

function BaseViewContainer:onContainerClickModalMask()
	return
end

return BaseViewContainer
