local MiniGameGoodsCard = class("MiniGameGoodsCard", import(".BaseGoodsCard"))

function MiniGameGoodsCard:Ctor(arg_1_1)
	MiniGameGoodsCard.super.Ctor(self, arg_1_1)
	setActive(self.selloutTag, true)
	onButton(self, self.mask, function()
		pg.TipsMgr.GetInstance():ShowTips(self.maskTip)

		return
	end, SFX_PANEL)

	return
end

function MiniGameGoodsCard:setGroupMask(arg_3_1)
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

function MiniGameGoodsCard:setLevelMask(arg_4_1)
	local var_4_0 = self.goodsVO:isLevelLimit(arg_4_1)

	if isActive(self.mask) then
		return
	end

	setActive(self.mask, var_4_0)

	if var_4_0 then
		setScrollText(self.levelTagText, tostring((self.goodsVO:getLevelLimit(arg_4_1))))
		setActive(self.levelTag, true)
		setActive(self.selloutTag, false)

		self.maskTip = i18n("charge_level_limit")
	end

	return
end

function MiniGameGoodsCard:update(arg_5_1)
	self.goodsVO = arg_5_1

	setActive(self.mask, not self.goodsVO:CanPurchase())
	setActive(self.stars, false)

	local var_5_0 = arg_5_1:GetDropInfo()

	updateDrop(self.itemTF, var_5_0)
	setScrollText(self.nameTxt, var_5_0:getConfig("name") or "")
	setText(self.limitCountLabelTF, i18n("activity_shop_exchange_count") .. arg_5_1:GetMaxCnt() .. "/" .. arg_5_1:getConfig("goods_purchase_limit"))
	setActive(self.limitCountLabelTF, true)
	setActive(self.discountTF, false)
	setText(self.countTF, math.ceil((arg_5_1:getConfig("price"))))
	GetSpriteFromAtlasAsync("ui/ShopsUI_atlas", "minigameRes", function(arg_6_0)
		self.resIconTF:GetComponent(typeof(Image)).sprite = arg_6_0

		return
	end)
	setActive(self.groupLocked, self.itemTF:Find("group_locked").gameObject.activeSelf)

	return
end

function MiniGameGoodsCard:OnDispose()
	self.goodsVO = nil

	return
end

return MiniGameGoodsCard
