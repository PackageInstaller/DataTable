local var_0_0 = class("MiniGameGoodsCard", import(".BaseGoodsCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)
	setActive(arg_1_0.selloutTag, true)
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
		setScrollText(arg_4_0.levelTagText, tostring((arg_4_0.goodsVO:getLevelLimit(arg_4_1))))
		setActive(arg_4_0.levelTag, true)
		setActive(arg_4_0.selloutTag, false)

		arg_4_0.maskTip = i18n("charge_level_limit")
	end

	return
end

function var_0_0.update(arg_5_0, arg_5_1)
	arg_5_0.goodsVO = arg_5_1

	setActive(arg_5_0.mask, not arg_5_0.goodsVO:CanPurchase())
	setActive(arg_5_0.stars, false)

	local var_5_0 = arg_5_1:GetDropInfo()

	updateDrop(arg_5_0.itemTF, var_5_0)

	local var_5_1 = var_5_0:getConfig("name") or ""

	setScrollText(arg_5_0.nameTxt, var_5_1)
	setText(arg_5_0.limitCountLabelTF, i18n("activity_shop_exchange_count") .. arg_5_1:GetMaxCnt() .. "/" .. arg_5_1:getConfig("goods_purchase_limit"))
	setActive(arg_5_0.limitCountLabelTF, true)
	setActive(arg_5_0.discountTF, false)
	setText(arg_5_0.countTF, math.ceil((arg_5_1:getConfig("price"))))
	GetSpriteFromAtlasAsync("ui/ShopsUI_atlas", "minigameRes", function(arg_6_0)
		arg_5_0.resIconTF:GetComponent(typeof(Image)).sprite = arg_6_0

		return
	end)
	setActive(arg_5_0.groupLocked, arg_5_0.itemTF:Find("group_locked").gameObject.activeSelf)

	return
end

function var_0_0.OnDispose(arg_7_0)
	arg_7_0.goodsVO = nil

	return
end

return var_0_0
