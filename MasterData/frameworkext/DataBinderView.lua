-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/view/databinder/DataBinderView.lua

module("frameworkext.lmvc.view.databinder.DataBinderView", package.seeall)

local DataBinderView = class("DataBinderView", ViewComponent)

function DataBinderView:ctor(dataProvider)
	DataBinderView.super.ctor(self)

	self._dataProvider = dataProvider
	self._isShow = false
	self._isDirty = true
end

function DataBinderView:buildUI()
	if self._dataProvider then
		self._dataProvider:setDataBinder(self)
	end
end

function DataBinderView:changeDataProvider(dataProvider)
	if self._dataProvider then
		self._dataProvider:setDataBinder(nil)
	end

	self._dataProvider = dataProvider

	if self._dataProvider then
		self._dataProvider:setDataBinder(self)
	end

	self._isDirty = true
end

function DataBinderView:onUpdateData()
	if self._isShow then
		self:refreshView()
	else
		self._isDirty = true
	end
end

function DataBinderView:destroyUI()
	self._dataProvider:setDataBinder(nil)

	self._dataProvider = nil
end

function DataBinderView:onEnter()
	self._isShow = true

	if self._isDirty then
		self:refreshView()
	end
end

function DataBinderView:onExitFinished()
	self._isShow = false
end

function DataBinderView:refreshView()
	self._isDirty = false
end

return DataBinderView
