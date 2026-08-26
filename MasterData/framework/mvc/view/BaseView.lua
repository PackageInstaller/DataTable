-- chunkname: @framework/mvc/view/BaseView.lua

module("framework.mvc.view.BaseView", package.seeall)

local BaseView = class("BaseView", UserDataDispose)

function BaseView:ctor()
	self.viewGO = nil
	self.viewContainer = nil
	self.viewParam = nil
	self.viewName = nil
	self.tabContainer = nil
	self.rootGO = nil
	self._childViews = nil
	self._tryCallResultDict = nil
end

function BaseView:onInitViewInternal()
	self._has_onInitView = true

	if self._childViews then
		for _, child in ipairs(self._childViews) do
			child.viewGO = self.viewGO
			child.viewContainer = self.viewContainer
			child.viewName = self.viewName
		end
	end

	self:_internalCall("onInitView")
end

function BaseView:addEventsInternal()
	self._has_addEvents = true

	self:_internalCall("addEvents")
end

function BaseView:onOpenInternal()
	self._has_onOpen = true

	self:_internalCall("onOpen")
end

function BaseView:onOpenFinishInternal()
	self._has_onOpenFinish = true

	self:_internalCall("onOpenFinish")
end

function BaseView:onUpdateParamInternal()
	self:_internalCall("onUpdateParam")
end

function BaseView:onClickModalMaskInternal()
	self:_internalCall("onClickModalMask")
end

function BaseView:onCloseInternal()
	self._has_onOpen = false
	self._has_onOpenFinish = false

	self:_internalCall("onClose")
end

function BaseView:onCloseFinishInternal()
	self:_internalCall("onCloseFinish")
end

function BaseView:removeEventsInternal()
	self._has_addEvents = false

	self:_internalCall("removeEvents")
end

function BaseView:onDestroyViewInternal()
	self._has_onInitView = false

	self:_internalCall("onDestroyView")

	self._childViews = nil

	self:tryCallMethodName("__onDispose")
end

function BaseView:_internalCall(method)
	if self._childViews then
		local temp = tabletool.copy(self._childViews)

		if self._childViews then
			for _, child in ipairs(self._childViews) do
				child[method .. "Internal"](child)
			end
		end

		self:tryCallMethodName(method)
	end
end

function BaseView:tryCallMethodName(method)
	local isOk, result = xpcall(self[method], __G__TRACKBACK__, self)

	self._tryCallResultDict = self._tryCallResultDict or {}
	self._tryCallResultDict[method] = isOk

	return isOk, result
end

function BaseView:isHasTryCallFail()
	if self._tryCallResultDict then
		for method, isOk in pairs(self._tryCallResultDict) do
			if isOk == false then
				return true
			end
		end
	end

	local temp = self._childViews

	if temp then
		local count = #temp

		for i = 1, count do
			local child = temp[i]

			if child and child:isHasTryCallFail() then
				return true
			end
		end
	end

	return false
end

function BaseView:onInitView()
	return
end

function BaseView:addEvents()
	return
end

function BaseView:onOpen()
	return
end

function BaseView:onOpenFinish()
	return
end

function BaseView:onUpdateParam()
	return
end

function BaseView:onClickModalMask()
	return
end

function BaseView:onClose()
	return
end

function BaseView:onCloseFinish()
	return
end

function BaseView:removeEvents()
	return
end

function BaseView:onDestroyView()
	return
end

function BaseView:getResInst(resPath, parentGO, name)
	return self.viewContainer:getResInst(resPath, parentGO, name)
end

function BaseView:closeThis()
	ViewMgr.instance:closeView(self.viewName, nil, true)
end

function BaseView:addChildView(view)
	if not view then
		return
	end

	if not isTypeOf(view, BaseView) then
		logError("addChildView fail, view must inherited from BaseView: " .. (view.__cname or "nil"))

		return
	end

	self._childViews = self._childViews or {}

	if not tabletool.indexOf(self._childViews, view) then
		table.insert(self._childViews, view)
		view:__onInit()

		view.viewGO = self.viewGO
		view.viewContainer = self.viewContainer
		view.viewName = self.viewName

		if self._has_onInitView then
			view:onInitViewInternal()
		end

		if self._has_addEvents then
			view:addEventsInternal()
		end

		if self._has_onOpen then
			view:onOpenInternal()
		end

		if self._has_onOpenFinish then
			view:onOpenFinishInternal()
		end
	end
end

return BaseView
