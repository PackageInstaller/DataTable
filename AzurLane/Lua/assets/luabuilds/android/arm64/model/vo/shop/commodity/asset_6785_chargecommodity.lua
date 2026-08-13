class = var_0_10000

local var_0_0 = "ChargeCommodity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseCommodity"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.pay_data_display
end

function var_0_1.isChargeType(arg_2_0)
	return true
end

function var_0_1.canPurchase(arg_3_0)
	return arg_3_0:getLimitCount() <= 0 or var_1 > arg_3_0.buyCount
end

function var_0_1.firstPayDouble(arg_4_0)
	return arg_4_0:getConfig("first_pay_double") ~= 0
end

function var_0_1.hasExtraGem(arg_5_0)
	return arg_5_0:getConfig("extra_gem") ~= 0
end

function var_0_1.GetGemCnt(arg_6_0)
	return arg_6_0:getConfig("gem") + arg_6_0:getConfig("extra_gem")
end

function var_0_1.isGem(arg_7_0)
	local var_7_0 = arg_7_0:getConfig("extra_service")

	Goods = var_1_10002

	return var_7_0 == var_1_10002.GEM
end

function var_0_1.isGiftBox(arg_8_0)
	local var_8_0 = arg_8_0:getConfig("extra_service")

	Goods = var_1_10002

	return var_8_0 == var_1_10002.GIFT_BOX
end

function var_0_1.isMonthCard(arg_9_0)
	local var_9_0 = arg_9_0:getConfig("extra_service")

	Goods = var_1_10002

	return var_9_0 == var_1_10002.MONTH_CARD
end

function var_0_1.isItemBox(arg_10_0)
	local var_10_0 = arg_10_0:getConfig("extra_service")

	Goods = var_1_10002

	return var_10_0 == var_1_10002.ITEM_BOX
end

function var_0_1.isPassItem(arg_11_0)
	local var_11_0 = arg_11_0:getConfig("extra_service")

	Goods = var_1_10002

	return var_11_0 == var_1_10002.PASS_ITEM
end

function var_0_1.getLimitCount(arg_12_0)
	return arg_12_0:getConfig("limit_arg")
end

function var_0_1.GetName(arg_13_0)
	return arg_13_0:getConfig("name")
end

function var_0_1.GetDropList(arg_14_0)
	local var_14_0 = arg_14_0
	local var_14_1

	if #arg_14_0.getConfig(var_14_0, "display") == 0 then
		var_14_1 = arg_14_0:getConfig("extra_service_item")
	end

	local var_14_2 = {}

	ipairs = var_14_0

	for iter_14_0, iter_14_1 in var_14_0(var_14_1) do
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_14_3 = var_14_2

		Drop = var_1_10011

		var_1_10008(var_14_3, var_1_10011.Create(iter_14_1))
	end

	return var_14_2
end

function var_0_1.GetExtraServiceItem(arg_15_0)
	local var_15_0

	if arg_15_0:isPassItem() then
		local var_15_1 = arg_15_0
		local var_15_2 = arg_15_0.getConfig(var_15_1, "sub_display")[1]

		getProxy = var_15_1
		ActivityProxy = var_1_10006
		var_1_10006 = var_15_1(var_1_10006)

		local var_15_3 = var_4.getActivityById(var_1_10006, var_15_2)
		local var_15_4 = var_4.getConfig(var_15_3, "type")

		var_1_10006 = nil

		if var_15_4 == 2 then
			pg = var_15_3
			var_1_10006 = var_15_3.black_friday_battlepass_event_pt[var_15_2].award_pay
			PlayerConst = var_15_3
			var_15_3 = var_15_3.MergePassItemDrop
			underscore = var_1_10009
			var_15_0 = var_15_3(var_1_10009.map(var_1_10006, function(arg_16_0)
				Drop = var_2_10001

				local var_16_0 = var_2_10001.Create

				pg = var_2_10003

				return var_16_0(var_2_10003.black_friday_battlepass_event_award[arg_16_0].drop_client)
			end))
		elseif var_15_4 == 54 then
			pg = var_15_3
			var_1_10006 = var_15_3.battlepass_event_pt[var_15_2].award_pay
			PlayerConst = var_7

			local var_15_5 = var_7.MergePassItemDrop

			underscore = var_1_10009
			var_15_0 = var_15_5(var_1_10009.map(var_1_10006, function(arg_17_0)
				Drop = var_2_10001

				local var_17_0 = var_2_10001.Create

				pg = var_2_10003

				return var_17_0(var_2_10003.battlepass_event_award[arg_17_0].drop_client)
			end))
		end
	else
		underscore = var_2

		local var_15_6 = var_2.map

		var_1_10006 = arg_15_0
		var_15_0 = var_15_6(arg_15_0.getConfig(var_1_10006, "extra_service_item"), function(arg_18_0)
			Drop = var_2_10001

			return var_2_10001.Create(arg_18_0)
		end)
	end

	local var_15_7 = arg_15_0:GetGemCnt()

	if not arg_15_0:isMonthCard() and 0 < var_15_7 then
		table = var_3

		local var_15_8 = var_3.insert
		local var_15_9 = var_15_0

		Drop = var_1_10006

		local var_15_10 = var_1_10006.New
		local var_15_11 = {}

		DROP_TYPE_RESOURCE = var_1_10009
		var_15_11.type = var_1_10009
		PlayerConst = var_1_10009
		var_15_11.id = var_1_10009.ResDiamond
		var_15_11.count = var_15_7

		var_15_8(var_15_9, var_15_10(var_15_11))
	end

	return var_15_0
end

function var_0_1.GetBonusItem(arg_19_0)
	if arg_19_0:isMonthCard() then
		Drop = var_1

		local var_19_0 = var_1.New
		local var_19_1 = {}

		DROP_TYPE_RESOURCE = var_1_10004
		var_19_1.type = var_1_10004
		PlayerConst = var_1_10004
		var_19_1.id = var_1_10004.ResDiamond
		var_19_1.count = arg_19_0:GetGemCnt()

		return var_19_0(var_19_1)
	end

	return nil
end

function var_0_1.GetChargeTip(arg_20_0)
	local var_20_0
	local var_20_1

	if arg_20_0:isPassItem() then
		i18n = var_3
		var_20_0 = var_3("battlepass_pay_tip")
	elseif arg_20_0:isMonthCard() then
		i18n = var_3
		var_20_0 = var_3("charge_title_getitem_month")
		i18n = var_3
		var_20_1 = var_3("charge_title_getitem_soon")
	else
		i18n = var_3
		var_20_0 = var_3("charge_title_getitem")
	end

	return var_20_0, var_20_1
end

function var_0_1.GetExtraDrop(arg_21_0)
	local var_21_0

	if arg_21_0:isPassItem() then
		unpack = var_2

		local var_21_1 = arg_21_0
		local var_21_2, var_21_3 = var_2(arg_21_0.getConfig(var_21_1, "sub_display"))

		getProxy = var_4
		ActivityProxy = var_21_1

		local var_21_4 = var_4(var_21_1)
		local var_21_5 = var_4.getActivityById(var_21_4, var_21_2)

		if var_4.getConfig(var_21_5, "type") == 2 then
			pg = var_21_4
			var_21_4 = var_21_4.black_friday_battlepass_event_pt[var_21_2].pt
			Drop = var_21_5
			var_21_5 = var_21_5.New

			local var_21_6 = {}

			DROP_TYPE_VITEM = var_1_10010
			var_21_6.type = var_1_10010
			pg = var_1_10010
			var_21_6.id = var_1_10010.black_friday_battlepass_event_pt[var_21_2].pt
			var_21_6.count = var_21_3
			var_21_0 = var_21_5(var_21_6)
		elseif var_5 == 54 then
			pg = var_21_4

			local var_21_7 = var_21_4.battlepass_event_pt[var_21_2].pt

			Drop = var_21_5

			local var_21_8 = var_21_5.New
			local var_21_9 = {}

			DROP_TYPE_VITEM = var_1_10010
			var_21_9.type = var_1_10010
			pg = var_1_10010
			var_21_9.id = var_1_10010.battlepass_event_pt[var_21_2].pt
			var_21_9.count = var_21_3
			var_21_0 = var_21_8(var_21_9)
		end
	end

	return var_21_0
end

function var_0_1.getConfig(arg_22_0, arg_22_1)
	if arg_22_1 == "money" then
		PLATFORM_CODE = var_1_10002
		PLATFORM_CHT = var_1_10003

		if var_1_10002 == var_1_10003 then
			pg = var_1_10002

			local var_22_0 = var_1_10002.SdkMgr.GetInstance()

			if var_1_10002.GetProduct(var_22_0, arg_22_0:getConfig("id_str")) then
				return var_1_10002.price
			else
				return arg_22_0:RawGetConfig(arg_22_1)
			end

			goto label_22_0
		end
	end

	if arg_22_1 == "money" then
		PLATFORM_CODE = var_1_10002
		PLATFORM_US = var_1_10003

		if var_1_10002 == var_1_10003 then
			local var_22_1 = arg_22_0:RawGetConfig(arg_22_1)

			math = var_1_10003

			local var_22_2 = var_1_10003.floor(var_22_1 / 100)
			local var_22_3 = "."

			math = var_5

			do return var_22_2 .. var_22_3 .. var_22_1 - var_5.floor(var_22_1 / 100) * 100 end

			goto label_22_0
		end
	end

	do return arg_22_0:RawGetConfig(arg_22_1) end

	::label_22_0::

	return
end

function var_0_1.RawGetConfig(arg_23_0, arg_23_1)
	return var_0_1.super.getConfig(arg_23_0, arg_23_1)
end

function var_0_1.IsLocalPrice(arg_24_0)
	return arg_24_0:getConfig("money") ~= arg_24_0:RawGetConfig("money")
end

function var_0_1.isLevelLimit(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0, var_25_1 = arg_25_0:getLevelLimit()

	if arg_25_2 and var_25_1 then
		return false
	end

	return var_25_0 > 0 and arg_25_1 < var_25_0
end

function var_0_1.getLevelLimit(arg_26_0)
	local var_26_0 = arg_26_0:getConfig("limit_args")

	ipairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(var_26_0) do
		type = var_1_10007

		if var_1_10007(iter_26_1) == "table" and iter_26_1[1] == "level" then
			return iter_26_1[2], iter_26_1[3]
		end
	end

	return 0
end

function var_0_1.getSameLimitGroupTecGoods(arg_27_0)
	local var_27_0 = {}
	local var_27_1 = arg_27_0
	local var_27_2 = arg_27_0.getConfig(var_27_1, "limit_group")
	local var_27_3 = arg_27_0:bindConfigTable()

	ipairs = var_27_1

	for iter_27_0, iter_27_1 in var_27_1(var_27_3.all) do
		if var_27_3[iter_27_1].limit_group == var_27_2 then
			Goods = var_10

			local var_27_4 = var_10.Create
			local var_27_5 = {
				shop_id = iter_27_1
			}

			Goods = var_1_10013

			local var_27_6 = var_27_4(var_27_5, var_1_10013.TYPE_CHARGE)

			table = var_1_10011

			var_1_10011.insert(var_27_0, var_27_6)
		end
	end

	return var_27_0
end

function var_0_1.getShowType(arg_28_0)
	if arg_28_0:getConfig("show_group") == "" then
		-- block empty
	end

	return var_1
end

function var_0_1.CanViewSkinProbability(arg_29_0)
	if not arg_29_0:getConfig("skin_inquire_relation") or var_1 <= 0 then
		return false
	end

	pg = var_1_10002

	if var_1_10002.gameset.package_view_display.key_value == 0 then
		return false
	end

	return true
end

function var_0_1.GetSkinProbability(arg_30_0)
	local var_30_0 = {}

	if arg_30_0:CanViewSkinProbability() then
		local var_30_1 = arg_30_0:getConfig("skin_inquire_relation")

		Item = var_1_10003
		var_30_0 = var_1_10003.getConfigData(var_30_1).combination_display
	end

	return var_30_0
end

function var_0_1.GetSkinProbabilityItem(arg_31_0)
	if not arg_31_0:CanViewSkinProbability() then
		return nil
	end

	local var_31_0 = arg_31_0
	local var_31_1 = arg_31_0.getConfig(var_31_0, "skin_inquire_relation")
	local var_31_2 = {
		count = 1
	}

	DROP_TYPE_ITEM = var_31_0
	var_31_2.type = var_31_0
	var_31_2.id = var_31_1

	return var_31_2
end

function var_0_1.GetDropItem(arg_32_0)
	if #arg_32_0:getConfig("drop_item") > 0 then
		return var_1
	else
		assert = var_2

		var_2(false, "should exist drop item")
	end

	return
end

function var_0_1.GetLimitDesc(arg_33_0)
	local var_33_0 = arg_33_0:getLimitCount()
	local var_33_1

	if not arg_33_0.buyCount then
		var_33_1 = 0
	end

	if 0 < var_33_0 then
		i18n = var_3

		return var_3("charge_limit_all", var_33_0 - var_33_1, var_33_0)
	end

	local var_33_2 = arg_33_0

	if arg_33_0.getConfig(var_33_2, "group_limit") > 0 then
		local var_33_3

		if not arg_33_0:getConfig("group_type") then
			var_33_3 = 0
		end

		if var_33_3 == 1 then
			i18n = var_33_2

			return var_33_2("charge_limit_daily", var_3 - arg_33_0.groupCount, var_3)
		elseif var_33_3 == 2 then
			i18n = var_33_2

			return var_33_2("charge_limit_weekly", var_3 - arg_33_0.groupCount, var_3)
		elseif var_33_3 == 3 then
			i18n = var_33_2

			return var_33_2("charge_limit_monthly", var_3 - arg_33_0.groupCount, var_3)
		end
	end

	return ""
end

function var_0_1.GetInfoTip(arg_34_0)
	if not arg_34_0:isItemBox() or arg_34_0:getConfig("tip_open") == 0 then
		return ""
	else
		return arg_34_0:getConfig("tip")
	end

	return
end

function var_0_1.GetPackageTag(arg_35_0)
	if not arg_35_0:isItemBox() or arg_35_0:getConfig("package_tag_open") == 0 then
		return ""
	else
		return arg_35_0:getConfig("package_tag")
	end

	return
end

function var_0_1.isTip(arg_36_0)
	if arg_36_0:isGiftPackage() or arg_36_0:isActGiftPackage() then
		local var_36_0 = arg_36_0
		local var_36_1 = arg_36_0.getConfig(var_36_0, "akashi_pick") > 0 and "payshop_pack_red_dot" or "gemshop_pack_red_dot"

		unpack = var_36_0
		getGameset = var_1_10005

		local var_36_2, var_36_3 = var_36_0(var_1_10005(var_36_1))

		PlayerPrefs = var_5

		if var_5.GetInt(var_36_1, 0) ~= var_36_2 then
			table = var_5

			if var_5.contains(var_36_3[1], arg_36_0.id) then
				return true
			end
		end

		return arg_36_0:isFree()
	end

	return
end

function var_0_1.isTip(arg_37_0)
	local var_37_0 = arg_37_0
	local var_37_1 = arg_37_0.getConfig(var_37_0, "akashi_pick") > 0 and "payshop_pack_red_dot" or "gemshop_pack_red_dot"

	unpack = var_37_0
	getGameset = var_1_10005

	local var_37_2, var_37_3 = var_37_0(var_1_10005(var_37_1))

	PlayerPrefs = var_5

	if var_5.GetInt(var_37_1, 0) ~= var_37_2 then
		table = var_5

		if var_5.contains(var_37_3[2], arg_37_0.id) then
			return true
		end
	end

	return arg_37_0:isFree()
end

return var_0_1
