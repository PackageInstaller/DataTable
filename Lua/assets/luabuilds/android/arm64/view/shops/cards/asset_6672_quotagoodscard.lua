local QuotaGoodsCard = class("QuotaGoodsCard", import(".BaseGoodsCard"))

function QuotaGoodsCard:update(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.goodsVO = arg_1_1

	local var_1_0 = self.goodsVO:canPurchase()

	setActive(self.mask, not var_1_0)
	setActive(self.limitTag, not var_1_0)
	onButton(self, self.mask, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("quota_shop_limit_error"))

		return
	end, SFX_PANEL)

	local var_1_1 = arg_1_1:getConfig("commodity_type")
	local var_1_2 = arg_1_1:getConfig("commodity_id")
	local var_1_3 = Drop.New({
		type = var_1_1,
		id = var_1_2,
		count = arg_1_1:getConfig("num")
	})

	updateDrop(self.itemTF, var_1_3)
	setScrollText(self.nameTxt, var_1_1 == DROP_TYPE_SKIN and (pg.ship_skin_template[var_1_2].name or "??") or var_1_3:getConfig("name") or "??")
	setText(self.countTF, arg_1_1:getConfig("resource_num"))
	GetImageSpriteFromAtlasAsync(Drop.New({
		type = arg_1_1:getConfig("resource_category"),
		id = arg_1_1:getConfig("resource_type")
	}):getIcon(), "", self.resIconTF)

	local var_1_5 = arg_1_1:GetLimitGoodCount()

	setText(self.limitCountLabelTF, i18n("quota_shop_owned") .. var_1_5 - math.min(arg_1_1:GetOwnedGoodCount(), var_1_5) .. "/" .. var_1_5)
	setActive(self.limitCountLabelTF, true)
	setActive(self.groupLocked, self.itemTF:Find("group_locked").gameObject.activeSelf)

	return
end

function QuotaGoodsCard:setAsLastSibling()
	self.tf:SetAsLastSibling()

	return
end

function QuotaGoodsCard:OnDispose()
	self.goodsVO = nil

	return
end

return QuotaGoodsCard
