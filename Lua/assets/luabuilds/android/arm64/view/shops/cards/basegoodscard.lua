local var_0_0 = class("BaseGoodsCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform
	arg_1_0.mask = findTF(arg_1_0.tf, "mask")
	arg_1_0.selloutTag = findTF(arg_1_0.tf, "mask/tag/sellout_tag")
	arg_1_0.sellEndTag = findTF(arg_1_0.tf, "mask/tag/sellend_tag")
	arg_1_0.levelTag = findTF(arg_1_0.tf, "mask/tag/level_tag")
	arg_1_0.unexchangeTag = findTF(arg_1_0.tf, "mask/tag/unexchange_tag")
	arg_1_0.levelTagText = findTF(arg_1_0.tf, "mask/tag/level_tag/TextGo/Text")
	arg_1_0.limitTag = findTF(arg_1_0.tf, "mask/tag/limit_tag")
	arg_1_0.nameTxt = findTF(arg_1_0.tf, "name_mask/name")
	arg_1_0.discountTF = findTF(arg_1_0.tf, "discount")
	arg_1_0.discountTextTF = findTF(arg_1_0.discountTF, "Text")
	arg_1_0.countTF = findTF(arg_1_0.tf, "consume/contain/Text")
	arg_1_0.resIconTF = findTF(arg_1_0.tf, "consume/contain/icon"):GetComponent(typeof(Image))
	arg_1_0.limitCountLabelTF = findTF(arg_1_0.tf, "count_contain/label")
	arg_1_0.itemTF = findTF(arg_1_0.tf, "itemBg/item")
	arg_1_0.itemIconBgTF = findTF(arg_1_0.itemTF, "icon_bg")
	arg_1_0.itemIconFrameTF = findTF(arg_1_0.itemTF, "icon_bg/frame")
	arg_1_0.stars = findTF(arg_1_0.itemTF, "icon_bg/stars")
	arg_1_0.itemIconTF = findTF(arg_1_0.itemTF, "icon_bg/icon"):GetComponent(typeof(Image))
	arg_1_0.itemCountTF = findTF(arg_1_0.itemTF, "icon_bg/count")
	arg_1_0.maskTip = i18n("buy_countLimit")

	setActive(arg_1_0.discountTF, false)
	setActive(arg_1_0.itemTF:Find("group_locked"), false)

	arg_1_0.groupLocked = findTF(arg_1_0.tf, "group_locked")

	setActive(arg_1_0.groupLocked, false)
	setText(findTF(arg_1_0.tf, "group_locked/Text"), i18n("shop_item_unobtained"))
	setActive(arg_1_0.tf:Find("limit_time_sell"), false)
	setActive(arg_1_0.tf:Find("itemBg/item/icon_bg/slv"), false)
	eachChild(arg_1_0.tf:Find("mask/tag"), function(arg_2_0)
		setActive(arg_2_0, false)

		return
	end)
	ClearAllText(arg_1_0.go)
	removeAllOnButton(arg_1_0.go)
	setScrollText(arg_1_0.tf:Find("mask/tag/limit_tag/TextGo/Text"), i18n("quota_shop_good_limit"))
	setScrollText(arg_1_0.tf:Find("mask/tag/sellout_tag/TextGo/Text"), i18n("word_sell_out"))
	setScrollText(arg_1_0.tf:Find("mask/tag/unexchange_tag/TextGo/Text"), i18n("meta_shop_exchange_limit"))
	setScrollText(arg_1_0.sellEndTag:Find("TextGo/Text"), i18n("shop_sell_ended"))
	setScrollText(arg_1_0.selloutTag:Find("TextGo/Text"), i18n("common_sale_out"))
	setScrollText(arg_1_0.levelTag:Find("TextGo/Text"), i18n("shop_charge_level_limit"))
	removeAllChildren(arg_1_0.stars)

	local var_1_0 = arg_1_0.tf:Find("itemBg/item/icon_bg/icon")

	var_1_0.offsetMin = Vector2(2, 2)
	var_1_0.offsetMax = Vector2(-2, -2)

	local var_1_1 = arg_1_0.tf:Find("itemBg/item/icon_bg/frame")

	var_1_1.offsetMin = Vector2(0, 0)
	var_1_1.offsetMax = Vector2(0, 0)

	return
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:OnDispose()
	pg.DelegateInfo.Dispose(arg_3_0)

	return
end

function var_0_0.OnDispose(arg_4_0)
	return
end

return var_0_0
