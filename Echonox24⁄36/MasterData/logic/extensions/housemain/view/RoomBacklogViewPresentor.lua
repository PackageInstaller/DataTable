-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/view/RoomBacklogViewPresentor.lua

module("logic.extensions.housemain.view.RoomBacklogViewPresentor", package.seeall)

local M = class("RoomBacklogViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_main_room_backlog_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RoomBacklogView.New())

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)
	table.insert(views, HouseTitleView.New())

	return views
end

return M
