local var_0_0 = class("BaseOldGoodsCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform

	setActive(arg_1_0.tf:Find("item/discount"), false)
	setActive(arg_1_0.tf:Find("item/group_locked"), false)
	setActive(arg_1_0.tf:Find("item/limit_time_sell"), false)
	setActive(arg_1_0.tf:Find("item/icon_bg/slv"), false)
	eachChild(arg_1_0.tf:Find("mask/tag"), function(arg_2_0)
		setActive(arg_2_0, false)

		return
	end)
	ClearAllText(arg_1_0.go)
	removeAllOnButton(arg_1_0.go)
	setText(arg_1_0.tf:Find("mask/tag/limit_tag"), i18n("quota_shop_good_limit"))
	setText(arg_1_0.tf:Find("mask/tag/limit_tag/limit_tag_en"), "LIMIT")
	setText(arg_1_0.tf:Find("mask/tag/sellout_tag"), i18n("word_sell_out"))
	setText(arg_1_0.tf:Find("mask/tag/sellout_tag/sellout_tag_en"), "SELL OUT")
	setText(arg_1_0.tf:Find("mask/tag/unexchange_tag"), i18n("meta_shop_exchange_limit"))
	setText(arg_1_0.tf:Find("mask/tag/unexchange_tag/sellout_tag_en"), "LIMIT")
	removeAllChildren(arg_1_0.tf:Find("item/icon_bg/stars"))

	local var_1_0 = arg_1_0.tf:Find("item/icon_bg/icon")

	var_1_0.offsetMin = Vector2(2, 2)
	var_1_0.offsetMax = Vector2(-2, -2)

	local var_1_1 = arg_1_0.tf:Find("item/icon_bg/frame")

	var_1_1.offsetMin = Vector2(0, 0)
	var_1_1.offsetMax = Vector2(0, 0)

	return
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:OnDispose()
	eachChild(arg_3_0.tf:Find("item/icon_bg/frame"), function(arg_4_0)
		setActive(arg_4_0, false)

		return
	end)
	pg.DelegateInfo.Dispose(arg_3_0)

	return
end

function var_0_0.OnDispose(arg_5_0)
	return
end

return var_0_0
