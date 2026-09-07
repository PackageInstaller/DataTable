local NewServerGoodsCard = class("NewServerGoodsCard")

function NewServerGoodsCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self._tr = arg_1_1.transform
	self.itemTF = self._tr:Find("item")
	self.itemIconBgTF = self.itemTF:Find("icon_bg")
	self.itemIconFrameTF = self.itemTF:Find("icon_bg/frame")
	self.itemIconTF = self.itemTF:Find("icon_bg/icon")
	self.itemCountTF = self.itemTF:Find("icon_bg/count"):GetComponent(typeof(Text))
	self.discountTF = self._tr:Find("item/discount")
	self.nameTF = self._tr:Find("item/name_mask/name"):GetComponent(typeof(Text))
	self.consumeIconTF = self._tr:Find("item/consume/contain/icon")
	self.consumeTxtTF = self._tr:Find("item/consume/contain/Text"):GetComponent(typeof(Text))
	self.sellOutMaskTF = self._tr:Find("selloutmask")
	self.levelMaskTF = self._tr:Find("levelmask")
	self.cntTxt = self._tr:Find("item/count_contain/count"):GetComponent(typeof(Text))

	setActive(self.discountTF, false)
	setText(self.sellOutMaskTF:Find("ch"), i18n("word_sell_out"))
	setText(self.levelMaskTF:Find("ch"), i18n("word_sell_lock"))
	setText(self._tr:Find("item/count_contain/label"), i18n("activity_shop_exchange_count"))

	return
end

function NewServerGoodsCard:Update(arg_2_1, arg_2_2)
	self.shop = arg_2_2

	if arg_2_1 ~= self.commodity then
		self.commodity = arg_2_1

		self:Init()
		self:Flush()
	else
		self.commodity = arg_2_1

		self:Flush()
	end

	return
end

function NewServerGoodsCard:Flush()
	self.cntTxt.text = self.commodity:GetCanPurchaseCnt() .. "/" .. self.commodity:GetCanPurchaseMaxCnt()

	setActive(self.sellOutMaskTF, not self.commodity:CanPurchase())
	setActive(self.levelMaskTF, not self.commodity:IsOpening(self.shop:GetStartTime()))

	return
end

function NewServerGoodsCard:Init()
	local var_4_0 = self.commodity:GetDesc()

	if string.match(var_4_0.name, "(%d+)") then
		setText(self.nameTF, shortenString(var_4_0.name, 5))
	else
		setText(self.nameTF, shortenString(var_4_0.name, 6))
	end

	local var_4_1 = self.commodity:GetConsume()

	self.consumeTxtTF.text = var_4_1.count

	GetImageSpriteFromAtlasAsync(var_4_1:getConfig("icon"), "", self.consumeIconTF)

	self.itemCountTF.text = self.commodity:GetDropCnt()

	GetImageSpriteFromAtlasAsync(var_4_0.icon, "", self.itemIconTF)

	local var_4_2 = var_4_0.rarity or ItemRarity.Gray

	setImageSprite(self.itemIconBgTF, GetSpriteFromAtlas("weaponframes", "bg" .. ItemRarity.Rarity2Print(var_4_2)))
	setImageColor(self.itemIconFrameTF, Color.NewHex(ItemRarity.Rarity2FrameHexColor(var_4_2)))

	return
end

function NewServerGoodsCard:Dispose()
	return
end

return NewServerGoodsCard
