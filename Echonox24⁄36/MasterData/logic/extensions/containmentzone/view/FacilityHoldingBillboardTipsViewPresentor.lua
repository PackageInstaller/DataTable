-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingBillboardTipsViewPresentor.lua

module("logic.extensions.containmentzone.view.FacilityHoldingBillboardTipsViewPresentor", package.seeall)

local M = class("FacilityHoldingBillboardTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_facility_holding_facility_holding_billboard_tips,
		ResName.Room_facility_holding_facility_holding_billboard_item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FacilityHoldingBillboardTipsView.New())

	return views
end

return M
