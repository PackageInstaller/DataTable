-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueEntranceViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueEntranceViewPresentor", package.seeall)

local M = class("RogueEntranceViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupexplore_run_group_entrance_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueEntranceView.New())
	table.insert(views, TitleView.New():blockOrgBtn(true, false, false))

	return views
end

return M
