-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesMainViewPresentor.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesMainViewPresentor", package.seeall)

local M = class("LivingFacilitiesMainViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_facility_live_room_live_entry_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LivingFacilitiesMainView.New())

	return views
end

return M
