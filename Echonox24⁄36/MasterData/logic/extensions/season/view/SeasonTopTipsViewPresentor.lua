-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonTopTipsViewPresentor.lua

module("logic.extensions.season.view.SeasonTopTipsViewPresentor", package.seeall)

local M = class("SeasonTopTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Season_fcpy_top_active_hint
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Top
end

function M:buildViews()
	local views = {}

	table.insert(views, SeasonTopTipsView.New())

	return views
end

return M
