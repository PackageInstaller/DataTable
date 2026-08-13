class = var_0_10000

local var_0_0 = "IslandTradeProductList4SellPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandTradeProductListPage"))

function var_0_1.GetPrice(arg_1_0)
	local var_1_0 = arg_1_0.island
	local var_1_1 = var_1.GetTradeAgency(var_1_0)

	return (var_1.GetTodaySellPrice(var_1_1))
end

function var_0_1.OnClick(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.emit

	IslandTradePage = var_1_10004

	local var_2_2 = var_1_10004.OPEN_CONFIRM_PAGE

	IslandConst = var_1_10005

	var_2_1(var_2_0, var_2_2, var_1_10005.TRADE_SELL)

	return
end

return var_0_1
