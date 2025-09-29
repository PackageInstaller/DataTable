-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitactivity/view/TimeLimitActivityEntranceViewPresentor.lua

module("logic.extensions.timelimitactivity.view.TimeLimitActivityEntranceViewPresentor", package.seeall)

local M = class("TimeLimitActivityEntranceViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Time_activities_time_activities_entry_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, TimeLimitActivityEntranceView.New())
	table.insert(views, MoneyView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
