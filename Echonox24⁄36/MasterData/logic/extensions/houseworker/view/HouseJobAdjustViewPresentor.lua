-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/HouseJobAdjustViewPresentor.lua

module("logic.extensions.houseworker.view.HouseJobAdjustViewPresentor", package.seeall)

local M = class("HouseJobAdjustViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_schedule_room_adjust_schedule_view1,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Room)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HouseJobAdjustView.New())
	table.insert(views, HouseTitleView.New())

	return views
end

return M
