-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/FootballRankViewPresentor.lua

module("logic.extensions.football.view.FootballRankViewPresentor", package.seeall)

local M = class("FootballRankViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Football_football_ranking_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FootballRankView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
