local var_0_0 = class("IslandTradeProductList4SellPage", import(".IslandTradeProductListPage"))

function var_0_0.GetPrice(arg_1_0)
	return (arg_1_0.island:GetTradeAgency():GetTodaySellPrice())
end

function var_0_0.OnClick(arg_2_0)
	arg_2_0:emit(IslandTradePage.OPEN_CONFIRM_PAGE, IslandConst.TRADE_SELL)

	return
end

return var_0_0
