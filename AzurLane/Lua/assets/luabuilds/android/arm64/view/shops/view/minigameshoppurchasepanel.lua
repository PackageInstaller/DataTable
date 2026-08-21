local var_0_0 = class("MiniGameShopPurchasePanel", import(".GuildShopPurchasePanel"))

function var_0_0.getUIName(arg_1_0)
	return "MiniGameShopPurchaseMsgUI"
end

function var_0_0.Show(arg_2_0, arg_2_1)
	var_0_0.super.Show(arg_2_0, arg_2_1)

	arg_2_0.confirmCallback = arg_2_1.confirm

	return
end

function var_0_0.OnConfirm(arg_3_0)
	if arg_3_0.confirmCallback then
		arg_3_0.confirmCallback(arg_3_0.data.id, arg_3_0.selectedList)
	end

	return
end

return var_0_0
