local GoodsCard = class("GoodsCard", import(".BaseGoodsCard"))

function GoodsCard:Ctor(arg_1_1)
	GoodsCard.super.Ctor(self, arg_1_1)
	onButton(self, self.mask, function()
		pg.TipsMgr.GetInstance():ShowTips(self.maskTip)

		return
	end, SFX_PANEL)

	return
end

function GoodsCard:setGroupMask(arg_3_1)
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

function GoodsCard:setLevelMask(arg_4_1)
	local var_4_0 = self.goodsVO:isLevelLimit(arg_4_1)

	if isActive(self.mask) then
		return
	end

	setActive(self.mask, var_4_0)

	if var_4_0 then
		setScrollText(self.levelTag:Find("TextGo/Text"), tostring((self.goodsVO:getLevelLimit(arg_4_1))) .. i18n("shop_charge_level_limit"))
		setActive(self.levelTag, true)
		setActive(self.selloutTag, false)

		self.maskTip = i18n("charge_level_limit")
	end

	return
end

function GoodsCard:update(arg_5_1, arg_5_2)
	setActive(self.limitCountLabelTF, false)

	self.goodsVO = arg_5_1

	local var_5_0 = self.goodsVO:canPurchase()

	setActive(self.mask, not var_5_0)
	setActive(self.selloutTag, not var_5_0)
	setActive(self.stars, false)

	local var_5_1 = arg_5_1:getDropInfo()

	updateDrop(self.itemTF, var_5_1)
	setScrollText(self.nameTxt, var_5_1:getConfig("name") or "")

	local var_5_2 = ""
	local var_5_3 = arg_5_1:getConfig("resource_num")

	if arg_5_1:getConfig("genre") == ShopArgs.ShoppingStreetLimit then
		var_5_2 = 100 - arg_5_1.discount .. "%OFF"
		var_5_3 = var_5_3 * (arg_5_1.discount / 100)
	end

	setActive(self.discountTF, arg_5_1:hasDiscount())
	setText(self.discountTextTF, var_5_2)
	setText(self.countTF, math.ceil(var_5_3))
	GetImageSpriteFromAtlasAsync(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = arg_5_1:getConfig("resource_type")
	}):getIcon(), "", tf(self.resIconTF))
	setActive(self.groupLocked, self.itemTF:Find("group_locked").gameObject.activeSelf)

	return
end

function GoodsCard:OnDispose()
	self.goodsVO = nil

	return
end

return GoodsCard
