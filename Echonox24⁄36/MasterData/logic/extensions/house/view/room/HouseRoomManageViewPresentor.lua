-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/room/HouseRoomManageViewPresentor.lua

module("logic.extensions.house.view.room.HouseRoomManageViewPresentor", package.seeall)

local M = class("HouseRoomManageViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_main_room_facility_manage_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HouseRoomManageView.New())
	table.insert(views, HouseTitleView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
