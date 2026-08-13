class = var_0_10000

local var_0_0 = "MiniGameGoodsCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseGoodsCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	setActive = var_2

	var_2(arg_1_0.selloutTag, true)

	onButton = var_2

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.mask

	local function var_1_2()
		pg = var_2_10000

		local var_2_0 = var_2_10000.TipsMgr.GetInstance()

		var_0.ShowTips(var_2_0, arg_1_0.maskTip)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_1_0, var_1_1, var_1_2, var_1_10007)

	return
end

function var_0_1.setGroupMask(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.goodsVO
	local var_3_1 = var_2.getConfig(var_3_0, "group_limit") > 0 and var_2 <= arg_3_1

	isActive = var_3_0

	if var_3_0(arg_3_0.mask) then
		return
	end

	setActive = var_4

	var_4(arg_3_0.mask, var_3_1)

	if 0 < var_2 and var_2 <= arg_3_1 then
		setActive = var_4

		var_4(arg_3_0.selloutTag, true)

		setActive = var_4

		var_4(arg_3_0.levelTag, false)
	end

	return
end

function var_0_1.setLevelMask(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.goodsVO
	local var_4_1 = var_2.getLevelLimit(var_4_0, arg_4_1)
	local var_4_2 = arg_4_0.goodsVO
	local var_4_3 = var_3.isLevelLimit(var_4_2, arg_4_1)

	isActive = var_4_0

	if var_4_0(arg_4_0.mask) then
		return
	end

	setActive = var_4

	var_4(arg_4_0.mask, var_4_3)

	if var_4_3 then
		setScrollText = var_4

		local var_4_4 = arg_4_0.levelTagText

		tostring = var_7

		var_4(var_4_4, var_7(var_4_1))

		setActive = var_4

		var_4(arg_4_0.levelTag, true)

		setActive = var_4

		var_4(arg_4_0.selloutTag, false)

		i18n = var_4
		arg_4_0.maskTip = var_4("charge_level_limit")
	end

	return
end

function var_0_1.update(arg_5_0, arg_5_1)
	arg_5_0.goodsVO = arg_5_1

	local var_5_0 = arg_5_0.goodsVO
	local var_5_1 = var_2.CanPurchase(var_5_0)

	setActive = var_1_10003

	var_1_10003(arg_5_0.mask, not var_5_1)

	setActive = var_1_10003

	var_1_10003(arg_5_0.stars, false)

	local var_5_2 = arg_5_1
	local var_5_3 = arg_5_1.GetDropInfo(var_5_2)

	updateDrop = var_5_0

	var_5_0(arg_5_0.itemTF, var_5_3)

	local var_5_4

	if not var_5_3:getConfig("name") then
		var_5_4 = ""
	end

	setScrollText = var_5_2

	var_5_2(arg_5_0.nameTxt, var_5_4)

	local var_5_5 = ""
	local var_5_6 = arg_5_1:getConfig("price")
	local var_5_7 = arg_5_1
	local var_5_8 = arg_5_1.GetMaxCnt(var_5_7)
	local var_5_9 = arg_5_1:getConfig("goods_purchase_limit")

	setText = var_5_7

	local var_5_10 = arg_5_0.limitCountLabelTF

	i18n = var_1_10012

	var_5_7(var_5_10, var_1_10012("activity_shop_exchange_count") .. var_5_8 .. "/" .. var_5_9)

	setActive = var_5_7

	var_5_7(arg_5_0.limitCountLabelTF, true)

	setActive = var_5_7

	var_5_7(arg_5_0.discountTF, false)

	setText = var_5_7

	local var_5_11 = arg_5_0.countTF

	math = var_12

	var_5_7(var_5_11, var_12.ceil(var_5_6))

	GetSpriteFromAtlasAsync = var_5_7

	var_5_7("ui/ShopsUI_atlas", "minigameRes", function(arg_6_0)
		local var_6_0 = arg_5_0.resIconTF
		local var_6_1 = var_1.GetComponent

		typeof = var_2_10004
		Image = var_2_10006
		var_6_1(var_6_0, var_2_10004(var_2_10006)).sprite = arg_6_0

		return
	end)

	setActive = var_5_7

	local var_5_12 = arg_5_0.groupLocked
	local var_5_13 = arg_5_0.itemTF

	var_5_7(var_5_12, var_12.Find(var_5_13, "group_locked").gameObject.activeSelf)

	return
end

function var_0_1.OnDispose(arg_7_0)
	arg_7_0.goodsVO = nil

	return
end

return var_0_1
