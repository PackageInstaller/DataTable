-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/hero/HouseHeroMoodRecordViewPresentor.lua

module("logic.extensions.house.view.hero.HouseHeroMoodRecordViewPresentor", package.seeall)

local M = class("HouseHeroMoodRecordViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_room_small_role_detail_tips,
		ResName.Room_room_small_role_detail_item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HouseHeroMoodRecordView.New())

	return views
end

return M
