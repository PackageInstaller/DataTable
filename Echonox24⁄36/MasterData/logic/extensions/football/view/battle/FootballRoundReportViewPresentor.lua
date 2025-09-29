-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/battle/FootballRoundReportViewPresentor.lua

module("logic.extensions.football.view.battle.FootballRoundReportViewPresentor", package.seeall)

local M = class("FootballRoundReportViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Battle_pvp_bout_view
	}
end

function M:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function M:buildViews()
	local views = {}

	table.insert(views, FootballRoundReportView.New())

	return views
end

return M
