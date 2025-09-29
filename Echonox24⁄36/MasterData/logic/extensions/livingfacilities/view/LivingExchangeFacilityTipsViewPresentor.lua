-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingExchangeFacilityTipsViewPresentor.lua

module("logic.extensions.livingfacilities.view.LivingExchangeFacilityTipsViewPresentor", package.seeall)

local M = class("LivingExchangeFacilityTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_facility_live_living_exchange_facility_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LivingExchangeFacilityTipsView.New())

	return views
end

return M
