-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/compositeview/CompositeViewComponent.lua

module("logic.common.viewlib.compositeview.CompositeViewComponent", package.seeall)

local M = class("CompositeViewComponent", ViewComponent)

function M:_initSubViews()
	return
end

function M:ctor()
	M.super.ctor(self)

	self._subViews = {}
end

function M:buildUI()
	self:_initSubViews()
	self:_setupSubViews()
	self:_notifySubViews(FunctionName.buildUI)
end

function M:destroyUI()
	self:_notifySubViews(FunctionName.destroyUI)
end

function M:bindEvents()
	self:_notifySubViews(FunctionName.bindEvents)
end

function M:unbindEvents()
	self:_notifySubViews(FunctionName.unbindEvents)
end

function M:onEnter()
	self:_notifySubViews(FunctionName.onEnter)
end

function M:onExit()
	self:_notifySubViews(FunctionName.onExit)
end

function M:onEnterFinished()
	self:_notifySubViews(FunctionName.onEnterFinished)
end

function M:onExitFinished()
	self:_notifySubViews(FunctionName.onExitFinished)
end

function M:_notifySubViews(functionName)
	for _, subView in ipairs(self._subViews) do
		subView[functionName](subView)
	end
end

function M:_setupSubViews()
	for _, subView in ipairs(self._subViews) do
		subView.mainGO = self.mainGO

		subView:setViewPresentor(self._viewPresentor)
	end
end

function M:_addSubView(viewComponent)
	table.insert(self._subViews, viewComponent)
end

function M:_getSubView(index)
	return self._subViews[index]
end

return M
