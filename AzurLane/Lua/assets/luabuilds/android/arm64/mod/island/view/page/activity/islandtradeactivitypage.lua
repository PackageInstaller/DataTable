class = var_0_10000

local var_0_0 = "IslandTradeActivityPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.View.page.activity.IslandBaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	setText = var_1_10001

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.Find(var_1_0, "bg/desc_1")

	i18n = var_1_10004

	var_1_10001(var_1_1, var_1_10004("island_trade_activity_desc_1"))

	setText = var_1_10001

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_3.Find(var_1_2, "bg/desc_2")

	i18n = var_4

	var_1_10001(var_1_3, var_4("island_trade_activity_desc_2"))

	setText = var_1_10001

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_3.Find(var_1_4, "bg/level/Text")

	i18n = var_4

	var_1_10001(var_1_5, var_4("island_trade_activity_unlock"))

	return
end

return var_0_1
