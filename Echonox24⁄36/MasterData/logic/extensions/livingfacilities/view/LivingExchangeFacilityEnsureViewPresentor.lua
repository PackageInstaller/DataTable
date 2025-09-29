-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingExchangeFacilityEnsureViewPresentor.lua

module("logic.extensions.livingfacilities.view.LivingExchangeFacilityEnsureViewPresentor", package.seeall)

local M = class("LivingExchangeFacilityEnsureViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_facility_live_living_exchange_facility_dorm_tips,
		ViewlibResPath.HeroHeadItem,
		ResName.Common_Backpack_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LivingExchangeFacilityEnsureView.New())

	return views
end

return M
