class = var_0_10000

local var_0_0 = "MedalGoodsCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseGoodsCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	findTF = var_2

	local var_1_0 = var_2(arg_1_0.tf, "count_contain/label")
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.limitCountLabelTF = var_1_1(var_1_0, var_5(var_1_10007))

	return
end

function var_0_1.update(arg_2_0, arg_2_1)
	if arg_2_0.goods ~= arg_2_1 then
		arg_2_0.goods = arg_2_1

		arg_2_0:Init()
	else
		arg_2_0.goods = arg_2_1
	end

	local var_2_0 = arg_2_0.limitCountLabelTF

	i18n = var_1_10003

	local var_2_1 = var_1_10003("activity_shop_exchange_count")
	local var_2_2 = arg_2_0.goods.count
	local var_2_3 = "/"
	local var_2_4 = arg_2_0.goods

	var_2_0.text = var_2_1 .. var_2_2 .. var_2_3 .. var_6.GetLimit(var_2_4)

	local var_2_5 = arg_2_0.goods
	local var_2_6 = var_2.CanPurchase(var_2_5)

	setActive = var_3

	var_3(arg_2_0.mask, not var_2_6)

	setActive = var_3

	var_3(arg_2_0.selloutTag, not var_2_6)

	return
end

function var_0_1.Init(arg_3_0)
	local var_3_0 = arg_3_0.goods
	local var_3_1 = var_1.getConfig(var_3_0, "goods_name")
	local var_3_2 = arg_3_0.goods
	local var_3_3 = var_2.GetDropInfo(var_3_2)

	updateDrop = var_3_0

	var_3_0(arg_3_0.itemTF, var_3_3)

	setScrollText = var_3_0

	var_3_0(arg_3_0.nameTxt, var_3_1)

	setText = var_3_0

	local var_3_4 = arg_3_0.countTF
	local var_3_5 = arg_3_0.goods

	var_3_0(var_3_4, var_6.getConfig(var_3_5, "price"))

	GetImageSpriteFromAtlasAsync = var_3_0

	var_3_0("props/medal", "", arg_3_0.resIconTF)

	GetImageSpriteFromAtlasAsync = var_3_0

	local var_3_6 = arg_3_0.goods

	var_3_0(var_5.getConfig(var_3_6, "goods_icon"), "", arg_3_0.itemIconTF)

	setActive = var_3_0

	local var_3_7 = arg_3_0.groupLocked
	local var_3_8 = arg_3_0.goods
	local var_3_10

	if not var_6.Selectable(var_3_8) then
		local var_3_9 = arg_3_0.itemTF

		var_3_10 = var_6.Find(var_3_9, "group_locked").gameObject.activeSelf
	else
		var_3_10 = false
	end

	if false then
		var_3_10 = true
	end

	var_3_0(var_3_7, var_3_10)

	return
end

function var_0_1.OnDispose(arg_4_0)
	arg_4_0.goods = nil

	return
end

return var_0_1
