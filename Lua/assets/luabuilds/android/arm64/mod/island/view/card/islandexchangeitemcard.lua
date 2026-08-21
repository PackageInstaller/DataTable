local var_0_0 = class("IslandExchangeItemCard", import(".IslandItemCard"))

function var_0_0.Update(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.item = arg_1_1
	arg_1_0.nameTxt.text = arg_1_0:ShortenString(arg_1_1:GetName(), 6)

	updateCustomDrop(arg_1_0._tf, Drop.New({
		type = DROP_TYPE_ISLAND_ITEM,
		id = arg_1_1.id,
		count = arg_1_1:GetCount()
	}))
	arg_1_0:UpdateValue(arg_1_2)

	return
end

return var_0_0
