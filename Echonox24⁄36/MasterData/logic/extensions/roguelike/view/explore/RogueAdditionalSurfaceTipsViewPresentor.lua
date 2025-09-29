-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueAdditionalSurfaceTipsViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueAdditionalSurfaceTipsViewPresentor", package.seeall)

local M = class("RogueAdditionalSurfaceTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupexplore_additional_surface_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueAdditionalSurfaceTipsView.New())

	return views
end

return M
