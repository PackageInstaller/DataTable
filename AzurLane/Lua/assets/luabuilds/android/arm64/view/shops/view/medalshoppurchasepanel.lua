local var_0_0 = class("MedalShopPurchasePanel", import(".GuildShopPurchasePanel"))

function var_0_0.getUIName(arg_1_0)
	return "MedalShopPurchaseMsgUI"
end

function var_0_0.OnConfirm(arg_2_0)
	arg_2_0:emit(NewShopMainMediator.ON_MEDAL_SHOPPING, arg_2_0.data.id, arg_2_0.selectedList)

	return
end

return var_0_0
