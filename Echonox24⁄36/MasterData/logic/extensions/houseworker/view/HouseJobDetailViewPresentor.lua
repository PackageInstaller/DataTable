-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/HouseJobDetailViewPresentor.lua

module("logic.extensions.houseworker.view.HouseJobDetailViewPresentor", package.seeall)

local M = class("HouseJobDetailViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_schedule_room_adjust_schedule_view2
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HouseJobDetailView.New())
	table.insert(views, HouseTitleView.New())

	return views
end

return M
