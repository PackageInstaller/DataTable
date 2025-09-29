-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/manufacture/view/ManufactureSchemeViewPresentor.lua

module("logic.extensions.manufacture.view.ManufactureSchemeViewPresentor", package.seeall)

local M = class("ManufactureSchemeViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_facility_yield_plan_view,
		ResName.Room_facility_yield_facility_yield_plan_item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ManufactureSchemeView.New())
	table.insert(views, HouseTitleView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
