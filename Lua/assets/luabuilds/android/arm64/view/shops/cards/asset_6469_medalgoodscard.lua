local MedalGoodsCard = class("MedalGoodsCard", import(".BaseGoodsCard"))

function MedalGoodsCard:Ctor(arg_1_1)
	MedalGoodsCard.super.Ctor(self, arg_1_1)

	self.limitCountLabelTF = findTF(self.tf, "count_contain/label"):GetComponent(typeof(Text))

	return
end

function MedalGoodsCard:update(arg_2_1)
	if self.goods ~= arg_2_1 then
		self.goods = arg_2_1

		self:Init()
	else
		self.goods = arg_2_1
	end

	self.limitCountLabelTF.text = i18n("activity_shop_exchange_count") .. self.goods.count .. "/" .. self.goods:GetLimit()

	local var_2_0 = self.goods:CanPurchase()

	setActive(self.mask, not var_2_0)
	setActive(self.selloutTag, not var_2_0)

	return
end

function MedalGoodsCard:Init()
	updateDrop(self.itemTF, (self.goods:GetDropInfo()))
	setScrollText(self.nameTxt, (self.goods:getConfig("goods_name")))
	setText(self.countTF, self.goods:getConfig("price"))
	GetImageSpriteFromAtlasAsync("props/medal", "", self.resIconTF)
	GetImageSpriteFromAtlasAsync(self.goods:getConfig("goods_icon"), "", self.itemIconTF)
	setActive(self.groupLocked, not self.goods:Selectable() and self.itemTF:Find("group_locked").gameObject.activeSelf)

	return
end

function MedalGoodsCard:OnDispose()
	self.goods = nil

	return
end

return MedalGoodsCard
