-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingUnlockConditionTipsViewPresentor.lua

module("logic.extensions.containmentzone.view.FacilityHoldingUnlockConditionTipsViewPresentor", package.seeall)

local M = class("FacilityHoldingUnlockConditionTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_facility_holding_facility_holding_unlock_condition_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FacilityHoldingUnlockConditionTipsView.New())

	return views
end

return M
