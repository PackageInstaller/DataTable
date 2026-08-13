class = var_0_10000

local var_0_0 = "ActivityGoodsCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseGoodsCard"))

var_0_1.Color = {}
var_0_1.DefaultColor = {
	0.8745098039215686,
	0.9294117647058824,
	1
}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	findTF = var_2
	arg_1_0.limitTimeSellTF = var_2(arg_1_0.tf, "limit_time_sell")
	setActive = var_2

	var_2(arg_1_0.limitTimeSellTF, false)

	local var_1_0 = arg_1_0.tf

	arg_1_0.limitPassTag = var_2.Find(var_1_0, "mask/tag/pass_tag")

	return
end

function var_0_1.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_1:Selectable() then
		arg_2_0:updateSelectable(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	else
		arg_2_0:updateSingle(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end

	return
end

function var_0_1.updateSingle(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.goodsVO = arg_3_1

	local var_3_0 = arg_3_0.goodsVO
	local var_3_1

	if var_5.CheckCntLimit(var_3_0) then
		::label_3_0::

		var_1_10008 = arg_3_0.goodsVO
		var_3_1 = not var_6.CheckArgLimit(var_1_10008)
	end

	local var_3_2 = false

	setActive = var_1_10008

	var_1_10008(arg_3_0.mask, not var_5 or var_3_1)

	setActive = var_1_10008

	var_1_10008(arg_3_0.selloutTag, false)

	if arg_3_0.limitPassTag then
		setActive = var_3_4

		var_3_4(arg_3_0.limitPassTag, false)
	end

	setActive = var_3_4

	var_3_4(arg_3_0.unexchangeTag, false)

	removeOnButton = var_3_4

	var_3_4(arg_3_0.mask)

	local var_3_4

	if var_3_1 then
		local var_3_3 = arg_3_0.goodsVO
		local var_3_5

		var_3_4, var_1_10009, var_3_5 = var_3_4.CheckArgLimit(var_3_3)

		if var_1_10009 == "pass" then
			setActive = var_11

			var_11(arg_3_0.limitPassTag, true)

			setScrollText = var_11
			findTF = var_13

			local var_3_6 = var_13(arg_3_0.limitPassTag, "TextGo/Text")

			i18n = var_14

			var_11(var_3_6, var_14("eventshop_unlock_info", var_3_5))

			onButton = var_11

			local var_3_7 = arg_3_0
			local var_3_8 = arg_3_0.mask

			local function var_3_9()
				pg = var_2_10000

				local var_4_0 = var_2_10000.TipsMgr.GetInstance()
				local var_4_1 = var_0.ShowTips

				i18n = var_2_10003

				var_4_1(var_4_0, var_2_10003("eventshop_unlock_hint", var_3_5))

				return
			end

			SFX_PANEL = var_16

			var_11(var_3_7, var_3_8, var_3_9, var_16)
		else
			setScrollText = var_11

			local var_3_10 = arg_3_0.unexchangeTag

			var_11(var_13.Find(var_3_10, "TextGo/Text"), var_3_5)

			var_3_2 = true
		end
	end

	if not var_5 then
		setActive = var_3_4

		var_3_4(arg_3_0.selloutTag, true)
	elseif var_3_2 then
		setActive = var_3_4

		var_3_4(arg_3_0.unexchangeTag, true)
	end

	Drop = var_3_4

	local var_3_11 = var_3_4.New({
		type = arg_3_1:getConfig("commodity_type"),
		id = arg_3_1:getConfig("commodity_id"),
		count = arg_3_1:getConfig("num")
	})

	updateDrop = var_1_10009

	var_1_10009(arg_3_0.itemTF, var_3_11)

	setActive = var_1_10009

	var_1_10009(arg_3_0.limitTimeSellTF, false)

	local var_3_12, var_3_13

	if var_5 then
		var_3_12 = arg_3_0.goodsVO
		var_1_10009, var_3_13, var_3_12 = var_1_10009.CheckTimeLimit(var_3_12)
		setActive = var_12

		var_12(arg_3_0.limitTimeSellTF, var_1_10009 and var_3_13)

		if var_1_10009 and not var_3_13 then
			setActive = var_12

			var_12(arg_3_0.mask, true)

			setActive = var_12

			var_12(arg_3_0.sellEndTag, true)

			removeOnButton = var_12

			var_12(arg_3_0.mask)

			onButton = var_12

			local var_3_14 = arg_3_0
			local var_3_15 = arg_3_0.mask

			local function var_3_16()
				if var_3_12 then
					pg = var_0

					local var_5_0 = var_0.TipsMgr.GetInstance()
					local var_5_1 = var_0.ShowTips

					i18n = var_2_10003

					local var_5_2 = "tip_build_ticket_exchange_expired"
					local var_5_3 = var_3_11

					var_5_1(var_5_0, var_2_10003(var_5_2, var_6.getName(var_5_3)))
				end

				return
			end

			SFX_PANEL = var_1_10017

			var_12(var_3_14, var_3_15, var_3_16, var_1_10017)
		end
	end

	GetSpriteFromAtlasAsync = var_1_10009
	Drop = var_3_12

	local var_3_17 = var_3_12.New
	local var_3_18 = {
		type = arg_3_1:getConfig("resource_category")
	}
	local var_3_19 = arg_3_1

	var_3_18.id = arg_3_1.getConfig(var_3_19, "resource_type")

	local var_3_20 = var_3_17(var_3_18)

	var_1_10009(var_11.getIcon(var_3_20), "", function(arg_6_0)
		arg_3_0.resIconTF.sprite = arg_6_0

		return
	end)

	setText = var_1_10009

	local var_3_21 = arg_3_0.countTF
	local var_3_22 = arg_3_1

	var_1_10009(var_3_21, arg_3_1.getConfig(var_3_22, "resource_num"))

	local var_3_23 = var_3_11
	local var_3_24

	if not var_3_11.getName(var_3_23) then
		var_3_24 = "??"
	end

	setScrollText = var_3_13

	var_3_13(arg_3_0.nameTxt, var_3_24)

	local var_3_25 = arg_3_1

	if arg_3_1.getConfig(var_3_25, "num_limit") == 0 then
		setText = var_3_23

		local var_3_26 = arg_3_0.limitCountLabelTF

		i18n = var_3_22

		var_3_23(var_3_26, var_3_22("common_no_limit"))
	else
		var_3_23 = arg_3_1:GetPurchasableCnt()
		setText = var_3_25

		local var_3_27 = arg_3_0.limitCountLabelTF

		i18n = var_15

		local var_3_28 = var_15("activity_shop_exchange_count")

		math = var_3_19

		var_3_25(var_3_27, var_3_28 .. var_3_19.max(var_3_23, 0) .. "/" .. var_10)
	end

	setActive = var_3_23

	var_3_23(arg_3_0.limitCountLabelTF, true)

	setActive = var_3_23

	local var_3_29 = arg_3_0.groupLocked
	local var_3_30 = arg_3_0.itemTF

	var_3_23(var_3_29, var_14.Find(var_3_30, "group_locked").gameObject.activeSelf)

	return
end

function var_0_1.updateSelectable(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.goodsVO = arg_7_1
	Drop = var_1_10005

	local var_7_0 = var_1_10005.New
	local var_7_1 = {
		count = 1
	}

	DROP_TYPE_ITEM = var_1_10008
	var_7_1.type = var_1_10008
	var_7_1.id = arg_7_1:getConfig("commodity_id_list_show")

	local var_7_2 = var_7_0(var_7_1)

	updateDrop = var_1_10006

	var_1_10006(arg_7_0.itemTF, var_7_2)

	setActive = var_1_10006

	var_1_10006(arg_7_0.mask, false)

	setActive = var_1_10006

	var_1_10006(arg_7_0.selloutTag, false)

	if arg_7_0.limitPassTag then
		setActive = var_6

		var_6(arg_7_0.limitPassTag, false)
	end

	removeOnButton = var_6

	var_6(arg_7_0.mask)

	setActive = var_6

	var_6(arg_7_0.limitTimeSellTF, false)

	GetSpriteFromAtlasAsync = var_6
	Drop = var_8

	local var_7_3 = var_8.New
	local var_7_4 = {
		type = arg_7_1:getConfig("resource_category")
	}
	local var_7_5 = arg_7_1

	var_7_4.id = arg_7_1.getConfig(var_7_5, "resource_type")

	local var_7_6 = var_7_3(var_7_4)

	var_6(var_8.getIcon(var_7_6), "", function(arg_8_0)
		arg_7_0.resIconTF.sprite = arg_8_0

		return
	end)

	setText = var_6

	local var_7_7 = arg_7_0.countTF
	local var_7_8 = arg_7_1

	var_6(var_7_7, arg_7_1.getConfig(var_7_8, "resource_num"))

	local var_7_9 = var_7_2
	local var_7_10

	if not var_7_2.getName(var_7_9) then
		var_7_10 = "??"
	end

	setScrollText = var_7_1

	var_7_1(arg_7_0.nameTxt, var_7_10)

	local var_7_11 = arg_7_1

	if arg_7_1.getConfig(var_7_11, "num_limit") == 0 then
		setText = var_7_9

		local var_7_12 = arg_7_0.limitCountLabelTF

		i18n = var_7_8

		var_7_9(var_7_12, var_7_8("common_no_limit"))
	else
		var_7_9 = arg_7_1:GetPurchasableCnt()
		setText = var_7_11

		local var_7_13 = arg_7_0.limitCountLabelTF

		i18n = var_12

		local var_7_14 = var_12("activity_shop_exchange_count")

		math = var_7_5

		var_7_11(var_7_13, var_7_14 .. var_7_5.max(var_7_9, 0) .. "/" .. var_7)
	end

	setActive = var_7_9

	local var_7_15 = arg_7_0.groupLocked
	local var_7_16 = arg_7_0.itemTF

	var_7_9(var_7_15, var_11.Find(var_7_16, "group_locked").gameObject.activeSelf)

	return
end

function var_0_1.setAsLastSibling(arg_9_0)
	local var_9_0 = arg_9_0.tf

	var_1.SetAsLastSibling(var_9_0)

	return
end

function var_0_1.StaticUpdate(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	tf = var_1_10004

	local var_10_0 = var_1_10004(arg_10_0)

	findTF = var_1_10005

	local var_10_1 = var_1_10005(var_10_0, "itemBg/item")

	findTF = var_6

	local var_10_2 = var_6(var_10_0, "name_mask/name")

	findTF = var_7

	local var_10_3 = var_7(var_10_0, "consume/contain/icon")
	local var_10_4 = var_7.GetComponent

	typeof = var_10
	Image = var_1_10012

	local var_10_5 = var_10_4(var_10_3, var_10(var_1_10012))
	local var_10_6 = var_10_0
	local var_10_7 = var_10_0.Find(var_10_6, "mask")
	local var_10_8 = var_10_0
	local var_10_9 = var_10_0.Find(var_10_8, "mask/tag/sellout_tag")

	findTF = var_10_6

	local var_10_10 = var_10_6(var_10_0, "consume/contain/Text")
	local var_10_11 = var_10.GetComponent

	typeof = var_13
	Text = var_1_10015

	local var_10_12 = var_10_11(var_10_10, var_13(var_1_10015))

	findTF = var_10_8

	local var_10_13 = var_10_8(var_10_0, "discount")

	setActive = var_10_10

	var_10_10(var_10_13, false)

	findTF = var_10_10

	local var_10_14 = var_10_10(var_10_0, "count_contain/label")
	local var_10_15 = var_12.GetComponent

	typeof = var_15
	Text = var_1_10017

	local var_10_16 = var_10_15(var_10_14, var_15(var_1_10017))
	local var_10_17 = arg_10_1
	local var_10_18, var_10_19 = arg_10_1.canPurchase(var_10_17)

	setActive = var_10_17

	var_10_17(var_10_7, not var_10_18)

	setActive = var_10_17

	var_10_17(var_10_9, not var_10_18)

	Drop = var_10_17

	local var_10_20 = var_10_17.New({
		type = arg_10_1:getConfig("commodity_type"),
		id = arg_10_1:getConfig("commodity_id"),
		count = arg_10_1:getConfig("num")
	})

	updateDrop = var_1_10016

	var_1_10016(var_10_1, var_10_20)

	local var_10_21 = var_10_20
	local var_10_22

	if not var_10_20.getConfig(var_10_21, "name") then
		var_10_22 = "??"
	end

	var_10_12.text = arg_10_1:getConfig("resource_num")
	setScrollText = var_17

	var_17(var_10_2, var_10_22)

	Drop = var_17

	local var_10_23 = var_17.New({
		type = arg_10_1:getConfig("resource_category"),
		id = arg_10_1:getConfig("resource_type")
	})
	local var_10_24 = var_17.getIcon(var_10_23)

	GetImageSpriteFromAtlasAsync = var_10_21

	var_10_21(var_10_24, "", var_10_5)

	if arg_10_1:getConfig("num_limit") == 0 then
		setText = var_18

		local var_10_25 = var_10_16

		i18n = var_21

		var_18(var_10_25, var_21("common_no_limit"))
	else
		local var_10_26 = arg_10_1
		local var_10_27 = arg_10_1.getConfig(var_10_26, "num_limit")
		local var_10_28 = var_10_20.type

		DROP_TYPE_SKIN = var_10_26

		if var_10_28 == var_10_26 and not var_10_18 then
			setText = var_10_28

			local var_10_29 = var_10_16

			i18n = var_22

			var_10_28(var_10_29, var_22("activity_shop_exchange_count") .. "0/" .. var_10_27)
		else
			setText = var_10_28

			local var_10_30 = var_10_16

			i18n = var_22

			var_10_28(var_10_30, var_22("activity_shop_exchange_count") .. var_10_27 - arg_10_1.buyCount .. "/" .. var_10_27)
		end
	end

	local var_10_31 = arg_10_1

	if arg_10_1.getConfig(var_10_31, "num_limit") >= 99 then
		setText = var_18
		var_10_31 = var_10_16
		i18n = var_21

		var_18(var_10_31, var_21("shop_label_unlimt_cnt"))
	end

	setActive = var_18
	findTF = var_10_31

	var_18(var_10_31(var_10_0, "group_locked"), var_10_1:Find("group_locked").gameObject.activeSelf)

	return
end

function var_0_1.OnDispose(arg_11_0)
	arg_11_0.goodsVO = nil

	return
end

return var_0_1
