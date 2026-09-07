local IslandTradeProductList4SellPage = class("IslandTradeProductList4SellPage", import(".IslandTradeProductListPage"))

function IslandTradeProductList4SellPage:GetPrice()
	return (self.island:GetTradeAgency():GetTodaySellPrice())
end

function IslandTradeProductList4SellPage:OnClick()
	self:emit(IslandTradePage.OPEN_CONFIRM_PAGE, IslandConst.TRADE_SELL)

	return
end

return IslandTradeProductList4SellPage
