-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/view/RoomBuildTaskViewPresentor.lua

module("logic.extensions.housemain.view.RoomBuildTaskViewPresentor", package.seeall)

local M = class("RoomBuildTaskViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_main_room_build_task_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RoomBuildTaskView.New())
	table.insert(views, HouseTitleView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
