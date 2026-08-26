-- chunkname: @framework/mvc/view/ViewMgr.lua

module("framework.mvc.view.ViewMgr", package.seeall)

local ViewMgr = class("ViewMgr")

function ViewMgr:ctor()
	self._viewSettings = nil
	self._viewContainerDict = {}
	self._openViewNameList = {}
	self._openViewNameSet = {}
	self._uiCanvas = nil
	self._uiRoot = nil
	self._topUICanvas = nil
	self._topUIRoot = nil
	self._uiLayerDict = {}

	LuaEventSystem.addEventMechanism(self)
end

function ViewMgr:init(viewSettings)
	self._viewSettings = viewSettings

	ViewModalMaskMgr.instance:init()
	ViewFullScreenMgr.instance:init()
	ViewDestroyMgr.instance:init()
end

function ViewMgr:openTabView(viewName, param, isImmediate, tabId1, tabId2, tabId3)
	param = param or {}
	param.defaultTabIds = {
		tabId1,
		tabId2,
		tabId3
	}

	self:openView(viewName, param, isImmediate)
end

function ViewMgr:openView(viewName, param, isImmediate)
	if viewName == nil or viewName == "" then
		logError("viewName is empty")

		return
	end

	local existViewContainer = self:getContainer(viewName)

	if self._openViewNameSet[viewName] and existViewContainer then
		tabletool.removeValue(self._openViewNameList, viewName)
		table.insert(self._openViewNameList, viewName)
		gohelper.setAsLastSibling(existViewContainer.viewGO)
		existViewContainer:onUpdateParamInternal(param)
		ViewMgr.instance:dispatchEvent(ViewEvent.ReOpenWhileOpen, viewName, param)

		return
	end

	local viewContainer = self:_createContainer(viewName)

	self._viewContainerDict[viewName] = viewContainer

	table.insert(self._openViewNameList, viewName)

	self._openViewNameSet[viewName] = true

	viewContainer:openInternal(param, isImmediate)
end

function ViewMgr:closeView(viewName, isImmediate, closeManually)
	if not viewName or not self._openViewNameSet[viewName] then
		return
	end

	self._openViewNameSet[viewName] = nil

	tabletool.removeValue(self._openViewNameList, viewName)

	local viewContainer = self:getContainer(viewName)

	viewContainer:setCloseType((closeManually or nil) and (BaseViewContainer.CloseTypeManual or nil))
	viewContainer:closeInternal(isImmediate)
end

function ViewMgr:destroyView(viewName)
	local viewContainer = self:getContainer(viewName)

	if viewContainer then
		if viewContainer:isOpen() then
			viewContainer:closeInternal(true)
		end

		viewContainer:destroyView()
		viewContainer:__onDispose()

		self._viewContainerDict[viewName] = nil

		if self:isFull(viewName) then
			ViewMgr.instance:dispatchEvent(ViewEvent.DestroyFullViewFinish, viewName)
		elseif self:isModal(viewName) then
			ViewMgr.instance:dispatchEvent(ViewEvent.DestroyModalViewFinish, viewName)
		end

		ViewMgr.instance:dispatchEvent(ViewEvent.DestroyViewFinish, viewName)
	end
end

function ViewMgr:isOpen(viewName)
	local viewContainer = self:getContainer(viewName)

	return viewContainer and viewContainer:isOpen()
end

function ViewMgr:isOpening(viewName)
	local viewContainer = self:getContainer(viewName)

	return viewContainer and viewContainer:isOpening()
end

function ViewMgr:isOpenFinish(viewName)
	local viewContainer = self:getContainer(viewName)

	return viewContainer and viewContainer:isOpenFinish()
end

function ViewMgr:closeAllModalViews(excludeArr)
	local views

	for i = #self._openViewNameList, 1, -1 do
		local viewName = self._openViewNameList[i]

		if (not excludeArr or not tabletool.indexOf(excludeArr, viewName)) and self:isModal(viewName) then
			views = views or {}

			table.insert(views, viewName)
		end
	end

	if views then
		for i = 1, #views do
			self:closeView(views[i], true)
		end
	end
end

function ViewMgr:closeAllPopupViews(excludeArr, closeManually)
	local views

	for i = #self._openViewNameList, 1, -1 do
		local viewName = self._openViewNameList[i]
		local setting = self:getSetting(viewName)

		if (not excludeArr or not tabletool.indexOf(excludeArr, viewName)) and (setting.layer == UILayerName.PopUpTop or setting.layer == UILayerName.PopUp) then
			views = views or {}

			table.insert(views, viewName)
		end
	end

	if views then
		local len = #views

		for i = 1, len do
			self:closeView(views[i], true, i == len and closeManually)
		end
	end
end

function ViewMgr:closeAllViews(excludeArr)
	local views

	for i = #self._openViewNameList, 1, -1 do
		local viewName = self._openViewNameList[i]

		if not excludeArr or not tabletool.indexOf(excludeArr, viewName) then
			views = views or {}

			table.insert(views, viewName)
		end
	end

	if views then
		for i = 1, #views do
			self:closeView(views[i], true)
		end
	end
end

function ViewMgr:IsPopUpViewOpen()
	for i = #self._openViewNameList, 1, -1 do
		local viewName = self._openViewNameList[i]
		local setting = self:getSetting(viewName)

		if setting.layer == UILayerName.PopUpTop or setting.layer == UILayerName.PopUp or setting.layer == UILayerName.Guide then
			return true
		end
	end

	return false
end

function ViewMgr:getSetting(viewName)
	return self._viewSettings[viewName]
end

function ViewMgr:getOpenViewNameList()
	return self._openViewNameList
end

function ViewMgr:hasOpenFullView()
	for _, viewName in ipairs(self._openViewNameList) do
		if self:isFull(viewName) then
			return true
		end
	end

	return false
end

function ViewMgr:isNormal(viewName)
	local viewSetting = self._viewSettings[viewName]

	return viewSetting and viewSetting.viewType == ViewType.Normal
end

function ViewMgr:isModal(viewName)
	local viewSetting = self._viewSettings[viewName]

	return viewSetting and viewSetting.viewType == ViewType.Modal
end

function ViewMgr:isFull(viewName)
	local viewSetting = self._viewSettings[viewName]

	return viewSetting and viewSetting.viewType == ViewType.Full
end

function ViewMgr:getUIRoot()
	self._uiRoot = self._uiRoot or gohelper.find("UIRoot")

	return self._uiRoot
end

function ViewMgr:getTopUIRoot()
	self._topUIRoot = self._topUIRoot or gohelper.find("UIRoot")

	return self._topUIRoot
end

function ViewMgr:getUICanvas()
	self._uiCanvas = self._uiCanvas or self:getUIRoot():GetComponent("Canvas")

	return self._uiCanvas
end

function ViewMgr:getTopUICanvas()
	self._topUICanvas = self._topUICanvas or self:getTopUIRoot():GetComponent("Canvas")

	return self._topUICanvas
end

function ViewMgr:getUILayer(uiLayerName)
	local innerRoot = self._uiLayerDict[uiLayerName]

	if not innerRoot then
		if uiLayerName == UILayerName.IDCanvasPopUp then
			innerRoot = gohelper.find(uiLayerName)
		else
			local root = self:getUIRoot()

			innerRoot = gohelper.findChild(self:getUIRoot(), uiLayerName)
			innerRoot = innerRoot or gohelper.findChild(self:getTopUIRoot(), uiLayerName)
		end

		if innerRoot then
			self._uiLayerDict[uiLayerName] = innerRoot
		end
	end

	return innerRoot
end

function ViewMgr:getContainer(viewName)
	return self._viewContainerDict[viewName]
end

function ViewMgr:_createContainer(viewName)
	local viewContainer = self._viewContainerDict[viewName]

	if not viewContainer then
		local viewSetting = self:getSetting(viewName)

		if viewSetting == nil then
			logError("view setting is nil " .. viewName)
		end

		local classPath = getModulePath(viewSetting.container)

		if classPath then
			local classDefine = addGlobalModule(classPath)

			viewContainer = classDefine.New()

			viewContainer:__onInit()
			viewContainer:setSetting(viewName, viewSetting)
		else
			logError("ViewContainer class path not exist: " .. viewName)
		end
	end

	return viewContainer
end

ViewMgr.instance = ViewMgr.New()

return ViewMgr
