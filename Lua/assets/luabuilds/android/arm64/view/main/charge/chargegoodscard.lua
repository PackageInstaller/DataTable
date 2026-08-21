local var_0_0 = class("ChargeGoodsCard", import("...shops.cards.GoodsCard"))

function var_0_0.update(arg_1_0, arg_1_1)
	arg_1_0.goodsVO = arg_1_1

	setActive(arg_1_0.mask, not arg_1_0.goodsVO:canPurchase())
	setActive(arg_1_0.stars, false)

	local var_1_0 = arg_1_1:getDropInfo()

	updateDrop(arg_1_0.itemTF, var_1_0)

	local var_1_1 = var_1_0:getConfig("name") or ""

	setScrollText(arg_1_0.nameTxt, var_1_1)
	setActive(arg_1_0.discountTF, arg_1_1:isDisCount())
	setText(arg_1_0.discountTextTF, arg_1_1:getConfig("discount") .. "%OFF")
	setText(arg_1_0.countTF, math.ceil((arg_1_1:GetPrice())))
	GetImageSpriteFromAtlasAsync(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = arg_1_1:getConfig("resource_type")
	}):getIcon(), "", tf(arg_1_0.resIconTF), false)

	return
end

return var_0_0
