local var_0_0 = class("GoodsCard", import(".BaseGoodsCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)
	onButton(arg_1_0, arg_1_0.mask, function()
		pg.TipsMgr.GetInstance():ShowTips(arg_1_0.maskTip)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.setGroupMask(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.goodsVO:getConfig("group_limit")
	local var_3_1 = var_3_0 > 0 and var_3_0 <= arg_3_1

	if isActive(arg_3_0.mask) then
		return
	end

	setActive(arg_3_0.mask, var_3_1)

	if var_3_0 > 0 and var_3_0 <= arg_3_1 then
		setActive(arg_3_0.selloutTag, true)
		setActive(arg_3_0.levelTag, false)
	end

	return
end

function var_0_0.setLevelMask(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.goodsVO:isLevelLimit(arg_4_1)

	if isActive(arg_4_0.mask) then
		return
	end

	setActive(arg_4_0.mask, var_4_0)

	if var_4_0 then
		setScrollText(arg_4_0.levelTag:Find("TextGo/Text"), tostring((arg_4_0.goodsVO:getLevelLimit(arg_4_1))) .. i18n("shop_charge_level_limit"))
		setActive(arg_4_0.levelTag, true)
		setActive(arg_4_0.selloutTag, false)

		arg_4_0.maskTip = i18n("charge_level_limit")
	end

	return
end

function var_0_0.update(arg_5_0, arg_5_1, arg_5_2)
	setActive(arg_5_0.limitCountLabelTF, false)

	arg_5_0.goodsVO = arg_5_1

	local var_5_0 = arg_5_0.goodsVO:canPurchase()

	setActive(arg_5_0.mask, not var_5_0)
	setActive(arg_5_0.selloutTag, not var_5_0)
	setActive(arg_5_0.stars, false)

	local var_5_1 = arg_5_1:getDropInfo()

	updateDrop(arg_5_0.itemTF, var_5_1)

	local var_5_2 = var_5_1:getConfig("name") or ""

	setScrollText(arg_5_0.nameTxt, var_5_2)

	local var_5_3 = ""
	local var_5_4 = arg_5_1:getConfig("resource_num")

	if arg_5_1:getConfig("genre") == ShopArgs.ShoppingStreetLimit then
		var_5_3 = 100 - arg_5_1.discount .. "%OFF"
		var_5_4 = var_5_4 * (arg_5_1.discount / 100)
	end

	setActive(arg_5_0.discountTF, arg_5_1:hasDiscount())
	setText(arg_5_0.discountTextTF, var_5_3)
	setText(arg_5_0.countTF, math.ceil(var_5_4))
	GetImageSpriteFromAtlasAsync(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = arg_5_1:getConfig("resource_type")
	}):getIcon(), "", tf(arg_5_0.resIconTF))
	setActive(arg_5_0.groupLocked, arg_5_0.itemTF:Find("group_locked").gameObject.activeSelf)

	return
end

function var_0_0.OnDispose(arg_6_0)
	arg_6_0.goodsVO = nil

	return
end

return var_0_0
