-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/handbook/RogueHandBookPropTipsViewPresentor.lua

module("logic.extensions.roguelike.view.explore.handbook.RogueHandBookPropTipsViewPresentor", package.seeall)

local M = class("RogueHandBookPropTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungrouphandbook_run_group_prop_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueHandBookPropTipsView.New())

	return views
end

return M
