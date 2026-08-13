class = var_0_10000

local var_0_0 = "ActivityShopPurchasePanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuildShopPurchasePanel"))

function var_0_1.Show(arg_1_0, arg_1_1)
	var_0_1.super.Show(arg_1_0, arg_1_1)

	if arg_1_1.icon then
		GetImageSpriteFromAtlasAsync = var_2

		var_2(arg_1_1.icon, "", arg_1_0.resIcon)
	end

	return
end

function var_0_1.SetConfirmCb(arg_2_0, arg_2_1)
	arg_2_0.confirmCallback = arg_2_1

	return
end

function var_0_1.OnConfirm(arg_3_0)
	if arg_3_0.confirmCallback then
		local var_3_0 = {}
		local var_3_1 = {}

		ipairs = var_1_10003

		for iter_3_0, iter_3_1 in var_1_10003(arg_3_0.selectedList) do
			if not var_3_1[iter_3_1] then
				var_3_1[iter_3_1] = 0
			end

			var_3_1[iter_3_1] = var_3_1[iter_3_1] + 1
		end

		pairs = var_3

		for iter_3_2, iter_3_3 in var_3(var_3_1) do
			table = var_1_10008

			var_1_10008.insert(var_3_0, {
				key = iter_3_2,
				value = iter_3_3
			})
		end

		arg_3_0.confirmCallback(arg_3_0.data.id, var_3_0, #arg_3_0.selectedList)
	end

	return
end

return var_0_1
