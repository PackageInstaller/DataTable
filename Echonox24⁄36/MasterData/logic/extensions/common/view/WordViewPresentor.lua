-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/WordViewPresentor.lua

module("logic.extensions.common.view.WordViewPresentor", package.seeall)

local M = class("WordViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Word_tips
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Top
end

function M:buildViews()
	local views = {}

	self._clickView = ToolTipsPointerDownHandlerComp.New()

	table.insert(views, self._clickView)
	table.insert(views, WordView.New())
	table.insert(views, ToolTipsFixTipsPosComp.New())

	return views
end

function M:_onCloseAnimationDone()
	if self._clickView._isDraging then
		self._clickView:simulateCloseWhenDraging()
	else
		M.super._onCloseAnimationDone(self)
	end
end

function M:closeWhenDragEnd()
	M.super._onCloseAnimationDone(self)
end

return M
