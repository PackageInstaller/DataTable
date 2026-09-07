local WorldGoodsCard = class("WorldGoodsCard", import(".BaseOldGoodsCard"))

function WorldGoodsCard:Ctor(arg_1_1)
	WorldGoodsCard.super.Ctor(self, arg_1_1)

	self.go = arg_1_1
	self.tr = tf(arg_1_1)
	self.mask = self.tr:Find("mask")
	self.selloutTag = self.tr:Find("mask/tag/sellout_tag")

	setText(self.selloutTag, i18n("common_sale_out"))

	self.levelTag = self.tr:Find("mask/tag/level_tag")

	setText(self.levelTag, i18n("shop_charge_level_limit"))

	self.levelTagText = self.tr:Find("mask/tag/level_tag/Text")
	self.stars = self.tr:Find("item/icon_bg/stars")
	self.itemTF = findTF(self.tr, "item")
	self.nameTxt = findTF(self.tr, "item/name_mask/name")
	self.discountTF = findTF(self.tr, "item/discount")
	self.discountTextTF = findTF(self.discountTF, "Text"):GetComponent(typeof(Text))
	self.countTF = findTF(self.tr, "item/consume/contain/Text"):GetComponent(typeof(Text))
	self.resIconTF = findTF(self.tr, "item/consume/contain/icon"):GetComponent(typeof(Image))
	self.itemIconTF = self.itemTF:Find("icon_bg/icon"):GetComponent(typeof(Image))
	self.itemCountTF = self.itemTF:Find("icon_bg/count"):GetComponent(typeof(Text))
	self.maskTip = i18n("buy_countLimit")

	onButton(self, self.mask, function()
		pg.TipsMgr.GetInstance():ShowTips(self.maskTip)

		return
	end, SFX_PANEL)

	return
end

function WorldGoodsCard:setGroupMask(arg_3_1)
	local var_3_0 = self.goodsVO:getConfig("group_limit")
	local var_3_1 = var_3_0 > 0 and var_3_0 <= arg_3_1

	if isActive(self.mask) then
		return
	end

	setActive(self.mask, var_3_1)

	if var_3_0 > 0 and var_3_0 <= arg_3_1 then
		setActive(self.selloutTag, true)
		setActive(self.levelTag, false)
	end

	return
end

function WorldGoodsCard:setLevelMask(arg_4_1)
	local var_4_0 = self.goodsVO:isLevelLimit(arg_4_1)

	if isActive(self.mask) then
		return
	end

	setActive(self.mask, var_4_0)

	if var_4_0 then
		setText(self.levelTagText, tostring((self.goodsVO:getLevelLimit(arg_4_1))))
		setActive(self.levelTag, true)
		setActive(self.selloutTag, false)

		self.maskTip = i18n("charge_level_limit")
	end

	return
end

function WorldGoodsCard:update(arg_5_1)
	self.goodsVO = arg_5_1

	local var_5_0 = self.goodsVO:canPurchase()

	setActive(self.mask, not var_5_0)
	setActive(self.selloutTag, not var_5_0)
	setActive(self.stars, false)

	local var_5_1 = arg_5_1:getDropInfo()

	updateDrop(self.itemTF, var_5_1)
	setText(self.nameTxt, shortenString(var_5_1:getConfig("name") or "", 6))

	local var_5_2 = ""
	local var_5_3 = arg_5_1:getConfig("resource_num")

	if arg_5_1:getConfig("genre") == ShopArgs.ShoppingStreetLimit then
		var_5_2 = 100 - arg_5_1.discount .. "%OFF"
		var_5_3 = var_5_3 * (arg_5_1.discount / 100)
	end

	setActive(self.discountTF, false)

	self.discountTF = arg_5_1.activityDiscount and findTF(self.tr, "item/discount_activity") or findTF(self.tr, "item/discount")
	self.discountTextTF = findTF(self.discountTF, "Text"):GetComponent(typeof(Text))

	setActive(self.discountTF, arg_5_1:hasDiscount())

	self.discountTextTF.text = var_5_2
	self.countTF.text = math.ceil(var_5_3)

	GetImageSpriteFromAtlasAsync(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = arg_5_1:getConfig("resource_type")
	}):getIcon(), "", tf(self.resIconTF))

	return
end

function WorldGoodsCard:OnDispose()
	self.goodsVO = nil

	return
end

return WorldGoodsCard
