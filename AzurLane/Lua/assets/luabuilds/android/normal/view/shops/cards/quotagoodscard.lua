class = var_0_10000

local var_0_0 = "QuotaGoodsCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseGoodsCard"))

function var_0_1.update(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.goodsVO = arg_1_1

	local var_1_0 = arg_1_0.goodsVO
	local var_1_1 = var_5.canPurchase(var_1_0)

	setActive = var_1_0

	var_1_0(arg_1_0.mask, not var_1_1)

	setActive = var_1_0

	var_1_0(arg_1_0.limitTag, not var_1_1)

	onButton = var_1_0

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.mask

	local function var_1_4()
		pg = var_2_10000

		local var_2_0 = var_2_10000.TipsMgr.GetInstance()
		local var_2_1 = var_0.ShowTips

		i18n = var_2_10002

		var_2_1(var_2_0, var_2_10002("quota_shop_limit_error"))

		return
	end

	SFX_PANEL = var_1_10010

	var_1_0(var_1_2, var_1_3, var_1_4, var_1_10010)

	local var_1_5 = arg_1_1:getConfig("commodity_type")
	local var_1_6 = arg_1_1
	local var_1_7 = arg_1_1.getConfig(var_1_6, "commodity_id")

	Drop = var_1_6

	local var_1_8 = var_1_6.New({
		type = var_1_5,
		id = var_1_7,
		count = arg_1_1:getConfig("num")
	})

	updateDrop = var_9

	var_9(arg_1_0.itemTF, var_1_8)

	local var_1_9 = ""

	DROP_TYPE_SKIN = var_10

	if var_1_5 == var_10 then
		pg = var_10
		var_1_9 = var_10.ship_skin_template[var_1_7].name or "??"
	else
		var_1_9 = var_1_8:getConfig("name") or "??"
	end

	setScrollText = var_10

	var_10(arg_1_0.nameTxt, var_1_9)

	setText = var_10

	var_10(arg_1_0.countTF, arg_1_1:getConfig("resource_num"))

	Drop = var_10

	local var_1_10 = var_10.New({
		type = arg_1_1:getConfig("resource_category"),
		id = arg_1_1:getConfig("resource_type")
	})
	local var_1_11 = var_10.getIcon(var_1_10)

	GetImageSpriteFromAtlasAsync = var_1_10

	var_1_10(var_1_11, "", arg_1_0.resIconTF)

	local var_1_12 = arg_1_1
	local var_1_13 = arg_1_1.GetLimitGoodCount(var_1_12)

	math = var_1_12

	local var_1_14 = var_1_12.min(arg_1_1:GetOwnedGoodCount(), var_1_13)

	setText = var_13

	local var_1_15 = arg_1_0.limitCountLabelTF

	i18n = var_1_10015

	var_13(var_1_15, var_1_10015("quota_shop_owned") .. var_1_13 - var_1_14 .. "/" .. var_1_13)

	setActive = var_13

	var_13(arg_1_0.limitCountLabelTF, true)

	setActive = var_13

	local var_1_16 = arg_1_0.groupLocked
	local var_1_17 = arg_1_0.itemTF

	var_13(var_1_16, var_15.Find(var_1_17, "group_locked").gameObject.activeSelf)

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
