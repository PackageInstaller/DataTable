-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingPreviewViewPresentor.lua

module("logic.extensions.containmentzone.view.FacilityHoldingPreviewViewPresentor", package.seeall)

local M = class("FacilityHoldingPreviewViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_facility_holding_facility_holding_preview_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Room)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FacilityHoldingPreviewView.New())

	return views
end

return M
