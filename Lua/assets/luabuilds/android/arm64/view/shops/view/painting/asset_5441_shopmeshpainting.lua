local ShopMeshPainting = class("ShopMeshPainting")

function ShopMeshPainting:Ctor(arg_1_1)
	self._painting = arg_1_1

	return
end

function ShopMeshPainting:Load(arg_2_1, arg_2_2, arg_2_3)
	setShopPaintingPrefab(self._painting, arg_2_1, arg_2_2 or "chuanwu")
	arg_2_3()

	return
end

function ShopMeshPainting:Action(arg_3_1)
	return
end

function ShopMeshPainting:UnLoad(arg_4_1)
	retShopPaintingPrefab(self._painting, arg_4_1)

	return
end

return ShopMeshPainting
