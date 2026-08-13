class = var_0_10000

local var_0_0 = "ActivityGoodsCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseGoodsCard"))

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
	local var_3_2

	if var_5.CheckCntLimit(var_3_0) then
		::label_3_0::

		local var_3_1 = arg_3_0.goodsVO

		var_3_2 = not var_6.CheckArgLimit(var_3_1)
	end

	local var_3_3 = false

	setActive = var_1_10008

	var_1_10008(arg_3_0.mask, not var_5 or var_3_2)

	setActive = var_1_10008

	var_1_10008(arg_3_0.selloutTag, false)

	if arg_3_0.limitPassTag then
		setActive = var_3_5

		var_3_5(arg_3_0.limitPassTag, false)
	end

	setActive = var_3_5

	var_3_5(arg_3_0.unexchangeTag, false)

	removeOnButton = var_3_5

	var_3_5(arg_3_0.mask)

	local var_3_5

	if var_3_2 then
		local var_3_4 = arg_3_0.goodsVO
		local var_3_6, var_3_7

		var_3_5, var_3_6, var_3_7 = var_3_5.CheckArgLimit(var_3_4)

		if var_3_6 == "pass" then
			setActive = var_1_10011

			var_1_10011(arg_3_0.limitPassTag, true)

			setScrollText = var_1_10011
			findTF = var_12

			local var_3_8 = var_12(arg_3_0.limitPassTag, "TextGo/Text")

			i18n = var_13

			var_1_10011(var_3_8, var_13("eventshop_unlock_info", var_3_7))

			onButton = var_1_10011

			local var_3_9 = arg_3_0
			local var_3_10 = arg_3_0.mask

			local function var_3_11()
				pg = var_2_10000

				local var_4_0 = var_2_10000.TipsMgr.GetInstance()
				local var_4_1 = var_0.ShowTips

				i18n = var_2_10002

				var_4_1(var_4_0, var_2_10002("eventshop_unlock_hint", var_3_7))

				return
			end

			SFX_PANEL = var_15

			var_1_10011(var_3_9, var_3_10, var_3_11, var_15)
		else
			setScrollText = var_1_10011

			local var_3_12 = arg_3_0.unexchangeTag

			var_1_10011(var_12.Find(var_3_12, "TextGo/Text"), var_3_7)

			var_3_3 = true
		end
	end

	if not var_5 then
		setActive = var_3_5

		var_3_5(arg_3_0.selloutTag, true)
	elseif var_3_3 then
		setActive = var_3_5

		var_3_5(arg_3_0.unexchangeTag, true)
	end

	Drop = var_3_5

	local var_3_13 = var_3_5.New({
		type = arg_3_1:getConfig("commodity_type"),
		id = arg_3_1:getConfig("commodity_id"),
		count = arg_3_1:getConfig("num")
	})

	updateDrop = var_3_15

	var_3_15(arg_3_0.itemTF, var_3_13)

	setActive = var_3_15

	var_3_15(arg_3_0.limitTimeSellTF, false)

	local var_3_14, var_3_15

	if var_5 then
		var_3_14 = arg_3_0.goodsVO

		local var_3_16

		var_3_15, var_3_14, var_3_16 = var_3_15.CheckTimeLimit(var_3_14)
		setActive = var_12

		var_12(arg_3_0.limitTimeSellTF, var_3_15 and var_3_14)

		if var_3_15 and not var_3_14 then
			setActive = var_12

			var_12(arg_3_0.mask, true)

			setActive = var_12

			var_12(arg_3_0.sellEndTag, true)

			removeOnButton = var_12

			var_12(arg_3_0.mask)

			onButton = var_12

			local var_3_17 = arg_3_0
			local var_3_18 = arg_3_0.mask

			local function var_3_19()
				if var_3_16 then
					pg = var_0

					local var_5_0 = var_0.TipsMgr.GetInstance()
					local var_5_1 = var_0.ShowTips

					i18n = var_2_10002

					local var_5_2 = "tip_build_ticket_exchange_expired"
					local var_5_3 = var_3_13

					var_5_1(var_5_0, var_2_10002(var_5_2, var_4.getName(var_5_3)))
				end

				return
			end

			SFX_PANEL = var_1_10016

			var_12(var_3_17, var_3_18, var_3_19, var_1_10016)
		end
	end

	GetSpriteFromAtlasAsync = var_3_15
	Drop = var_3_14

	local var_3_20 = var_3_14.New({
		type = arg_3_1:getConfig("resource_category"),
		id = arg_3_1:getConfig("resource_type")
	})

	var_3_15(var_10.getIcon(var_3_20), "", function(arg_6_0)
		arg_3_0.resIconTF.sprite = arg_6_0

		return
	end)

	setText = var_3_15

	var_3_15(arg_3_0.countTF, arg_3_1:getConfig("resource_num"))

	local var_3_21 = var_3_13
	local var_3_22

	if not var_3_13.getName(var_3_21) then
		var_3_22 = "??"
	end

	setScrollText = var_3_21

	var_3_21(arg_3_0.nameTxt, var_3_22)

	local var_3_23 = arg_3_1

	if arg_3_1.getConfig(var_3_23, "num_limit") == 0 then
		setText = var_3_23

		local var_3_24 = arg_3_0.limitCountLabelTF

		i18n = var_13

		var_3_23(var_3_24, var_13("common_no_limit"))
	else
		local var_3_25 = arg_3_1

		var_3_23 = arg_3_1.GetPurchasableCnt(var_3_25)
		setText = var_3_25

		local var_3_26 = arg_3_0.limitCountLabelTF

		i18n = var_14

		local var_3_27 = var_14("activity_shop_exchange_count")

		math = var_15

		var_3_25(var_3_26, var_3_27 .. var_15.max(var_3_23, 0) .. "/" .. var_10)
	end

	setActive = var_3_23

	var_3_23(arg_3_0.limitCountLabelTF, true)

	setActive = var_3_23

	local var_3_28 = arg_3_0.groupLocked
	local var_3_29 = arg_3_0.itemTF

	var_3_23(var_3_28, var_13.Find(var_3_29, "group_locked").gameObject.activeSelf)

	return
end

function var_0_1.updateSelectable(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.goodsVO = arg_7_1
	Drop = var_1_10005

	local var_7_0 = var_1_10005.New
	local var_7_1 = {
		count = 1
	}

	DROP_TYPE_ITEM = var_1_10007
	var_7_1.type = var_1_10007
	var_7_1.id = arg_7_1:getConfig("commodity_id_list_show")

	local var_7_2 = var_7_0(var_7_1)

	updateDrop = var_7_1

	var_7_1(arg_7_0.itemTF, var_7_2)

	setActive = var_7_1

	var_7_1(arg_7_0.mask, false)

	setActive = var_7_1

	var_7_1(arg_7_0.selloutTag, false)

	if arg_7_0.limitPassTag then
		setActive = var_6

		var_6(arg_7_0.limitPassTag, false)
	end

	removeOnButton = var_6

	var_6(arg_7_0.mask)

	setActive = var_6

	var_6(arg_7_0.limitTimeSellTF, false)

	GetSpriteFromAtlasAsync = var_6
	Drop = var_7

	local var_7_3 = var_7.New({
		type = arg_7_1:getConfig("resource_category"),
		id = arg_7_1:getConfig("resource_type")
	})

	var_6(var_7.getIcon(var_7_3), "", function(arg_8_0)
		arg_7_0.resIconTF.sprite = arg_8_0

		return
	end)

	setText = var_6

	var_6(arg_7_0.countTF, arg_7_1:getConfig("resource_num"))

	local var_7_4 = var_7_2
	local var_7_5

	if not var_7_2.getName(var_7_4) then
		var_7_5 = "??"
	end

	setScrollText = var_7_4

	var_7_4(arg_7_0.nameTxt, var_7_5)

	local var_7_6 = arg_7_1

	if arg_7_1.getConfig(var_7_6, "num_limit") == 0 then
		setText = var_7_6

		local var_7_7 = arg_7_0.limitCountLabelTF

		i18n = var_10

		var_7_6(var_7_7, var_10("common_no_limit"))
	else
		local var_7_8 = arg_7_1

		var_7_6 = arg_7_1.GetPurchasableCnt(var_7_8)
		setText = var_7_8

		local var_7_9 = arg_7_0.limitCountLabelTF

		i18n = var_11

		local var_7_10 = var_11("activity_shop_exchange_count")

		math = var_12

		var_7_8(var_7_9, var_7_10 .. var_12.max(var_7_6, 0) .. "/" .. var_7)
	end

	setActive = var_7_6

	local var_7_11 = arg_7_0.groupLocked
	local var_7_12 = arg_7_0.itemTF

	var_7_6(var_7_11, var_10.Find(var_7_12, "group_locked").gameObject.activeSelf)

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

	findTF = var_5

	local var_10_1 = var_5(var_10_0, "itemBg/item")

	findTF = var_6

	local var_10_2 = var_6(var_10_0, "name_mask/name")

	findTF = var_7

	local var_10_3 = var_7(var_10_0, "consume/contain/icon")
	local var_10_4 = var_7.GetComponent

	typeof = var_9
	Image = var_1_10010

	local var_10_5 = var_10_4(var_10_3, var_9(var_1_10010))
	local var_10_6 = var_10_0:Find("mask")
	local var_10_7 = var_10_0
	local var_10_8 = var_10_0.Find(var_10_7, "mask/tag/sellout_tag")

	findTF = var_10_7

	local var_10_9 = var_10_7(var_10_0, "consume/contain/Text")
	local var_10_10 = var_10.GetComponent

	typeof = var_12
	Text = var_1_10013

	local var_10_11 = var_10_10(var_10_9, var_12(var_1_10013))

	findTF = var_10_9

	local var_10_12 = var_10_9(var_10_0, "discount")

	setActive = var_12

	var_12(var_10_12, false)

	findTF = var_12

	local var_10_13 = var_12(var_10_0, "count_contain/label")
	local var_10_14 = var_12.GetComponent

	typeof = var_14
	Text = var_1_10015

	local var_10_15 = var_10_14(var_10_13, var_14(var_1_10015))
	local var_10_16, var_10_17 = arg_10_1:canPurchase()

	setActive = var_1_10015

	var_1_10015(var_10_6, not var_10_16)

	setActive = var_1_10015

	var_1_10015(var_10_8, not var_10_16)

	Drop = var_1_10015

	local var_10_18 = var_1_10015.New({
		type = arg_10_1:getConfig("commodity_type"),
		id = arg_10_1:getConfig("commodity_id"),
		count = arg_10_1:getConfig("num")
	})

	updateDrop = var_16

	var_16(var_10_1, var_10_18)

	local var_10_19

	if not var_10_18:getConfig("name") then
		var_10_19 = "??"
	end

	var_10_11.text = arg_10_1:getConfig("resource_num")
	setScrollText = var_17

	var_17(var_10_2, var_10_19)

	Drop = var_17

	local var_10_20 = var_17.New({
		type = arg_10_1:getConfig("resource_category"),
		id = arg_10_1:getConfig("resource_type")
	})
	local var_10_21 = var_17.getIcon(var_10_20)

	GetImageSpriteFromAtlasAsync = var_10_20

	var_10_20(var_10_21, "", var_10_5)

	if arg_10_1:getConfig("num_limit") == 0 then
		setText = var_18

		local var_10_22 = var_10_15

		i18n = var_20

		var_18(var_10_22, var_20("common_no_limit"))
	else
		local var_10_23 = arg_10_1:getConfig("num_limit")
		local var_10_24 = var_10_18.type

		DROP_TYPE_SKIN = var_20

		if var_10_24 == var_20 and not var_10_16 then
			setText = var_10_24

			local var_10_25 = var_10_15

			i18n = var_21

			var_10_24(var_10_25, var_21("activity_shop_exchange_count") .. "0/" .. var_10_23)
		else
			setText = var_10_24

			local var_10_26 = var_10_15

			i18n = var_21

			var_10_24(var_10_26, var_21("activity_shop_exchange_count") .. var_10_23 - arg_10_1.buyCount .. "/" .. var_10_23)
		end
	end

	local var_10_27 = arg_10_1:getConfig("num_limit")
	local var_10_28

	if 99 <= var_10_27 then
		setText = var_10_27
		var_10_28 = var_10_15
		i18n = var_20

		var_10_27(var_10_28, var_20("shop_label_unlimt_cnt"))
	end

	setActive = var_10_27
	findTF = var_10_28

	var_10_27(var_10_28(var_10_0, "group_locked"), var_10_1:Find("group_locked").gameObject.activeSelf)

	return
end

function var_0_1.OnDispose(arg_11_0)
	arg_11_0.goodsVO = nil

	return
end

return var_0_1
