local GuildGoodsCard = class("GuildGoodsCard", import(".BaseGoodsCard"))

function GuildGoodsCard:Ctor(arg_1_1)
	GuildGoodsCard.super.Ctor(self, arg_1_1)
	setActive(self.limitCountLabelTF, true)

	return
end

function GuildGoodsCard:update(arg_2_1)
	if self.goodsVO ~= arg_2_1 then
		self.goodsVO = arg_2_1

		self:Init()
	else
		self.goodsVO = arg_2_1
	end

	setText(self.limitCountLabelTF, i18n("activity_shop_exchange_count") .. self.goodsVO.count .. "/" .. self.goodsVO:GetLimit())
	setActive(self.limitCountLabelTF, true)

	local var_2_0 = self.goodsVO:CanPurchase()

	setActive(self.mask, not var_2_0)
	setActive(self.selloutTag, not var_2_0)

	return
end

function GuildGoodsCard:Init()
	updateDrop(self.itemTF, (self.goodsVO:GetDropInfo()))
	setScrollText(self.nameTxt, (self.goodsVO:getConfig("goods_name")))
	setText(self.countTF, self.goodsVO:getConfig("price"))
	GetImageSpriteFromAtlasAsync("ui/share/msgbox_atlas", "res_guildicon", self.resIconTF)
	GetImageSpriteFromAtlasAsync(self.goodsVO:getConfig("goods_icon"), "", self.itemIconTF)
	setText(self.itemCountTF, self.goodsVO:getConfig("num"))

	local var_3_0 = self.goodsVO:getConfig("goods_rarity") or ItemRarity.Gray

	setImageSprite(self.itemIconBgTF, GetSpriteFromAtlas("weaponframes", "bg" .. ItemRarity.Rarity2Print(var_3_0)))
	setImageColor(self.itemIconFrameTF, Color.NewHex(ItemRarity.Rarity2FrameHexColor(var_3_0)))
	setActive(self.groupLocked, not self.goodsVO:Selectable() and self.itemTF:Find("group_locked").gameObject.activeSelf)

	return
end

function GuildGoodsCard:OnDispose()
	self.goodsVO = nil

	return
end

return GuildGoodsCard
