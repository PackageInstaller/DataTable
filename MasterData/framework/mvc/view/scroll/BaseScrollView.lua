-- chunkname: @framework/mvc/view/scroll/BaseScrollView.lua

module("framework.mvc.view.scroll.BaseScrollView", package.seeall)

local BaseScrollView = class("BaseScrollView", BaseView)

function BaseScrollView:ctor(scrollModel, emptyScrollParam)
	self._model = scrollModel
	self._emptyParam = emptyScrollParam
	self._isShowing = false
	self._needRefresh = true
	self._emptyGO = nil
	self._emptyHandler = nil
end

function BaseScrollView:onInitView()
	if self._model then
		self._model:addScrollView(self)
	end

	if self._emptyParam then
		if self._emptyParam.prefabType == ScrollEnum.ScrollPrefabFromView then
			self._emptyGO = gohelper.findChild(self.viewGO, self._emptyParam.prefabUrl)
		else
			local parentGO = gohelper.findChild(self.viewGO, self._emptyParam.parentPath)

			if not parentGO then
				logError("empty go parent cannot find: " .. self._emptyParam.parentPath)
			end

			self._emptyGO = self:getResInst(self._emptyParam.prefabUrl, parentGO)

			if not self._emptyGO then
				logError("empty res cannot find: " .. self._emptyParam.prefabUrl)
			end
		end

		self._emptyHandler = self._emptyParam.handleClass.New()

		if not self._emptyHandler then
			logError("empty handler cannot find: " .. ((self._emptyParam.handleClass or nil) and (self._emptyParam.handleClass.__cname or self.viewContainer.viewName)))
		end
	end

	if self._param and self._param.scrollGOPath and GameResMgr.IsFromEditorDir then
		local scrollGO = gohelper.findChild(self.viewGO, self._param.scrollGOPath)
		local pathGO = gohelper.create2d(scrollGO, self._param.prefabUrl)

		gohelper.setSibling(pathGO, 0)
	end
end

function BaseScrollView:onOpen()
	self._isShowing = true

	if self._needRefresh then
		self:refreshScroll()
	end
end

function BaseScrollView:onCloseFinish()
	self._isShowing = false
end

function BaseScrollView:onDestroyView()
	if self._model then
		self._model:removeScrollView(self)

		self._model = nil
	end

	if self._emptyGO then
		gohelper.destroy(self._emptyGO)

		self._emptyGO = nil
		self._emptyParam = nil
		self._emptyHandler = nil
	end
end

function BaseScrollView:onModelUpdate()
	if self._isShowing then
		self:refreshScroll()
	else
		self._needRefresh = true
	end
end

function BaseScrollView:refreshScroll()
	self._needRefresh = false
end

function BaseScrollView:updateEmptyGO(cellCount)
	if self._emptyGO then
		gohelper.setActive(self._emptyGO, cellCount <= 0)

		if cellCount <= 0 then
			self._emptyHandler:refreshEmptyView(self._emptyGO, self._emptyParam.params)
		end
	end
end

return BaseScrollView
