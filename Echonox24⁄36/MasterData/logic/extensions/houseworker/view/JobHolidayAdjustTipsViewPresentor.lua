-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/JobHolidayAdjustTipsViewPresentor.lua

module("logic.extensions.houseworker.view.JobHolidayAdjustTipsViewPresentor", package.seeall)

local M = class("JobHolidayAdjustTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_schedule_room_adjust_workforce_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, JobHolidayAdjustTipsView.New())

	return views
end

return M
