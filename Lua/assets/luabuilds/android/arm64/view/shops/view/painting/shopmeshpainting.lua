local var_0_0 = class("ShopMeshPainting")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._painting = arg_1_1

	return
end

function var_0_0.Load(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	setShopPaintingPrefab(arg_2_0._painting, arg_2_1, arg_2_2 or "chuanwu")
	arg_2_3()

	return
end

function var_0_0.Action(arg_3_0, arg_3_1)
	return
end

function var_0_0.UnLoad(arg_4_0, arg_4_1)
	retShopPaintingPrefab(arg_4_0._painting, arg_4_1)

	return
end

return var_0_0
