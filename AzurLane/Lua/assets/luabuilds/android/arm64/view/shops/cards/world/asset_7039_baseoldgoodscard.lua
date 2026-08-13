class = var_0_10000

local var_0_0 = var_0_10000("BaseOldGoodsCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform
	setActive = var_2

	local var_1_0 = arg_1_0.tf

	var_2(var_4.Find(var_1_0, "item/discount"), false)

	setActive = var_2

	local var_1_1 = arg_1_0.tf

	var_2(var_4.Find(var_1_1, "item/group_locked"), false)

	setActive = var_2

	local var_1_2 = arg_1_0.tf

	var_2(var_4.Find(var_1_2, "item/limit_time_sell"), false)

	setActive = var_2

	local var_1_3 = arg_1_0.tf

	var_2(var_4.Find(var_1_3, "item/icon_bg/slv"), false)

	eachChild = var_2

	local var_1_4 = arg_1_0.tf

	var_2(var_4.Find(var_1_4, "mask/tag"), function(arg_2_0)
		setActive = var_2_10001

		var_2_10001(arg_2_0, false)

		return
	end)

	ClearAllText = var_2

	var_2(arg_1_0.go)

	removeAllOnButton = var_2

	var_2(arg_1_0.go)

	setText = var_2

	local var_1_5 = arg_1_0.tf
	local var_1_6 = var_4.Find(var_1_5, "mask/tag/limit_tag")

	i18n = var_5

	var_2(var_1_6, var_5("quota_shop_good_limit"))

	setText = var_2

	local var_1_7 = arg_1_0.tf

	var_2(var_4.Find(var_1_7, "mask/tag/limit_tag/limit_tag_en"), "LIMIT")

	setText = var_2

	local var_1_8 = arg_1_0.tf
	local var_1_9 = var_4.Find(var_1_8, "mask/tag/sellout_tag")

	i18n = var_5

	var_2(var_1_9, var_5("word_sell_out"))

	setText = var_2

	local var_1_10 = arg_1_0.tf

	var_2(var_4.Find(var_1_10, "mask/tag/sellout_tag/sellout_tag_en"), "SELL OUT")

	setText = var_2

	local var_1_11 = arg_1_0.tf
	local var_1_12 = var_4.Find(var_1_11, "mask/tag/unexchange_tag")

	i18n = var_5

	var_2(var_1_12, var_5("meta_shop_exchange_limit"))

	setText = var_2

	local var_1_13 = arg_1_0.tf

	var_2(var_4.Find(var_1_13, "mask/tag/unexchange_tag/sellout_tag_en"), "LIMIT")

	removeAllChildren = var_2

	local var_1_14 = arg_1_0.tf

	var_2(var_4.Find(var_1_14, "item/icon_bg/stars"))

	local var_1_15 = arg_1_0.tf
	local var_1_16 = var_2.Find(var_1_15, "item/icon_bg/icon")

	Vector2 = var_1_10003
	var_1_16.offsetMin = var_1_10003(2, 2)
	Vector2 = var_3
	var_1_16.offsetMax = var_3(-2, -2)

	local var_1_17 = arg_1_0.tf
	local var_1_18 = var_3.Find(var_1_17, "item/icon_bg/frame")

	Vector2 = var_1_15
	var_1_18.offsetMin = var_1_15(0, 0)
	Vector2 = var_4
	var_1_18.offsetMax = var_4(0, 0)

	return
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:OnDispose()

	eachChild = var_1

	local var_3_0 = arg_3_0.tf

	var_1(var_3.Find(var_3_0, "item/icon_bg/frame"), function(arg_4_0)
		setActive = var_2_10001

		var_2_10001(arg_4_0, false)

		return
	end)

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_3_0)

	return
end

function var_0_0.OnDispose(arg_5_0)
	return
end

return var_0_0
