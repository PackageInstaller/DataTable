-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingPrototypeInfoViewPresentor.lua

module("logic.extensions.containmentzone.view.FacilityHoldingPrototypeInfoViewPresentor", package.seeall)

local M = class("FacilityHoldingPrototypeInfoViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_facility_holding_facility_holding_prototype_info_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Room)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FacilityHoldingPrototypeInfoView.New())
	table.insert(views, HouseTitleView.New())

	return views
end

return M
