local var_0_0 = class("ChargeCommodity", import(".BaseCommodity"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.pay_data_display
end

function var_0_0.isChargeType(arg_2_0)
	return true
end

function var_0_0.canPurchase(arg_3_0)
	local var_3_0 = arg_3_0:getLimitCount()

	return var_3_0 <= 0 or var_3_0 > arg_3_0.buyCount
end

function var_0_0.firstPayDouble(arg_4_0)
	return arg_4_0:getConfig("first_pay_double") ~= 0
end

function var_0_0.hasExtraGem(arg_5_0)
	return arg_5_0:getConfig("extra_gem") ~= 0
end

function var_0_0.GetGemCnt(arg_6_0)
	return arg_6_0:getConfig("gem") + arg_6_0:getConfig("extra_gem")
end

function var_0_0.isGem(arg_7_0)
	return arg_7_0:getConfig("extra_service") == Goods.GEM
end

function var_0_0.isGiftBox(arg_8_0)
	return arg_8_0:getConfig("extra_service") == Goods.GIFT_BOX
end

function var_0_0.isMonthCard(arg_9_0)
	return arg_9_0:getConfig("extra_service") == Goods.MONTH_CARD
end

function var_0_0.isItemBox(arg_10_0)
	return arg_10_0:getConfig("extra_service") == Goods.ITEM_BOX
end

function var_0_0.isPassItem(arg_11_0)
	return arg_11_0:getConfig("extra_service") == Goods.PASS_ITEM
end

function var_0_0.getLimitCount(arg_12_0)
	return arg_12_0:getConfig("limit_arg")
end

function var_0_0.GetName(arg_13_0)
	return arg_13_0:getConfig("name")
end

function var_0_0.GetDropList(arg_14_0)
	local var_14_0 = arg_14_0:getConfig("display")

	if #var_14_0 == 0 then
		var_14_0 = arg_14_0:getConfig("extra_service_item")
	end

	local var_14_1 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		table.insert(var_14_1, Drop.Create(iter_14_1))
	end

	return var_14_1
end

function var_0_0.GetExtraServiceItem(arg_15_0)
	local var_15_0

	if arg_15_0:isPassItem() then
		local var_15_1 = arg_15_0:getConfig("sub_display")[1]
		local var_15_2 = getProxy(ActivityProxy):getActivityById(var_15_1):getConfig("type")

		if var_15_2 == 2 then
			var_15_0 = PlayerConst.MergePassItemDrop(underscore.map(pg.black_friday_battlepass_event_pt[var_15_1].award_pay, function(arg_16_0)
				return Drop.Create(pg.black_friday_battlepass_event_award[arg_16_0].drop_client)
			end))
		elseif var_15_2 == 54 then
			var_15_0 = PlayerConst.MergePassItemDrop(underscore.map(pg.battlepass_event_pt[var_15_1].award_pay, function(arg_17_0)
				return Drop.Create(pg.battlepass_event_award[arg_17_0].drop_client)
			end))
		end
	else
		var_15_0 = underscore.map(arg_15_0:getConfig("extra_service_item"), function(arg_18_0)
			return Drop.Create(arg_18_0)
		end)
	end

	local var_15_4 = arg_15_0:GetGemCnt()

	if not arg_15_0:isMonthCard() and var_15_4 > 0 then
		table.insert(var_15_0, Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResDiamond,
			count = var_15_4
		}))
	end

	return var_15_0
end

function var_0_0.GetBonusItem(arg_19_0)
	if arg_19_0:isMonthCard() then
		return Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResDiamond,
			count = arg_19_0:GetGemCnt()
		})
	end

	return nil
end

function var_0_0.GetChargeTip(arg_20_0)
	local var_20_0
	local var_20_1

	if arg_20_0:isPassItem() then
		var_20_0 = i18n("battlepass_pay_tip")
	elseif arg_20_0:isMonthCard() then
		var_20_0 = i18n("charge_title_getitem_month")
		var_20_1 = i18n("charge_title_getitem_soon")
	else
		var_20_0 = i18n("charge_title_getitem")
	end

	return var_20_0, var_20_1
end

function var_0_0.GetExtraDrop(arg_21_0)
	local var_21_0

	if arg_21_0:isPassItem() then
		local var_21_1, var_21_2 = unpack(arg_21_0:getConfig("sub_display"))
		local var_21_3 = getProxy(ActivityProxy):getActivityById(var_21_1):getConfig("type")

		if var_21_3 == 2 then
			var_21_0 = Drop.New({
				type = DROP_TYPE_VITEM,
				id = pg.black_friday_battlepass_event_pt[var_21_1].pt,
				count = var_21_2
			})
		elseif var_21_3 == 54 then
			var_21_0 = Drop.New({
				type = DROP_TYPE_VITEM,
				id = pg.battlepass_event_pt[var_21_1].pt,
				count = var_21_2
			})
		end
	end

	return var_21_0
end

function var_0_0.getConfig(arg_22_0, arg_22_1)
	if arg_22_1 == "money" and PLATFORM_CODE == PLATFORM_CHT then
		local var_22_0 = pg.SdkMgr.GetInstance():GetProduct(arg_22_0:getConfig("id_str"))

		if var_22_0 then
			return var_22_0.price
		else
			return arg_22_0:RawGetConfig(arg_22_1)
		end
	elseif arg_22_1 == "money" and PLATFORM_CODE == PLATFORM_US then
		local var_22_1 = arg_22_0:RawGetConfig(arg_22_1)

		return math.floor(var_22_1 / 100) .. "." .. var_22_1 - math.floor(var_22_1 / 100) * 100
	else
		return arg_22_0:RawGetConfig(arg_22_1)
	end

	return
end

function var_0_0.RawGetConfig(arg_23_0, arg_23_1)
	return var_0_0.super.getConfig(arg_23_0, arg_23_1)
end

function var_0_0.IsLocalPrice(arg_24_0)
	return arg_24_0:getConfig("money") ~= arg_24_0:RawGetConfig("money")
end

function var_0_0.isLevelLimit(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0, var_25_1 = arg_25_0:getLevelLimit()

	if arg_25_2 and var_25_1 then
		return false
	end

	return var_25_0 > 0 and arg_25_1 < var_25_0
end

function var_0_0.getLevelLimit(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs((arg_26_0:getConfig("limit_args"))) do
		if type(iter_26_1) == "table" and iter_26_1[1] == "level" then
			return iter_26_1[2], iter_26_1[3]
		end
	end

	return 0
end

function var_0_0.getSameLimitGroupTecGoods(arg_27_0)
	local var_27_0 = arg_27_0:getConfig("limit_group")
	local var_27_1 = arg_27_0:bindConfigTable()

	for iter_27_0, iter_27_1 in ipairs(var_27_1.all) do
		if var_27_1[iter_27_1].limit_group == var_27_0 then
			table.insert({}, (Goods.Create({
				shop_id = iter_27_1
			}, Goods.TYPE_CHARGE)))
		end
	end

	return {}
end

function var_0_0.getShowType(arg_28_0)
	local var_28_0 = arg_28_0:getConfig("show_group")

	if var_28_0 == "" then
		-- block empty
	end

	return var_28_0
end

function var_0_0.CanViewSkinProbability(arg_29_0)
	local var_29_0 = arg_29_0:getConfig("skin_inquire_relation")

	if not var_29_0 or var_29_0 <= 0 then
		return false
	end

	if pg.gameset.package_view_display.key_value == 0 then
		return false
	end

	return true
end

function var_0_0.GetSkinProbability(arg_30_0)
	local var_30_0 = {}

	if arg_30_0:CanViewSkinProbability() then
		var_30_0 = Item.getConfigData((arg_30_0:getConfig("skin_inquire_relation"))).combination_display
	end

	return var_30_0
end

function var_0_0.GetSkinProbabilityItem(arg_31_0)
	if not arg_31_0:CanViewSkinProbability() then
		return nil
	end

	;({
		count = 1,
		type = DROP_TYPE_ITEM
	}).id = arg_31_0:getConfig("skin_inquire_relation")

	return {
		count = 1,
		type = DROP_TYPE_ITEM
	}
end

function var_0_0.GetDropItem(arg_32_0)
	local var_32_0 = arg_32_0:getConfig("drop_item")

	if #var_32_0 > 0 then
		return var_32_0
	else
		assert(false, "should exist drop item")
	end

	return
end

function var_0_0.GetLimitDesc(arg_33_0)
	local var_33_0 = arg_33_0:getLimitCount()
	local var_33_1 = arg_33_0.buyCount or 0

	if var_33_0 > 0 then
		return i18n("charge_limit_all", var_33_0 - var_33_1, var_33_0)
	end

	local var_33_2 = arg_33_0:getConfig("group_limit")

	if var_33_2 > 0 then
		local var_33_3 = arg_33_0:getConfig("group_type") or 0

		if var_33_3 == 1 then
			return i18n("charge_limit_daily", var_33_2 - arg_33_0.groupCount, var_33_2)
		elseif var_33_3 == 2 then
			return i18n("charge_limit_weekly", var_33_2 - arg_33_0.groupCount, var_33_2)
		elseif var_33_3 == 3 then
			return i18n("charge_limit_monthly", var_33_2 - arg_33_0.groupCount, var_33_2)
		end
	end

	return ""
end

function var_0_0.GetInfoTip(arg_34_0)
	if not arg_34_0:isItemBox() or arg_34_0:getConfig("tip_open") == 0 then
		return ""
	else
		return arg_34_0:getConfig("tip")
	end

	return
end

function var_0_0.GetPackageTag(arg_35_0)
	if not arg_35_0:isItemBox() or arg_35_0:getConfig("package_tag_open") == 0 then
		return ""
	else
		return arg_35_0:getConfig("package_tag")
	end

	return
end

function var_0_0.isTip(arg_36_0)
	if arg_36_0:isGiftPackage() or arg_36_0:isActGiftPackage() then
		local var_36_0 = arg_36_0:getConfig("akashi_pick") > 0 and "payshop_pack_red_dot" or "gemshop_pack_red_dot"
		local var_36_1, var_36_2 = unpack(getGameset(var_36_0))

		if PlayerPrefs.GetInt(var_36_0, 0) ~= var_36_1 and table.contains(var_36_2[1], arg_36_0.id) then
			return true
		end

		return arg_36_0:isFree()
	end

	return
end

function var_0_0.isTip(arg_37_0)
	local var_37_0 = arg_37_0:getConfig("akashi_pick") > 0 and "payshop_pack_red_dot" or "gemshop_pack_red_dot"
	local var_37_1, var_37_2 = unpack(getGameset(var_37_0))

	if PlayerPrefs.GetInt(var_37_0, 0) ~= var_37_1 and table.contains(var_37_2[2], arg_37_0.id) then
		return true
	end

	return arg_37_0:isFree()
end

return var_0_0
