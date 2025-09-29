-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/JobScheduleAdjustTipsViewPresentor.lua

module("logic.extensions.houseworker.view.JobScheduleAdjustTipsViewPresentor", package.seeall)

local M = class("JobScheduleAdjustTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_schedule_room_adjust_workforce_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, JobScheduleAdjustTipsView.New())
	table.insert(views, HouseTitleView.New())

	return views
end

return M
