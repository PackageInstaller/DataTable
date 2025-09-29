-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesAtmosValueTipViewPresentor.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesAtmosValueTipViewPresentor", package.seeall)

local M = class("LivingFacilitiesAtmosValueTipViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_atmosphere_value_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LivingFacilitiesAtmosValueTipView.New())

	return views
end

return M
