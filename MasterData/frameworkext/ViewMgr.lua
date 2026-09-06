-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/view/ViewMgr.lua

module("frameworkext.lmvc.view.ViewMgr", package.seeall)

local ViewMgr = class("ViewMgr")

ViewMgr.kBackModeParam = -999
ViewMgr.FullScreenShow = 1
ViewMgr.FullScreenHide = 2

function ViewMgr:ctor()
	self._maskColor = "#00000096"
	self._grayMaskGO = nil
	self._uiRoot = nil
	self._views = {}
	self._curOpenViews = {}
	self._curOpenModalViews = {}
	self._curOpenFullScreenViews = {}
	self._openedOnceViews = {}
	self._loadedOnceViews = {}
	self._backStack = Stack.New()
	self._viewRootNames = {
		"HUD",
		"HUDTOP",
		"FULLSCREEN",
		"POPUP",
		"POPUPTOP",
		"NOTIFY",
		"NOTIFYTOP",
		"TOP",
		"TOPMOST"
	}
	self._viewRoots = {}
	self._uiCanvas = nil

	NotifyDispatcher.extend(self)
end

function ViewMgr:init()
	self._uiRoot = goutil.find("UIROOT")
	self._uiCanvas = self._uiRoot:GetComponent("Canvas")
	Framework.UIGlobalTouchTrigger.uiCanvas = self._uiCanvas
	Framework.UIGlobalTouchTrigger.uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	local rectTransform = self._uiRoot:GetComponent("RectTransform")

	self._uiWidth = rectTransform.rect.width
	self._uiHeight = rectTransform.rect.height

	local viewRootsCount = #self._viewRootNames

	for i = 1, viewRootsCount do
		local container = goutil.findChild(self._uiRoot, self._viewRootNames[i])

		if container then
			self._viewRoots[i] = container
		end
	end
end

function ViewMgr:setMaskColor(color)
	self._maskColor = color
end

function ViewMgr:getMaskColor()
	return self._maskColor
end

function ViewMgr:getUICanvas()
	return self._uiCanvas
end

function ViewMgr:getUIWidth()
	return self._uiWidth
end

function ViewMgr:getUIHeight()
	return self._uiHeight
end

function ViewMgr:destroy(name)
	local view = self._views[name]

	if view then
		trycall(view.destroy, view)
	end

	self._views[name] = nil
	self._loadedOnceViews[name] = nil
end

function ViewMgr:preCreate(name, mainGO, _callBack)
	if self._views[name] then
		return
	end

	local presentorName = ViewSetting.instance:getPresentorName(name)
	local clsPath = module_paths[presentorName]
	local cls = clsPath and usingnow(clsPath, presentorName) or usingnow(presentorName)

	if cls then
		local view = cls.New()

		self._views[name] = view
		view.viewName = name
		view.mainGO = mainGO

		view:loadViewResources(_callBack)
	end
end

function ViewMgr:open(name, ...)
	if self._views[name] and self:isOpen(name) then
		return
	end

	if ViewSetting.instance:isSupportBack(name) then
		self._backStack:push(name)
	end

	local view = self._views[name]

	if not view then
		local presentorName = ViewSetting.instance:getPresentorName(name)
		local clsPath = module_paths[presentorName]
		local cls = clsPath and usingnow(clsPath, presentorName) or usingnow(presentorName)

		if cls then
			view = cls.New()
			self._views[name] = view
			view.viewName = name
		end
	end

	self._curOpenViews[name] = true

	if ViewSetting.instance:isModal(name) then
		table.insert(self._curOpenModalViews, name)

		if not self._grayMaskGO then
			self:_tryCreateMaskGO()
		end

		self._grayMaskGO:SetActive(true)
		view:setGrayMaskGO(self._grayMaskGO)
	elseif ViewSetting.instance:isFullScreen(name) then
		table.insert(self._curOpenFullScreenViews, name)

		if #self._curOpenFullScreenViews == 1 then
			self:dispatch(ViewMgr.FullScreenShow, name)
		end
	end

	ViewLifetimeMgr.instance:onOpenView(name)

	local param = ...

	if param == nil then
		view:open()
	else
		param = {
			...
		}

		view:open(param)
	end

	local syncOpenList = ViewSetting.instance:getSyncOpenList(name)

	if syncOpenList then
		local len = #syncOpenList

		if len > 0 then
			for i = 1, len do
				self:open(syncOpenList[i])
			end
		end
	end
end

function ViewMgr:close(name, backMode)
	local view = self._views[name]

	if not view then
		return
	end

	if not self:isOpen(name) then
		return
	end

	self._openedOnceViews[name] = true
	self._loadedOnceViews[name] = true
	self._curOpenViews[name] = nil

	if ViewSetting.instance:isModal(name) then
		local count = #self._curOpenModalViews

		if count > 0 and self._curOpenModalViews[count] == name then
			view:setGrayMaskGO(nil)

			if count > 1 then
				local lastView = self._views[self._curOpenModalViews[count - 1]]

				lastView:setGrayMaskGO(self._grayMaskGO)
			end
		end

		table.removebyvalue(self._curOpenModalViews, name, true)

		if #self._curOpenModalViews == 0 then
			self._grayMaskGO:SetActive(false)
		end
	elseif ViewSetting.instance:isFullScreen(name) then
		table.removebyvalue(self._curOpenFullScreenViews, name, true)

		if #self._curOpenFullScreenViews == 0 then
			self:dispatch(ViewMgr.FullScreenHide, name)
		end
	end

	ViewLifetimeMgr.instance:onCloseView(name)
	view:close()

	local syncCloseList = ViewSetting.instance:getSyncCloseList(name)

	if syncCloseList then
		local len = #syncCloseList

		if len > 0 then
			for i = 1, len do
				self:close(syncCloseList[i])
			end
		end
	end

	if ViewSetting.instance:isSupportBack(name) and not self._backStack:isEmpty() then
		local topName

		while topName ~= name and not self._backStack:isEmpty() do
			topName = self._backStack:pop()
		end

		if backMode then
			local backToName = self._backStack:pop()

			self:open(backToName, ViewMgr.kBackModeParam)
		end
	end
end

function ViewMgr:closeAndShow(closeViewName, showViewName, ...)
	local view = self._views[closeViewName]

	if not view then
		return
	end

	local arg = {
		...
	}

	function view.closeCallBack()
		self:open(showViewName, unpack(arg))
	end

	self:close(closeViewName)
end

function ViewMgr:_tryCreateMaskGO()
	if self._grayMaskGO then
		return
	end

	self._grayMaskGO = goutil.create("ViewModalMask")

	local root = self:getRoot(ViewRootType.Popup)

	goutil.addChildToParent(self._grayMaskGO, root)

	local img = goutil.addComponentOnce(self._grayMaskGO, typeof(UnityEngine.UI.Image))

	img.color = parsecolor(self._maskColor)

	local rect = self._grayMaskGO.transform

	rect.anchorMin = UnityEngine.Vector2.zero
	rect.anchorMax = UnityEngine.Vector2.one
	rect.offsetMin = UnityEngine.Vector2.New(-150, -150)
	rect.offsetMax = UnityEngine.Vector2.New(150, 150)

	Framework.UIClickTrigger.Get(self._grayMaskGO):AddClickListener(self.onClickGrayMask, self, nil)
end

function ViewMgr:onClickGrayMask()
	self._views[self._curOpenModalViews[#self._curOpenModalViews]]:onClickOutside()
end

function ViewMgr:_onClickGrayMask()
	local count = #self._curOpenModalViews

	if count > 0 then
		local topModalView = self._views[self._curOpenModalViews[count]]

		if topModalView and topModalView.onClickOutside then
			topModalView:onClickOutside()
		end
	end
end

function ViewMgr:isOpen(name)
	local view = self._views[name]

	if not view then
		return false
	end

	return view:isOpen()
end

function ViewMgr:isFirstOpen(name)
	if not self._openedOnceViews[name] then
		return true
	end

	return false
end

function ViewMgr:isJustLoaded(name)
	if not self._loadedOnceViews[name] then
		return true
	end

	return false
end

function ViewMgr:clearAllFirstOpenInfo()
	self._openedOnceViews = {}
end

function ViewMgr:getRoot(rootType)
	return self._viewRoots[rootType]
end

function ViewMgr:getUIRoot()
	return self._uiRoot
end

function ViewMgr:closeAllModalViews()
	local temp = {}

	for k, v in pairs(self._curOpenViews) do
		if ViewSetting.instance:isModal(k) then
			temp[k] = v
		end
	end

	for k, v in pairs(temp) do
		self:close(k)
	end

	temp = nil
end

function ViewMgr:closeAllViews()
	local temp = {}

	for k, v in pairs(self._curOpenViews) do
		temp[k] = v
	end

	for k, v in pairs(temp) do
		self:close(k)
	end

	temp = nil
end

ViewMgr.instance = ViewMgr.New()

return ViewMgr
