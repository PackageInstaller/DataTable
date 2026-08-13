class = var_0_10000

local var_0_0 = "MedalShopPurchasePanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuildShopPurchasePanel"))

function var_0_1.getUIName(arg_1_0)
	return "MedalShopPurchaseMsgUI"
end

function var_0_1.OnConfirm(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.emit

	NewShopMainMediator = var_1_10004

	var_2_1(var_2_0, var_1_10004.ON_MEDAL_SHOPPING, arg_2_0.data.id, arg_2_0.selectedList)

	return
end

return var_0_1
