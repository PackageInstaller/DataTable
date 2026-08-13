class = var_0_10000

local var_0_0 = "QuotaGoodsCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseGoodsCard"))

function var_0_1.update(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.goodsVO = arg_1_1

	local var_1_0 = arg_1_0.goodsVO
	local var_1_1 = var_5.canPurchase(var_1_0)

	setActive = var_1_10006

	var_1_10006(arg_1_0.mask, not var_1_1)

	setActive = var_1_10006

	var_1_10006(arg_1_0.limitTag, not var_1_1)

	onButton = var_1_10006

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.mask

	local function var_1_4()
		pg = var_2_10000

		local var_2_0 = var_2_10000.TipsMgr.GetInstance()
		local var_2_1 = var_0.ShowTips

		i18n = var_2_10003

		var_2_1(var_2_0, var_2_10003("quota_shop_limit_error"))

		return
	end

	SFX_PANEL = var_1_10011

	var_1_10006(var_1_2, var_1_3, var_1_4, var_1_10011)

	local var_1_5 = arg_1_1
	local var_1_6 = arg_1_1.getConfig(var_1_5, "commodity_type")
	local var_1_7 = arg_1_1
	local var_1_8 = arg_1_1.getConfig(var_1_7, "commodity_id")

	Drop = var_1_5

	local var_1_9 = var_1_5.New({
		type = var_1_6,
		id = var_1_8,
		count = arg_1_1:getConfig("num")
	})

	updateDrop = var_1_7

	var_1_7(arg_1_0.itemTF, var_1_9)

	local var_1_10 = ""

	DROP_TYPE_SKIN = var_10

	if var_1_6 == var_10 then
		pg = var_10
		var_1_10 = var_10.ship_skin_template[var_1_8].name or "??"
	else
		var_1_10 = var_1_9:getConfig("name") or "??"
	end

	setScrollText = var_10

	var_10(arg_1_0.nameTxt, var_1_10)

	setText = var_10

	var_10(arg_1_0.countTF, arg_1_1:getConfig("resource_num"))

	Drop = var_10

	local var_1_11 = var_10.New({
		type = arg_1_1:getConfig("resource_category"),
		id = arg_1_1:getConfig("resource_type")
	})
	local var_1_12 = var_10.getIcon(var_1_11)

	GetImageSpriteFromAtlasAsync = var_11

	var_11(var_1_12, "", arg_1_0.resIconTF)

	local var_1_13 = arg_1_1
	local var_1_14 = arg_1_1.GetLimitGoodCount(var_1_13)

	math = var_1_11

	local var_1_15 = var_1_11.min
	local var_1_16 = arg_1_1
	local var_1_17 = var_1_15(arg_1_1.GetOwnedGoodCount(var_1_16), var_1_14)

	setText = var_1_13

	local var_1_18 = arg_1_0.limitCountLabelTF

	i18n = var_1_16

	var_1_13(var_1_18, var_1_16("quota_shop_owned") .. var_1_14 - var_1_17 .. "/" .. var_1_14)

	setActive = var_1_13

	var_1_13(arg_1_0.limitCountLabelTF, true)

	setActive = var_1_13

	local var_1_19 = arg_1_0.groupLocked
	local var_1_20 = arg_1_0.itemTF

	var_1_13(var_1_19, var_16.Find(var_1_20, "group_locked").gameObject.activeSelf)

	return
end

function var_0_1.setAsLastSibling(arg_3_0)
	local var_3_0 = arg_3_0.tf

	var_1.SetAsLastSibling(var_3_0)

	return
end

function var_0_1.OnDispose(arg_4_0)
	arg_4_0.goodsVO = nil

	return
end

return var_0_1
