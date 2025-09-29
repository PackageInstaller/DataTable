-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/supervisor/view/SupervisorDetailViewPresentor.lua

module("logic.extensions.supervisor.view.SupervisorDetailViewPresentor", package.seeall)

local M = class("SupervisorDetailViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_facility_yield_details_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, SupervisorDetailView.New())
	table.insert(views, HouseTitleView.New())

	return views
end

return M
