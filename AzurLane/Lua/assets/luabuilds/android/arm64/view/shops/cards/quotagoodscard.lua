local var_0_0 = class("QuotaGoodsCard", import(".BaseGoodsCard"))

function var_0_0.update(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.goodsVO = arg_1_1

	local var_1_0 = arg_1_0.goodsVO:canPurchase()

	setActive(arg_1_0.mask, not var_1_0)
	setActive(arg_1_0.limitTag, not var_1_0)
	onButton(arg_1_0, arg_1_0.mask, function()
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

	updateDrop(arg_1_0.itemTF, var_1_3)

	local var_1_4 = ""

	var_1_4 = var_1_1 == DROP_TYPE_SKIN and (pg.ship_skin_template[var_1_2].name or "??") or var_1_3:getConfig("name") or "??"

	setScrollText(arg_1_0.nameTxt, var_1_4)
	setText(arg_1_0.countTF, arg_1_1:getConfig("resource_num"))
	GetImageSpriteFromAtlasAsync(Drop.New({
		type = arg_1_1:getConfig("resource_category"),
		id = arg_1_1:getConfig("resource_type")
	}):getIcon(), "", arg_1_0.resIconTF)

	local var_1_5 = arg_1_1:GetLimitGoodCount()

	setText(arg_1_0.limitCountLabelTF, i18n("quota_shop_owned") .. var_1_5 - math.min(arg_1_1:GetOwnedGoodCount(), var_1_5) .. "/" .. var_1_5)
	setActive(arg_1_0.limitCountLabelTF, true)
	setActive(arg_1_0.groupLocked, arg_1_0.itemTF:Find("group_locked").gameObject.activeSelf)

	return
end

function var_0_0.setAsLastSibling(arg_3_0)
	arg_3_0.tf:SetAsLastSibling()

	return
end

function var_0_0.OnDispose(arg_4_0)
	arg_4_0.goodsVO = nil

	return
end

return var_0_0
