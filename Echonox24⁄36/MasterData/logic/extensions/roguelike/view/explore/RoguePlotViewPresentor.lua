-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RoguePlotViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RoguePlotViewPresentor", package.seeall)

local M = class("RoguePlotViewPresentor", ViewPresentor)

M.Url_View = ResName.Run_group_plot_view

function M:dependWhatResources()
	return {
		M.Url_View
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RoguePlotView.New())

	return views
end

return M
