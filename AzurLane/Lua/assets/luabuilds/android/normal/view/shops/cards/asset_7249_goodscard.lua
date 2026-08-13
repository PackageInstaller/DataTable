class = var_0_10000

local var_0_0 = "GoodsCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseGoodsCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	onButton = var_2

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.mask

	local function var_1_2()
		pg = var_2_10000

		local var_2_0 = var_2_10000.TipsMgr.GetInstance()

		var_0.ShowTips(var_2_0, arg_1_0.maskTip)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_1_0, var_1_1, var_1_2, var_1_10006)

	return
end

function var_0_1.setGroupMask(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.goodsVO
	local var_3_1 = var_2.getConfig(var_3_0, "group_limit") > 0 and var_2 <= arg_3_1

	isActive = var_4

	if var_4(arg_3_0.mask) then
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

	isActive = var_4_2

	if var_4_2(arg_4_0.mask) then
		return
	end

	setActive = var_4

	var_4(arg_4_0.mask, var_4_3)

	if var_4_3 then
		setScrollText = var_4

		local var_4_4 = arg_4_0.levelTag
		local var_4_5 = var_5.Find(var_4_4, "TextGo/Text")

		tostring = var_4_4

		local var_4_6 = var_4_4(var_4_1)

		i18n = var_7

		var_4(var_4_5, var_4_6 .. var_7("shop_charge_level_limit"))

		setActive = var_4

		var_4(arg_4_0.levelTag, true)

		setActive = var_4

		var_4(arg_4_0.selloutTag, false)

		i18n = var_4
		arg_4_0.maskTip = var_4("charge_level_limit")
	end

	return
end

function var_0_1.update(arg_5_0, arg_5_1, arg_5_2)
	setActive = var_1_10003

	var_1_10003(arg_5_0.limitCountLabelTF, false)

	arg_5_0.goodsVO = arg_5_1

	local var_5_0 = arg_5_0.goodsVO
	local var_5_1 = var_3.canPurchase(var_5_0)

	setActive = var_5_0

	var_5_0(arg_5_0.mask, not var_5_1)

	setActive = var_5_0

	var_5_0(arg_5_0.selloutTag, not var_5_1)

	setActive = var_5_0

	var_5_0(arg_5_0.stars, false)

	local var_5_2 = arg_5_1
	local var_5_3 = arg_5_1.getDropInfo(var_5_2)

	updateDrop = var_5_2

	var_5_2(arg_5_0.itemTF, var_5_3)

	local var_5_4 = var_5_3
	local var_5_5

	if not var_5_3.getConfig(var_5_4, "name") then
		var_5_5 = ""
	end

	setScrollText = var_5_4

	var_5_4(arg_5_0.nameTxt, var_5_5)

	local var_5_6 = ""
	local var_5_7 = arg_5_1:getConfig("resource_num")
	local var_5_8 = arg_5_1
	local var_5_9 = arg_5_1.getConfig(var_5_8, "genre")

	ShopArgs = var_5_8

	if var_5_9 == var_5_8.ShoppingStreetLimit then
		var_5_6 = 100 - arg_5_1.discount .. "%OFF"
		var_5_7 = var_5_7 * (arg_5_1.discount / 100)
	end

	setActive = var_5_9

	var_5_9(arg_5_0.discountTF, arg_5_1:hasDiscount())

	setText = var_5_9

	var_5_9(arg_5_0.discountTextTF, var_5_6)

	setText = var_5_9

	local var_5_10 = arg_5_0.countTF

	math = var_10

	var_5_9(var_5_10, var_10.ceil(var_5_7))

	GetImageSpriteFromAtlasAsync = var_5_9
	Drop = var_5_10

	local var_5_11 = var_5_10.New
	local var_5_12 = {}

	DROP_TYPE_RESOURCE = var_11
	var_5_12.type = var_11
	var_5_12.id = arg_5_1:getConfig("resource_type")

	local var_5_13 = var_5_11(var_5_12)
	local var_5_14 = var_9.getIcon(var_5_13)
	local var_5_15 = ""

	tf = var_11

	var_5_9(var_5_14, var_5_15, var_11(arg_5_0.resIconTF))

	setActive = var_5_9

	local var_5_16 = arg_5_0.groupLocked
	local var_5_17 = arg_5_0.itemTF

	var_5_9(var_5_16, var_10.Find(var_5_17, "group_locked").gameObject.activeSelf)

	return
end

function var_0_1.OnDispose(arg_6_0)
	arg_6_0.goodsVO = nil

	return
end

return var_0_1
