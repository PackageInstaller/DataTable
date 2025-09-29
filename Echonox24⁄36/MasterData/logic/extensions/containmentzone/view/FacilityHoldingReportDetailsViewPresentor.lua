-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingReportDetailsViewPresentor.lua

module("logic.extensions.containmentzone.view.FacilityHoldingReportDetailsViewPresentor", package.seeall)

local M = class("FacilityHoldingReportDetailsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_facility_holding_facility_holding_report_details_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Language)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FacilityHoldingReportDetailsView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
