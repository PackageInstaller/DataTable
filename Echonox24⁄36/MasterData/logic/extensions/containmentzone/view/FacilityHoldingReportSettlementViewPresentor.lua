-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingReportSettlementViewPresentor.lua

module("logic.extensions.containmentzone.view.FacilityHoldingReportSettlementViewPresentor", package.seeall)

local M = class("FacilityHoldingReportSettlementViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_facility_holding_facility_holding_report_settlement_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Room),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Language)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FacilityHoldingReportSettlementView.New())

	return views
end

return M
