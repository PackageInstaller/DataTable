-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/FootballQTEViewPresentor.lua

module("logic.extensions.football.view.FootballQTEViewPresentor", package.seeall)

local M = class("FootballQTEViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Football_football_click_view1
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FootballQTEView.New())

	return views
end

return M
