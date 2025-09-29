-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonNewReportViewPresentor.lua

module("logic.extensions.season.view.SeasonNewReportViewPresentor", package.seeall)

local M = class("SeasonNewReportViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Secret_secret_time_judge_report_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, SeasonNewReportView.New())

	return views
end

return M
