-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingOrderViewPresentor.lua

module("logic.extensions.trading.view.TradingOrderViewPresentor", package.seeall)

local M = class("TradingOrderViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_trade_order_view,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, TradingOrderView.New())
	table.insert(views, HouseTitleView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.HouseShowType))

	return views
end

return M
