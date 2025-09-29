-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsUseItemViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsUseItemViewPresentor", package.seeall)

local M = class("ToolTipsUseItemViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Backpack_health_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ToolTipsUseItemComp.New())
	table.insert(views, BlurBgView.New())

	return views
end

function M:onClickOutside()
	ViewMgr.instance:close(ViewName.UseItemTipsView)
end

return M
