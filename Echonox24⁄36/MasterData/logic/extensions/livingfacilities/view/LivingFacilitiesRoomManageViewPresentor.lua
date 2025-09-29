-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesRoomManageViewPresentor.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesRoomManageViewPresentor", package.seeall)

local M = class("LivingFacilitiesRoomManageViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_facility_live_room_live_manage_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LivingFacilitiesRoomManageView.New())

	return views
end

return M
