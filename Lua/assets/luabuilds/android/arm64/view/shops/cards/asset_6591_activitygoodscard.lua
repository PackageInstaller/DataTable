local ActivityGoodsCard = class("ActivityGoodsCard", import(".BaseGoodsCard"))

ActivityGoodsCard.Color = {}
ActivityGoodsCard.DefaultColor = {
	0.8745098039215686,
	0.9294117647058824,
	1
}

function ActivityGoodsCard:Ctor(arg_1_1)
	ActivityGoodsCard.super.Ctor(self, arg_1_1)

	self.limitTimeSellTF = findTF(self.tf, "limit_time_sell")

	setActive(self.limitTimeSellTF, false)

	self.limitPassTag = self.tf:Find("mask/tag/pass_tag")

	return
end

function ActivityGoodsCard:update(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_1:Selectable() then
		self:updateSelectable(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	else
		self:updateSingle(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end

	return
end

function ActivityGoodsCard:updateSingle(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self.goodsVO = arg_3_1

	local var_3_0 = self.goodsVO:CheckCntLimit()
	local var_3_1 = var_3_0 and not self.goodsVO:CheckArgLimit()
	local var_3_2 = false

	setActive(self.mask, not var_3_0 or var_3_1)
	setActive(self.selloutTag, false)

	if self.limitPassTag then
		setActive(self.limitPassTag, false)
	end

	setActive(self.unexchangeTag, false)
	removeOnButton(self.mask)

	if var_3_1 then
		local var_3_3, var_3_4, var_3_5 = self.goodsVO:CheckArgLimit()

		if var_3_4 == "pass" then
			setActive(self.limitPassTag, true)
			setScrollText(findTF(self.limitPassTag, "TextGo/Text"), i18n("eventshop_unlock_info", var_3_5))
			onButton(self, self.mask, function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("eventshop_unlock_hint", var_3_5))

				return
			end, SFX_PANEL)
		else
			setScrollText(self.unexchangeTag:Find("TextGo/Text"), var_3_5)

			var_3_2 = true
		end
	end

	if not var_3_0 then
		setActive(self.selloutTag, true)
	elseif var_3_2 then
		setActive(self.unexchangeTag, true)
	end

	local var_3_6 = Drop.New({
		type = arg_3_1:getConfig("commodity_type"),
		id = arg_3_1:getConfig("commodity_id"),
		count = arg_3_1:getConfig("num")
	})

	updateDrop(self.itemTF, var_3_6)
	setActive(self.limitTimeSellTF, false)

	if var_3_0 then
		local var_3_7, var_3_8, var_3_9 = self.goodsVO:CheckTimeLimit()

		setActive(self.limitTimeSellTF, var_3_7 and var_3_8)

		if var_3_7 and not var_3_8 then
			setActive(self.mask, true)
			setActive(self.sellEndTag, true)
			removeOnButton(self.mask)
			onButton(self, self.mask, function()
				if var_3_9 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("tip_build_ticket_exchange_expired", var_3_6:getName()))
				end

				return
			end, SFX_PANEL)
		end
	end

	GetSpriteFromAtlasAsync(Drop.New({
		type = arg_3_1:getConfig("resource_category"),
		id = arg_3_1:getConfig("resource_type")
	}):getIcon(), "", function(arg_6_0)
		self.resIconTF.sprite = arg_6_0

		return
	end)
	setText(self.countTF, arg_3_1:getConfig("resource_num"))
	setScrollText(self.nameTxt, var_3_6:getName() or "??")

	local var_3_10 = arg_3_1:getConfig("num_limit")

	if var_3_10 == 0 then
		setText(self.limitCountLabelTF, i18n("common_no_limit"))
	else
		setText(self.limitCountLabelTF, i18n("activity_shop_exchange_count") .. math.max(arg_3_1:GetPurchasableCnt(), 0) .. "/" .. var_3_10)
	end

	setActive(self.limitCountLabelTF, true)
	setActive(self.groupLocked, self.itemTF:Find("group_locked").gameObject.activeSelf)

	return
end

function ActivityGoodsCard:updateSelectable(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self.goodsVO = arg_7_1

	local var_7_0 = Drop.New({
		count = 1,
		type = DROP_TYPE_ITEM,
		id = arg_7_1:getConfig("commodity_id_list_show")
	})

	updateDrop(self.itemTF, var_7_0)
	setActive(self.mask, false)
	setActive(self.selloutTag, false)

	if self.limitPassTag then
		setActive(self.limitPassTag, false)
	end

	removeOnButton(self.mask)
	setActive(self.limitTimeSellTF, false)
	GetSpriteFromAtlasAsync(Drop.New({
		type = arg_7_1:getConfig("resource_category"),
		id = arg_7_1:getConfig("resource_type")
	}):getIcon(), "", function(arg_8_0)
		self.resIconTF.sprite = arg_8_0

		return
	end)
	setText(self.countTF, arg_7_1:getConfig("resource_num"))
	setScrollText(self.nameTxt, var_7_0:getName() or "??")

	local var_7_1 = arg_7_1:getConfig("num_limit")

	if var_7_1 == 0 then
		setText(self.limitCountLabelTF, i18n("common_no_limit"))
	else
		setText(self.limitCountLabelTF, i18n("activity_shop_exchange_count") .. math.max(arg_7_1:GetPurchasableCnt(), 0) .. "/" .. var_7_1)
	end

	setActive(self.groupLocked, self.itemTF:Find("group_locked").gameObject.activeSelf)

	return
end

function ActivityGoodsCard:setAsLastSibling()
	self.tf:SetAsLastSibling()

	return
end

function ActivityGoodsCard:StaticUpdate(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = tf(self)
	local var_10_1 = findTF(var_10_0, "itemBg/item")

	setActive(findTF(var_10_0, "discount"), false)

	local var_10_2 = findTF(var_10_0, "count_contain/label"):GetComponent(typeof(Text))
	local var_10_3, var_10_4 = arg_10_1:canPurchase()

	setActive(var_10_0:Find("mask"), not var_10_3)
	setActive(var_10_0:Find("mask/tag/sellout_tag"), not var_10_3)

	local var_10_5 = Drop.New({
		type = arg_10_1:getConfig("commodity_type"),
		id = arg_10_1:getConfig("commodity_id"),
		count = arg_10_1:getConfig("num")
	})

	updateDrop(var_10_1, var_10_5)

	local var_10_6 = var_10_5:getConfig("name") or "??"

	findTF(var_10_0, "consume/contain/Text"):GetComponent(typeof(Text)).text = arg_10_1:getConfig("resource_num")

	setScrollText(findTF(var_10_0, "name_mask/name"), var_10_6)
	GetImageSpriteFromAtlasAsync(Drop.New({
		type = arg_10_1:getConfig("resource_category"),
		id = arg_10_1:getConfig("resource_type")
	}):getIcon(), "", (findTF(var_10_0, "consume/contain/icon"):GetComponent(typeof(Image))))

	if arg_10_1:getConfig("num_limit") == 0 then
		setText(var_10_2, i18n("common_no_limit"))
	else
		local var_10_7 = arg_10_1:getConfig("num_limit")

		if var_10_5.type == DROP_TYPE_SKIN and not var_10_3 then
			setText(var_10_2, i18n("activity_shop_exchange_count") .. "0/" .. var_10_7)
		else
			setText(var_10_2, i18n("activity_shop_exchange_count") .. var_10_7 - arg_10_1.buyCount .. "/" .. var_10_7)
		end
	end

	if arg_10_1:getConfig("num_limit") >= 99 then
		setText(var_10_2, i18n("shop_label_unlimt_cnt"))
	end

	setActive(findTF(var_10_0, "group_locked"), var_10_1:Find("group_locked").gameObject.activeSelf)

	return
end

function ActivityGoodsCard:OnDispose()
	self.goodsVO = nil

	return
end

return ActivityGoodsCard
