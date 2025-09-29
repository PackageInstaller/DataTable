-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/HouseDormAdjustViewPresentor.lua

module("logic.extensions.houseworker.view.HouseDormAdjustViewPresentor", package.seeall)

local M = class("HouseDormAdjustViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_schedule_room_adjust_schedule_view1
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HouseDormAdjustView.New())
	table.insert(views, HouseTitleView.New())

	return views
end

return M
