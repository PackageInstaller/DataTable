local var_0_0 = class("ActivityShopPurchasePanel", import(".GuildShopPurchasePanel"))

function var_0_0.Show(arg_1_0, arg_1_1)
	var_0_0.super.Show(arg_1_0, arg_1_1)

	if arg_1_1.icon then
		GetImageSpriteFromAtlasAsync(arg_1_1.icon, "", arg_1_0.resIcon)
	end

	return
end

function var_0_0.SetConfirmCb(arg_2_0, arg_2_1)
	arg_2_0.confirmCallback = arg_2_1

	return
end

function var_0_0.OnConfirm(arg_3_0)
	if arg_3_0.confirmCallback then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.selectedList) do
			if not ({})[iter_3_1] then
				({})[iter_3_1] = 0
			end

			;({})[iter_3_1] = ({})[iter_3_1] + 1
		end

		for iter_3_2, iter_3_3 in pairs({}) do
			table.insert({}, {
				key = iter_3_2,
				value = iter_3_3
			})
		end

		arg_3_0.confirmCallback(arg_3_0.data.id, {}, #arg_3_0.selectedList)
	end

	return
end

return var_0_0
