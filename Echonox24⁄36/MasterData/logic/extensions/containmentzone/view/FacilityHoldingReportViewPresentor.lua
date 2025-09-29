-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingReportViewPresentor.lua

module("logic.extensions.containmentzone.view.FacilityHoldingReportViewPresentor", package.seeall)

local M = class("FacilityHoldingReportViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_facility_holding_facility_holding_report_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Language)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FacilityHoldingReportView.New())
	table.insert(views, HouseTitleView.New())

	return views
end

return M
