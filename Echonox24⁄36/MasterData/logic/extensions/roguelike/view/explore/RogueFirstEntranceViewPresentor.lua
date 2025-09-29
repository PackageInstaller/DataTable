-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueFirstEntranceViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueFirstEntranceViewPresentor", package.seeall)

local M = class("RogueFirstEntranceViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupother_rungroup_all_entry_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueFirstEntranceView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
