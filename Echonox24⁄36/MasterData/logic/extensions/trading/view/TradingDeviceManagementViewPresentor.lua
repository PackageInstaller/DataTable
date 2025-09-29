-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingDeviceManagementViewPresentor.lua

module("logic.extensions.trading.view.TradingDeviceManagementViewPresentor", package.seeall)

local M = class("TradingDeviceManagementViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_facility_yield_details_view,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, TradingDeviceManagementView.New())
	table.insert(views, HouseTitleView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.HouseShowType))

	return views
end

return M
