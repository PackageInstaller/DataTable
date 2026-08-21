local var_0_0 = class("SkinEncoreLoginRePage", import(".SkinEncoreLoginPage"))

function var_0_0.GetTips(arg_1_0)
	return pg.gametip.SkinDiscountHelp_Carnival.tip
end

function var_0_0.GetCouponCountText(arg_2_0)
	return string.format("<color=#FFFFFF>%s</color>", arg_2_0.couponCount)
end

function var_0_0.GetGiftShopType(arg_3_0)
	return ChargeScene.TYPE_PICK
end

return var_0_0
