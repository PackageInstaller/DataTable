-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/manufacture/view/ManufactureDetailViewPresentor.lua

module("logic.extensions.manufacture.view.ManufactureDetailViewPresentor", package.seeall)

local M = class("ManufactureDetailViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_facility_yield_details_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ManufactureDetailView.New())
	table.insert(views, HouseTitleView.New())

	return views
end

return M
