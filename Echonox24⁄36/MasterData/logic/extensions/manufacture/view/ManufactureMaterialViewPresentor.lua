-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/manufacture/view/ManufactureMaterialViewPresentor.lua

module("logic.extensions.manufacture.view.ManufactureMaterialViewPresentor", package.seeall)

local M = class("ManufactureMaterialViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_room_orders_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ManufactureMaterialView.New())
	table.insert(views, HouseTitleView.New())

	return views
end

return M
