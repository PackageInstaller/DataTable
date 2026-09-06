-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/view/ViewPresentor.lua

module("frameworkext.lmvc.view.ViewPresentor", package.seeall)

local ViewPresentor = class("ViewPresentor")

ViewPresentor.kViewOpNone = 0
ViewPresentor.kViewOpOpen = 1
ViewPresentor.kViewOpClose = 2
ViewPresentor.kViewStatusIniting = 0
ViewPresentor.kViewStatusOpening = 1
ViewPresentor.kViewStatusClosing = 2
ViewPresentor.kViewStatusOpen = 3
ViewPresentor.kViewStatusClose = 4
ViewPresentor.kViewStatusBuild = 5
ViewPresentor.kOnEnter = 0
ViewPresentor.kOnEnterFinished = 1
ViewPresentor.kOnExit = 2
ViewPresentor.kOnExitFinished = 3
ViewPresentor._loadingBlockNum = 0

function ViewPresentor:ctor()
	self.viewName = nil
	self.mainGO = nil
	self._resDict = nil
	self._openParam = nil
	self._opType = ViewPresentor.kViewOpNone
	self._status = ViewPresentor.kViewStatusIniting
	self._isResLoaded = false
	self._grayMaskGO = nil
	self._resLoader = nil
	self._views = nil
	self.localDispatcher = nil
	self.closeCallBack = nil
end

function ViewPresentor:isOpen()
	if self._status == ViewPresentor.kViewStatusOpen or self._status == ViewPresentor.kViewStatusOpening and self._opType ~= ViewPresentor.kViewOpClose or self._opType == ViewPresentor.kViewOpOpen then
		return true
	end

	return false
end

function ViewPresentor:setGrayMaskGO(grayMaskGO)
	self._grayMaskGO = grayMaskGO

	if grayMaskGO and self.mainGO then
		self:_adjustGrayGO()
	end
end

function ViewPresentor:loadViewResources()
	self.localDispatcher = ExtensionMgr.instance:getExtDispatcher(ViewSetting.instance:getExtId(self.viewName))

	if ViewSetting.instance:isModal(self.viewName) or ViewSetting.instance:isFullScreen(self.viewName) then
		ViewPresentor._loadingBlockNum = ViewPresentor._loadingBlockNum + 1

		ViewBlockMgr.instance:blockClick(true, kBlockKeyViewLoading)
	end

	local toloadList = self:dependWhatResources()

	if toloadList and #toloadList then
		self._resLoader = MultiResLoader.New()

		self._resLoader:setResPaths(toloadList)
		self._resLoader:load(ViewPresentor._onViewResourcesLoaded, nil, self)
	else
		self:_onViewResourcesLoaded(nil)
	end
end

function ViewPresentor:_onViewResourcesLoaded(loader)
	self._isResLoaded = true

	if loader then
		self._resDict = {}

		local resources = loader:getResources()

		for k, v in pairs(resources) do
			self._resDict[k] = v

			v:Retain()
		end

		loader:clear()
	end

	self._resLoader = nil

	if ViewSetting.instance:isModal(self.viewName) or ViewSetting.instance:isFullScreen(self.viewName) then
		ViewPresentor._loadingBlockNum = ViewPresentor._loadingBlockNum - 1

		if ViewPresentor._loadingBlockNum < 1 then
			ViewBlockMgr.instance:blockClick(false, kBlockKeyViewLoading)
		end
	end

	if not self.mainGO then
		local resList = self:dependWhatResources()

		if resList and #resList > 0 then
			self.mainGO = self:getResInstance(resList[1])
		end
	end

	if self.mainGO then
		local root = ViewMgr.instance:getRoot(self:attachToWhichRoot())

		goutil.addChildToParent(self.mainGO, root)
	end

	self._views = self:buildViews()

	if self._views then
		local vCount = #self._views

		for i = 1, vCount do
			local tempView = self._views[i]

			tempView.mainGO = self.mainGO

			tempView:setViewPresentor(self)
			tempView:buildUI()
			tempView:bindEvents()
		end
	end

	if self.mainGO then
		self.mainGO:SetActive(false)
	end

	self._status = ViewPresentor.kViewStatusClose

	if self._opType == ViewPresentor.kViewOpOpen then
		self:_doOpen()
	elseif self._opType == ViewPresentor.kViewOpClose then
		self._opType = ViewPresentor.kViewOpNone
		self._status = ViewPresentor.kViewStatusClose
	end
end

function ViewPresentor:_onVisualEvent(name)
	if not self._views then
		return
	end

	local vCount = #self._views

	for i = 1, vCount do
		if ViewPresentor.kOnEnter == name then
			self._views[i]:onEnter()
		elseif ViewPresentor.kOnEnterFinished == name then
			self._views[i]:onEnterFinished()
		elseif ViewPresentor.kOnExit == name then
			self._views[i]:onExit()
		elseif ViewPresentor.kOnExitFinished == name then
			self._views[i]:onExitFinished()
		end
	end
end

function ViewPresentor:_doOpen()
	self._opType = ViewPresentor.kViewOpNone
	self._status = ViewPresentor.kViewStatusOpening

	self.mainGO.transform:SetAsLastSibling()
	self.mainGO:SetActive(true)
	self:_onVisualEvent(ViewPresentor.kOnEnter)
	self:_adjustGrayGO()
	self:playEnterAnimation()
end

function ViewPresentor:_doClose()
	self._opType = ViewPresentor.kViewOpNone
	self._status = ViewPresentor.kViewStatusClosing

	self:_onVisualEvent(ViewPresentor.kOnExit)
	self:playCloseAnimation()
end

function ViewPresentor:open(param)
	self._openParam = param

	if not self._isResLoaded and self._opType ~= ViewPresentor.kViewOpOpen then
		self._opType = ViewPresentor.kViewOpOpen

		self:loadViewResources()

		return
	end

	if self._status == ViewPresentor.kViewStatusClose then
		self:_doOpen()
	else
		self._opType = self._status == ViewPresentor.kViewStatusClosing and ViewPresentor.kViewOpOpen or self._status == ViewPresentor.kViewStatusIniting and ViewPresentor.kViewOpOpen or ViewPresentor.kViewOpNone
	end
end

function ViewPresentor:close()
	if not self._isResLoaded then
		self._opType = ViewPresentor.kViewOpClose
		self._status = ViewPresentor.kViewStatusIniting

		return
	end

	if self._status == ViewPresentor.kViewStatusOpen then
		self:_doClose()
	else
		self._opType = self._status == ViewPresentor.kViewStatusOpening and ViewPresentor.kViewOpClose or ViewPresentor.kViewOpNone
	end
end

function ViewPresentor:destroy()
	if self._views then
		local vCount = #self._views

		for i = 1, vCount do
			if self._status ~= ViewPresentor.kViewStatusBuild then
				self._views[i]:unbindEvents()
				self._views[i]:destroyUI()
			end
		end
	end

	if self._resDict then
		for k, v in pairs(self._resDict) do
			v:Release()
		end

		self._resDict = nil
	end

	if self._resLoader then
		self._resLoader:clear()

		self._resLoader = nil
	end

	goutil.destroy(self.mainGO)
end

function ViewPresentor:_onEnterAnimationDone()
	self:_onVisualEvent(ViewPresentor.kOnEnterFinished)

	self._status = ViewPresentor.kViewStatusOpen

	if self._opType == ViewPresentor.kViewOpClose then
		self:_doClose()
	end
end

function ViewPresentor:_onCloseAnimationDone()
	self:_onVisualEvent(ViewPresentor.kOnExitFinished)

	self._status = ViewPresentor.kViewStatusClose

	self.mainGO:SetActive(false)

	if self.closeCallBack then
		self.closeCallBack()

		self.closeCallBack = nil
	end

	if self._opType == ViewPresentor.kViewOpOpen then
		self:_doOpen()
	else
		self._openParam = nil
	end
end

function ViewPresentor:_adjustGrayGO()
	if self._grayMaskGO then
		local root = ViewMgr.instance:getRoot(self:attachToWhichRoot())

		goutil.addChildToParent(self._grayMaskGO, root)

		local maskSiblingIndex = self._grayMaskGO.transform:GetSiblingIndex()
		local viewSiblingIndex = self.mainGO.transform:GetSiblingIndex()

		if viewSiblingIndex < maskSiblingIndex then
			self._grayMaskGO.transform:SetSiblingIndex(viewSiblingIndex)
		else
			self._grayMaskGO.transform:SetSiblingIndex(viewSiblingIndex - 1)
		end
	end
end

function ViewPresentor:getOpenParam()
	return self._openParam
end

function ViewPresentor:getFirstParam()
	if self._openParam then
		return self._openParam[1]
	end

	return nil
end

function ViewPresentor:unloadResBinaryBytes(path)
	local res = rescache:GetResourceNoLoadIfNotExists(path)

	if res then
		res:UnloadBinaryBytes()
	end
end

function ViewPresentor:getRes(path)
	return self._resDict[path]
end

function ViewPresentor:getPrefab(path)
	local res = self._resDict[path]

	if res then
		return res:GetMainAsset()
	end

	return nil
end

function ViewPresentor:getResInstance(path)
	local res = self._resDict[path]

	if res then
		local prefab = res:GetMainAsset()

		if prefab then
			return goutil.clone(prefab)
		end
	end

	return nil
end

function ViewPresentor:playEnterAnimation()
	settimer(0.2, ViewPresentor._onEnterAnimationDone, self, false)
end

function ViewPresentor:playCloseAnimation()
	self:_onCloseAnimationDone()
end

function ViewPresentor:dependWhatResources()
	return nil
end

function ViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ViewPresentor:buildViews()
	return nil
end

function ViewPresentor:onClickOutside()
	return
end

return ViewPresentor
