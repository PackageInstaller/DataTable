local ChargeGoodsCard = class("ChargeGoodsCard", import("...shops.cards.GoodsCard"))

function ChargeGoodsCard:update(arg_1_1)
	self.goodsVO = arg_1_1

	setActive(self.mask, not self.goodsVO:canPurchase())
	setActive(self.stars, false)

	local var_1_0 = arg_1_1:getDropInfo()

	updateDrop(self.itemTF, var_1_0)
	setScrollText(self.nameTxt, var_1_0:getConfig("name") or "")
	setActive(self.discountTF, arg_1_1:isDisCount())
	setText(self.discountTextTF, arg_1_1:getConfig("discount") .. "%OFF")
	setText(self.countTF, math.ceil((arg_1_1:GetPrice())))
	GetImageSpriteFromAtlasAsync(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = arg_1_1:getConfig("resource_type")
	}):getIcon(), "", tf(self.resIconTF), false)

	return
end

return ChargeGoodsCard
