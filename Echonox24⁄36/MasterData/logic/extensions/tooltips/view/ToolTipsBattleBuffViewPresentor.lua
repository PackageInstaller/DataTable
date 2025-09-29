-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsBattleBuffViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsBattleBuffViewPresentor", package.seeall)

local M = class("ToolTipsBattleBuffViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Tips_buff_tips,
		ViewlibResPath.BuffDetailItem1
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ToolTipsMaskComp.New())

	self._viewTips = ToolTipsBattleBuffView.New()

	table.insert(views, self._viewTips)
	table.insert(views, ToolTipsFixTipsPosComp.New())

	return views
end

function M:onClickOutside()
	ViewMgr.instance:close(ViewName.ToolTipsBattleBuffViewPresentor)
end

function M:getSelfWidth()
	return self._viewTips:getSelfWidth()
end

function M:getSelfHeight()
	return self._viewTips:getSelfHeight()
end

return M
