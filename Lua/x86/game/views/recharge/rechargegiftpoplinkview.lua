local var_0_0 = import("game.views.recharge.RechargeGiftPopView")
local var_0_1 = class("RechargeGiftPopLinkView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	local var_1_0 = arg_1_0.params_.shopId
	local var_1_1 = arg_1_0.params_.goodId
	local var_1_2 = getShopCfg(var_1_1, var_1_0)
	local var_1_3 = ItemCfg[var_1_2.give_id]
	local var_1_4 = RechargeShopDescriptionCfg[var_1_2.description]

	arg_1_0.params_.itemCfg = var_1_3
	arg_1_0.params_.shopCfg = var_1_2
	arg_1_0.params_.itemDesCfg_ = var_1_4
	arg_1_0.params_.buyTime = ShopData.GetShop(var_1_0)[var_1_1] ~= nil and ShopData.GetShop(var_1_0)[var_1_1].buy_times or 0

	var_0_1.super.OnEnter(arg_1_0)
end

return var_0_1
