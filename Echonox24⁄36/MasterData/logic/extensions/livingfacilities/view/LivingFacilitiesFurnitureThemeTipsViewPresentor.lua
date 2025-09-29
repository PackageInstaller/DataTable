-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesFurnitureThemeTipsViewPresentor.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesFurnitureThemeTipsViewPresentor", package.seeall)

local M = class("LivingFacilitiesFurnitureThemeTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_facility_live_furniture_theme_detail_tips,
		ResName.Room_facility_live_theme_item,
		ResName.Room_facility_live_live_furniture_item1
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LivingFacilitiesFurnitureThemeTipsView.New())

	return views
end

return M
