class = var_0_10000

local var_0_0 = var_0_10000("BaseGoodsCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform
	findTF = var_2
	arg_1_0.mask = var_2(arg_1_0.tf, "mask")
	findTF = var_2
	arg_1_0.selloutTag = var_2(arg_1_0.tf, "mask/tag/sellout_tag")
	findTF = var_2
	arg_1_0.sellEndTag = var_2(arg_1_0.tf, "mask/tag/sellend_tag")
	findTF = var_2
	arg_1_0.levelTag = var_2(arg_1_0.tf, "mask/tag/level_tag")
	findTF = var_2
	arg_1_0.unexchangeTag = var_2(arg_1_0.tf, "mask/tag/unexchange_tag")
	findTF = var_2
	arg_1_0.levelTagText = var_2(arg_1_0.tf, "mask/tag/level_tag/TextGo/Text")
	findTF = var_2
	arg_1_0.limitTag = var_2(arg_1_0.tf, "mask/tag/limit_tag")
	findTF = var_2
	arg_1_0.nameTxt = var_2(arg_1_0.tf, "name_mask/name")
	findTF = var_2
	arg_1_0.discountTF = var_2(arg_1_0.tf, "discount")
	findTF = var_2
	arg_1_0.discountTextTF = var_2(arg_1_0.discountTF, "Text")
	findTF = var_2
	arg_1_0.countTF = var_2(arg_1_0.tf, "consume/contain/Text")
	findTF = var_2

	local var_1_0 = var_2(arg_1_0.tf, "consume/contain/icon")
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.resIconTF = var_1_1(var_1_0, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.limitCountLabelTF = var_2(arg_1_0.tf, "count_contain/label")
	findTF = var_2
	arg_1_0.itemTF = var_2(arg_1_0.tf, "itemBg/item")
	findTF = var_2
	arg_1_0.itemIconBgTF = var_2(arg_1_0.itemTF, "icon_bg")
	findTF = var_2
	arg_1_0.itemIconFrameTF = var_2(arg_1_0.itemTF, "icon_bg/frame")
	findTF = var_2
	arg_1_0.stars = var_2(arg_1_0.itemTF, "icon_bg/stars")
	findTF = var_2

	local var_1_2 = var_2(arg_1_0.itemTF, "icon_bg/icon")
	local var_1_3 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.itemIconTF = var_1_3(var_1_2, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.itemCountTF = var_2(arg_1_0.itemTF, "icon_bg/count")
	i18n = var_2
	arg_1_0.maskTip = var_2("buy_countLimit")
	setActive = var_2

	var_2(arg_1_0.discountTF, false)

	setActive = var_2

	local var_1_4 = arg_1_0.itemTF

	var_2(var_4.Find(var_1_4, "group_locked"), false)

	findTF = var_2
	arg_1_0.groupLocked = var_2(arg_1_0.tf, "group_locked")
	setActive = var_2

	var_2(arg_1_0.groupLocked, false)

	setText = var_2
	findTF = var_4

	local var_1_5 = var_4(arg_1_0.tf, "group_locked/Text")

	i18n = var_5

	var_2(var_1_5, var_5("shop_item_unobtained"))

	setActive = var_2

	local var_1_6 = arg_1_0.tf

	var_2(var_4.Find(var_1_6, "limit_time_sell"), false)

	setActive = var_2

	local var_1_7 = arg_1_0.tf

	var_2(var_4.Find(var_1_7, "itemBg/item/icon_bg/slv"), false)

	eachChild = var_2

	local var_1_8 = arg_1_0.tf

	var_2(var_4.Find(var_1_8, "mask/tag"), function(arg_2_0)
		setActive = var_2_10001

		var_2_10001(arg_2_0, false)

		return
	end)

	ClearAllText = var_2

	var_2(arg_1_0.go)

	removeAllOnButton = var_2

	var_2(arg_1_0.go)

	setScrollText = var_2

	local var_1_9 = arg_1_0.tf
	local var_1_10 = var_4.Find(var_1_9, "mask/tag/limit_tag/TextGo/Text")

	i18n = var_5

	var_2(var_1_10, var_5("quota_shop_good_limit"))

	setScrollText = var_2

	local var_1_11 = arg_1_0.tf
	local var_1_12 = var_4.Find(var_1_11, "mask/tag/sellout_tag/TextGo/Text")

	i18n = var_5

	var_2(var_1_12, var_5("word_sell_out"))

	setScrollText = var_2

	local var_1_13 = arg_1_0.tf
	local var_1_14 = var_4.Find(var_1_13, "mask/tag/unexchange_tag/TextGo/Text")

	i18n = var_5

	var_2(var_1_14, var_5("meta_shop_exchange_limit"))

	setScrollText = var_2

	local var_1_15 = arg_1_0.sellEndTag
	local var_1_16 = var_4.Find(var_1_15, "TextGo/Text")

	i18n = var_5

	var_2(var_1_16, var_5("shop_sell_ended"))

	setScrollText = var_2

	local var_1_17 = arg_1_0.selloutTag
	local var_1_18 = var_4.Find(var_1_17, "TextGo/Text")

	i18n = var_5

	var_2(var_1_18, var_5("common_sale_out"))

	setScrollText = var_2

	local var_1_19 = arg_1_0.levelTag
	local var_1_20 = var_4.Find(var_1_19, "TextGo/Text")

	i18n = var_5

	var_2(var_1_20, var_5("shop_charge_level_limit"))

	removeAllChildren = var_2

	var_2(arg_1_0.stars)

	local var_1_21 = arg_1_0.tf
	local var_1_22 = var_2.Find(var_1_21, "itemBg/item/icon_bg/icon")

	Vector2 = var_1_10003
	var_1_22.offsetMin = var_1_10003(2, 2)
	Vector2 = var_3
	var_1_22.offsetMax = var_3(-2, -2)

	local var_1_23 = arg_1_0.tf
	local var_1_24 = var_3.Find(var_1_23, "itemBg/item/icon_bg/frame")

	Vector2 = var_1_21
	var_1_24.offsetMin = var_1_21(0, 0)
	Vector2 = var_4
	var_1_24.offsetMax = var_4(0, 0)

	return
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:OnDispose()

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_3_0)

	return
end

function var_0_0.OnDispose(arg_4_0)
	return
end

return var_0_0
