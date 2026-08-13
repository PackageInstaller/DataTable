class = var_0_10000

local var_0_0 = "WorldGoodsCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseOldGoodsCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.go = arg_1_1
	tf = var_2
	arg_1_0.tr = var_2(arg_1_1)

	local var_1_0 = arg_1_0.tr

	arg_1_0.mask = var_2.Find(var_1_0, "mask")

	local var_1_1 = arg_1_0.tr

	arg_1_0.selloutTag = var_2.Find(var_1_1, "mask/tag/sellout_tag")
	setText = var_2

	local var_1_2 = arg_1_0.selloutTag

	i18n = var_4

	var_2(var_1_2, var_4("common_sale_out"))

	local var_1_3 = arg_1_0.tr

	arg_1_0.levelTag = var_2.Find(var_1_3, "mask/tag/level_tag")
	setText = var_2

	local var_1_4 = arg_1_0.levelTag

	i18n = var_4

	var_2(var_1_4, var_4("shop_charge_level_limit"))

	local var_1_5 = arg_1_0.tr

	arg_1_0.levelTagText = var_2.Find(var_1_5, "mask/tag/level_tag/Text")

	local var_1_6 = arg_1_0.tr

	arg_1_0.stars = var_2.Find(var_1_6, "item/icon_bg/stars")
	findTF = var_2
	arg_1_0.itemTF = var_2(arg_1_0.tr, "item")
	findTF = var_2
	arg_1_0.nameTxt = var_2(arg_1_0.tr, "item/name_mask/name")
	findTF = var_2
	arg_1_0.discountTF = var_2(arg_1_0.tr, "item/discount")
	findTF = var_2

	local var_1_7 = var_2(arg_1_0.discountTF, "Text")
	local var_1_8 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_1_0.discountTextTF = var_1_8(var_1_7, var_4(var_5))
	findTF = var_2

	local var_1_9 = var_2(arg_1_0.tr, "item/consume/contain/Text")
	local var_1_10 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_1_0.countTF = var_1_10(var_1_9, var_4(var_5))
	findTF = var_2

	local var_1_11 = var_2(arg_1_0.tr, "item/consume/contain/icon")
	local var_1_12 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0.resIconTF = var_1_12(var_1_11, var_4(var_5))

	local var_1_13 = arg_1_0.itemTF
	local var_1_14 = var_2.Find(var_1_13, "icon_bg/icon")
	local var_1_15 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0.itemIconTF = var_1_15(var_1_14, var_4(var_5))

	local var_1_16 = arg_1_0.itemTF
	local var_1_17 = var_2.Find(var_1_16, "icon_bg/count")
	local var_1_18 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_1_0.itemCountTF = var_1_18(var_1_17, var_4(var_5))
	i18n = var_2
	arg_1_0.maskTip = var_2("buy_countLimit")
	onButton = var_2

	local var_1_19 = arg_1_0
	local var_1_20 = arg_1_0.mask

	local function var_1_21()
		pg = var_2_10000

		local var_2_0 = var_2_10000.TipsMgr.GetInstance()

		var_0.ShowTips(var_2_0, arg_1_0.maskTip)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_1_19, var_1_20, var_1_21, var_1_10006)

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
		setText = var_4

		local var_4_4 = arg_4_0.levelTagText

		tostring = var_6

		var_4(var_4_4, var_6(var_4_1))

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
	local var_5_1 = var_2.canPurchase(var_5_0)

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

	setText = var_5_4

	local var_5_6 = arg_5_0.nameTxt

	shortenString = var_1_10007

	var_5_4(var_5_6, var_1_10007(var_5_5, 6))

	local var_5_7 = ""
	local var_5_8 = arg_5_1:getConfig("resource_num")
	local var_5_9 = arg_5_1
	local var_5_10 = arg_5_1.getConfig(var_5_9, "genre")

	ShopArgs = var_5_9

	if var_5_10 == var_5_9.ShoppingStreetLimit then
		var_5_7 = 100 - arg_5_1.discount .. "%OFF"
		var_5_8 = var_5_8 * (arg_5_1.discount / 100)
	end

	setActive = var_5_10

	var_5_10(arg_5_0.discountTF, false)

	if arg_5_1.activityDiscount then
		findTF = var_5_11

		local var_5_11

		if not var_5_11(arg_5_0.tr, "item/discount_activity") then
			findTF = var_5_11
			var_5_11 = var_5_11(arg_5_0.tr, "item/discount")
		end

		arg_5_0.discountTF = var_5_11
		findTF = var_5_11

		local var_5_12 = var_5_11(arg_5_0.discountTF, "Text")
		local var_5_13 = var_7.GetComponent

		typeof = var_9
		Text = var_1_10010
		arg_5_0.discountTextTF = var_5_13(var_5_12, var_9(var_1_10010))
		setActive = var_7

		local var_5_14 = arg_5_0.discountTF
		local var_5_15 = arg_5_1

		var_7(var_5_14, arg_5_1.hasDiscount(var_5_15))

		arg_5_0.discountTextTF.text = var_5_7

		local var_5_16 = arg_5_0.countTF

		math = var_5_14
		var_5_16.text = var_5_14.ceil(var_5_8)
		GetImageSpriteFromAtlasAsync = var_5_16
		Drop = var_8

		local var_5_17 = var_8.New
		local var_5_18 = {}

		DROP_TYPE_RESOURCE = var_5_15
		var_5_18.type = var_5_15
		var_5_18.id = arg_5_1:getConfig("resource_type")

		local var_5_19 = var_5_17(var_5_18)
		local var_5_20 = var_8.getIcon(var_5_19)
		local var_5_21 = ""

		tf = var_10

		var_5_16(var_5_20, var_5_21, var_10(arg_5_0.resIconTF))

		return
	end
end

function var_0_1.OnDispose(arg_6_0)
	arg_6_0.goodsVO = nil

	return
end

return var_0_1
