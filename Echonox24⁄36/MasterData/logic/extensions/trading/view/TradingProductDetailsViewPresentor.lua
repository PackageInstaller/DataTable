-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingProductDetailsViewPresentor.lua

module("logic.extensions.trading.view.TradingProductDetailsViewPresentor", package.seeall)

local M = class("TradingProductDetailsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_trade_center_sold_tips,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, TradingProductDetailsView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.OnlyMoneyShowType))

	return views
end

return M
