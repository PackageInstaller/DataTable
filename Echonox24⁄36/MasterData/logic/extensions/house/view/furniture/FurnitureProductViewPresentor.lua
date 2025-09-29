-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/furniture/FurnitureProductViewPresentor.lua

module("logic.extensions.house.view.furniture.FurnitureProductViewPresentor", package.seeall)

local M = class("FurnitureProductViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_live_furniture_fabricate_expend_tips,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FurnitureProductView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.HouseShowType))

	return views
end

return M
