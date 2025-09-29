-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/tips/HouseHeroTipsViewPresentor.lua

module("logic.extensions.house.view.tips.HouseHeroTipsViewPresentor", package.seeall)

local M = class("HouseHeroTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_room_small_role_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HouseHeroTipsView.New())

	return views
end

return M
