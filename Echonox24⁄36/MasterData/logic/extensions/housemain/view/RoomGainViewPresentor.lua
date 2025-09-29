-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/view/RoomGainViewPresentor.lua

module("logic.extensions.housemain.view.RoomGainViewPresentor", package.seeall)

local M = class("RoomGainViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_main_room_gain_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RoomGainView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
