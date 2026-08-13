class = var_0_10000

local var_0_0 = "SportAndRacingSkinEncoreLoginPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SkinEncoreLoginPage"))

function var_0_1.GetTips(arg_1_0)
	pg = var_1_10001

	return var_1_10001.gametip.SkinDiscountHelp_Carnival.tip
end

function var_0_1.GetCouponCountText(arg_2_0)
	string = var_1_10001

	return var_1_10001.format("<color=#FFFFFF>%s</color>", arg_2_0.couponCount)
end

function var_0_1.GetGiftShopType(arg_3_0)
	ChargeScene = var_1_10001

	return var_1_10001.TYPE_PICK
end

return var_0_1
