class = var_0_10000

local var_0_0 = "CommonCommodity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseCommodity"))

function var_0_1.InCommodityDiscountTime(arg_1_0)
	pg = var_1_10001

	if var_1_10001.shop_template[arg_1_0].discount_time == "always" then
		return true
	end

	type = var_1_10003

	if var_1_10003(var_2) == "table" then
		table = var_3

		local var_1_1

		if var_3.getCount(var_2) ~= 0 then
			pg = var_3

			local var_1_0 = var_3.TimeMgr.GetInstance()

			var_1_1 = var_3.inTime(var_1_0, var_2)

			if false then
				var_1_1 = false
			end
		else
			var_1_1 = true
		end

		return var_1_1
	end

	return false
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.shop_template
end

function var_0_1.canPurchase(arg_3_0)
	local var_3_0 = arg_3_0.type

	Goods = var_1_10002

	local var_3_1

	if var_3_0 == var_1_10002.TYPE_MILITARY then
		var_3_1 = arg_3_0

		do return arg_3_0.getBuyCount(var_3_1) == 0 end

		goto label_3_0
	end

	local var_3_2 = arg_3_0.type

	Goods = var_3_1

	if var_3_2 ~= var_3_1.TYPE_GIFT_PACKAGE then
		local var_3_3 = arg_3_0.type

		Goods = var_3_6

		if var_3_3 ~= var_3_6.TYPE_SKIN then
			local var_3_4 = arg_3_0.type

			Goods = var_3_6

			if var_3_4 ~= var_3_6.TYPE_WORLD then
				do
					local var_3_5 = arg_3_0.type

					Goods = var_3_6

					local var_3_6

					if var_3_5 == var_3_6.TYPE_NEW_SERVER then
						var_3_6 = arg_3_0
						var_3_6 = arg_3_0.getLimitCount(var_3_6) <= 0 or arg_3_0:getBuyCount() < var_1

						return var_3_6
					else
						local var_3_7 = arg_3_0.type

						Goods = var_3_6

						if var_3_7 == var_3_6.TYPE_CRUISE then
							return arg_3_0:getLimitCount() - arg_3_0:GetOwnedCnt() > 0
						else
							return var_0_1.super.canPurchase(arg_3_0)
						end
					end
				end

				::label_3_0::

				return
			end
		end
	end
end

function var_0_1.isDisCount(arg_4_0)
	if arg_4_0:IsItemDiscountType() then
		return true
	else
		return arg_4_0:getConfig("discount") ~= 0 and var_0_1.InCommodityDiscountTime(arg_4_0.id)
	end

	return
end

function var_0_1.GetDiscountEndTime(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.getConfig(var_5_0, "discount_time")

	unpack = var_5_0

	local var_5_2, var_5_3 = var_5_0(var_5_1)
	local var_5_4 = var_5_3[1]

	unpack = var_1_10005

	local var_5_5, var_5_6, var_5_7 = var_1_10005(var_5_4)

	pg = var_1_10008

	local var_5_8 = var_1_10008.TimeMgr.GetInstance()

	return (var_8.Table2ServerTime(var_5_8, {
		year = var_5_5,
		month = var_5_6,
		day = var_5_7,
		hour = var_5_3[2][1],
		min = var_5_3[2][2],
		sec = var_5_3[2][3]
	}))
end

function var_0_1.IsGroupSale(arg_6_0)
	local var_6_0 = arg_6_0:getConfig("group") > 0
	local var_6_1 = arg_6_0:getConfig("limit_args2")[1]
	local var_6_2 = arg_6_0.type

	Goods = var_4

	return var_6_2 == var_4.TYPE_MILITARY and var_6_0 and var_6_1[1] == "purchase"
end

function var_0_1.IsShowWhenGroupSale(arg_7_0, arg_7_1)
	if arg_7_0:IsGroupSale() then
		local var_7_0 = arg_7_0:getConfig("limit_args2")[1][2]

		if arg_7_1 == var_2[3] and var_4 == arg_7_0:getConfig("group_limit") then
			return true
		end

		return var_7_0 <= arg_7_1 + 1 and arg_7_1 <= var_4
	end

	return true
end

function var_0_1.GetOwnedCnt(arg_8_0)
	local var_8_0 = arg_8_0:getDropInfo()

	return var_1.getOwnedCount(var_8_0)
end

function var_0_1.GetPrice(arg_9_0)
	local var_9_0 = arg_9_0:getConfig("resource_num")
	local var_9_1 = 0
	local var_9_3

	if arg_9_0:isDisCount() then
		if arg_9_0:IsItemDiscountType() then
			SkinCouponActivity = var_4

			local var_9_2 = var_4.GetBestReadySkinCouponAct(arg_9_0.id)

			var_9_1 = (var_9_0 - var_4.GetNewPrice(var_9_2, var_9_0)) * 100 / var_9_0
		else
			var_9_3 = var_9_0 * (100 - arg_9_0:getConfig("discount")) / 100
		end
	end

	return var_9_3, var_9_1, var_9_0
end

function var_0_1.GetName(arg_10_0)
	local var_10_0 = arg_10_0:getDropInfo()

	return var_1.getName(var_10_0)
end

function var_0_1.GetResType(arg_11_0)
	return arg_11_0:getConfig("resource_type")
end

function var_0_1.GetResIcon(arg_12_0)
	if arg_12_0:GetResType() == 4 or var_1 == 14 then
		return "diamond"
	elseif var_1 == 1 then
		return "gold"
	end

	return
end

function var_0_1.GetConsume(arg_13_0)
	Drop = var_1_10001

	local var_13_0 = var_1_10001.New
	local var_13_1 = {}

	DROP_TYPE_RESOURCE = var_1_10003
	var_13_1.type = var_1_10003
	var_13_1.id = arg_13_0:GetResType()
	var_13_1.count = arg_13_0:GetPrice()

	return var_13_0(var_13_1)
end

function var_0_1.IsItemDiscountType(arg_14_0)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.getConfig(var_14_0, "genre")

	ShopArgs = var_14_0

	local var_14_2

	if var_14_1 == var_14_0.SkinShop then
		SkinCouponActivity = var_14_1
		var_14_2 = var_14_1.StaticExistActivityAndCoupon(arg_14_0.id)
	else
		var_14_2 = false
	end

	if false then
		var_14_2 = true
	end

	return var_14_2
end

function var_0_1.CanUseVoucherType(arg_15_0)
	getProxy = var_1_10001
	BagProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)
	local var_15_1 = var_1.GetSkinShopDiscountItemList(var_15_0)

	return arg_15_0:StaticCanUseVoucherType(var_15_1)
end

function var_0_1.ExistExclusiveDiscountItem(arg_16_0)
	getProxy = var_1_10001
	BagProxy = var_1_10002

	local var_16_0 = var_1_10001(var_1_10002)

	return #var_1.GetExclusiveDiscountItem4Shop(var_16_0, arg_16_0.id) > 0
end

function var_0_1.StaticCanUseVoucherType(arg_17_0, arg_17_1)
	if #arg_17_1 <= 0 then
		return false
	end

	ipairs = var_2

	for iter_17_0, iter_17_1 in var_2(arg_17_1) do
		if iter_17_1:CanUseForShop(arg_17_0.id) then
			return true
		end
	end

	return false
end

function var_0_1.GetVoucherIdList(arg_18_0)
	local var_18_0 = {}

	getProxy = var_1_10002
	BagProxy = var_1_10003

	local var_18_1 = var_1_10002(var_1_10003)
	local var_18_2 = var_2.GetSkinShopDiscountItemList(var_18_1)

	pairs = var_18_1

	for iter_18_0, iter_18_1 in var_18_1(var_18_2) do
		if iter_18_1:CanUseForShop(arg_18_0.id) then
			table = var_8

			var_8.insert(var_18_0, iter_18_1.id)
		end
	end

	return var_18_0
end

function var_0_1.getLimitCount(arg_19_0)
	local var_19_0 = arg_19_0
	local var_19_1

	if not arg_19_0.getConfig(var_19_0, "limit_args") then
		var_19_1 = {}
	end

	ipairs = var_19_0

	for iter_19_0, iter_19_1 in var_19_0(var_19_1) do
		if iter_19_1[1] == "time" then
			return iter_19_1[2]
		end
	end

	return 0
end

function var_0_1.GetDiscountItem(arg_20_0)
	if arg_20_0:IsItemDiscountType() then
		SkinCouponActivity = var_1

		return var_1.StaticGetItemConfig(arg_20_0.id)
	end

	return nil
end

function var_0_1.isLevelLimit(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0, var_21_1 = arg_21_0:getLevelLimit()

	if arg_21_2 and var_21_1 then
		return false
	end

	return var_21_0 > 0 and arg_21_1 < var_21_0
end

function var_0_1.getLevelLimit(arg_22_0)
	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.getConfig(var_22_0, "limit_args")

	ipairs = var_22_0

	for iter_22_0, iter_22_1 in var_22_0(var_22_1) do
		type = var_1_10007

		if var_1_10007(iter_22_1) == "table" and iter_22_1[1] == "level" then
			return iter_22_1[2], iter_22_1[3]
		end
	end

	return 0
end

function var_0_1.getSkinId(arg_23_0)
	local var_23_0 = arg_23_0.type

	Goods = var_1_10002

	if var_23_0 == var_1_10002.TYPE_SKIN then
		return arg_23_0:getConfig("effect_args")[1]
	end

	assert = var_23_0

	var_23_0(false)

	return
end

function var_0_1.getDropInfo(arg_24_0)
	switch = var_1_10001

	local var_24_0 = var_1_10001(arg_24_0:getConfig("effect_args"), {
		ship_bag_size = function()
			local var_25_0 = {
				count = 1
			}

			DROP_TYPE_ITEM = var_2_10001
			var_25_0.type = var_2_10001
			Goods = var_2_10001
			var_25_0.id = var_2_10001.SHIP_BAG_SIZE_ITEM

			return var_25_0
		end,
		equip_bag_size = function()
			local var_26_0 = {
				count = 1
			}

			DROP_TYPE_ITEM = var_2_10001
			var_26_0.type = var_2_10001
			Goods = var_2_10001
			var_26_0.id = var_2_10001.EQUIP_BAG_SIZE_ITEM

			return var_26_0
		end,
		commander_bag_size = function()
			local var_27_0 = {
				count = 1
			}

			DROP_TYPE_ITEM = var_2_10001
			var_27_0.type = var_2_10001
			Goods = var_2_10001
			var_27_0.id = var_2_10001.COMMANDER_BAG_SIZE_ITEM

			return var_27_0
		end,
		spweapon_bag_size = function()
			local var_28_0 = {
				count = 1
			}

			DROP_TYPE_ITEM = var_2_10001
			var_28_0.type = var_2_10001
			Goods = var_2_10001
			var_28_0.id = var_2_10001.SPWEAPON_BAG_SIZE_ITEM

			return var_28_0
		end,
		ship_bag_size = function()
			local var_29_0 = {
				count = 1
			}

			DROP_TYPE_ITEM = var_2_10001
			var_29_0.type = var_2_10001
			Goods = var_2_10001
			var_29_0.id = var_2_10001.SHIP_BAG_SIZE_ITEM

			return var_29_0
		end,
		ship_bag_size = function()
			local var_30_0 = {
				count = 1
			}

			DROP_TYPE_ITEM = var_2_10001
			var_30_0.type = var_2_10001
			Goods = var_2_10001
			var_30_0.id = var_2_10001.SHIP_BAG_SIZE_ITEM

			return var_30_0
		end
	}, function()
		local var_31_0 = arg_24_0
		local var_31_1 = var_0.getConfig(var_31_0, "genre")

		ShopArgs = var_31_0

		if var_31_1 == var_31_0.WorldCollection then
			local var_31_2 = {}

			DROP_TYPE_WORLD_ITEM = var_1
			var_31_2.type = var_1

			local var_31_3 = arg_24_0

			var_31_2.id = var_1.getConfig(var_31_3, "effect_args")[1]

			local var_31_4 = arg_24_0

			var_31_2.count = var_1.getConfig(var_31_4, "num")

			return var_31_2
		else
			local var_31_5 = arg_24_0
			local var_31_6 = var_0.getConfig(var_31_5, "genre")

			ShopArgs = var_31_5

			if var_31_6 == var_31_5.CruiseSkin then
				local var_31_7 = {}

				DROP_TYPE_SKIN = var_1
				var_31_7.type = var_1

				local var_31_8 = arg_24_0

				var_31_7.id = var_1.getConfig(var_31_8, "effect_args")[1]

				local var_31_9 = arg_24_0

				var_31_7.count = var_1.getConfig(var_31_9, "num")

				return var_31_7
			else
				local var_31_10 = arg_24_0
				local var_31_11 = var_0.getConfig(var_31_10, "genre")

				ShopArgs = var_31_10

				if var_31_11 == var_31_10.CruiseGearSkin then
					local var_31_12 = {}

					DROP_TYPE_EQUIPMENT_SKIN = var_1
					var_31_12.type = var_1

					local var_31_13 = arg_24_0

					var_31_12.id = var_1.getConfig(var_31_13, "effect_args")[1]

					local var_31_14 = arg_24_0

					var_31_12.count = var_1.getConfig(var_31_14, "num")

					return var_31_12
				else
					local var_31_15 = {}
					local var_31_16 = arg_24_0

					var_31_15.type = var_1.getConfig(var_31_16, "type")

					local var_31_17 = arg_24_0

					var_31_15.id = var_1.getConfig(var_31_17, "effect_args")[1]

					local var_31_18 = arg_24_0

					var_31_15.count = var_1.getConfig(var_31_18, "num")

					return var_31_15
				end
			end
		end

		return
	end)

	Drop = var_2

	return var_2.New(var_24_0)
end

function var_0_1.GetDropList(arg_32_0)
	local var_32_0 = {}

	Item = var_1_10002

	local var_32_1 = var_1_10002.getConfigData(arg_32_0:getConfig("effect_args")[1]).display_icon

	type = var_3

	if var_3(var_32_1) == "table" then
		ipairs = var_3

		for iter_32_0, iter_32_1 in var_3(var_32_1) do
			table = var_1_10008

			var_1_10008.insert(var_32_0, {
				type = iter_32_1[1],
				id = iter_32_1[2],
				count = iter_32_1[3]
			})
		end
	end

	return var_32_0
end

function var_0_1.IsGroupLimit(arg_33_0)
	if arg_33_0:getConfig("group") <= 0 then
		return false
	end

	if arg_33_0:getConfig("group_limit") > 0 then
		local var_33_0

		if not arg_33_0.groupCount then
			var_33_0 = 0
		end

		local var_33_1

		if not (var_2 <= var_33_0) then
			var_33_1 = false
		else
			var_33_1 = true
		end

		return var_33_1
	end
end

function var_0_1.GetLimitDesc(arg_34_0)
	local var_34_0 = arg_34_0:getLimitCount()
	local var_34_1 = arg_34_0:getBuyCount()

	if 0 < var_34_0 then
		i18n = var_3

		return var_3("charge_limit_all", var_34_0 - var_34_1, var_34_0)
	end

	if arg_34_0:getConfig("group_limit") > 0 then
		local var_34_2 = arg_34_0
		local var_34_3

		if not arg_34_0.getConfig(var_34_2, "group_type") then
			var_34_3 = 0
		end

		if var_34_3 == 1 then
			i18n = var_34_2

			return var_34_2("charge_limit_daily", var_3 - arg_34_0.groupCount, var_3)
		elseif var_34_3 == 2 then
			i18n = var_34_2

			return var_34_2("charge_limit_weekly", var_3 - arg_34_0.groupCount, var_3)
		elseif var_34_3 == 3 then
			i18n = var_34_2

			return var_34_2("charge_limit_monthly", var_3 - arg_34_0.groupCount, var_3)
		end
	end

	return ""
end

function var_0_1.GetGiftList(arg_35_0)
	local var_35_0 = arg_35_0
	local var_35_1 = arg_35_0.getConfig(var_35_0, "genre")

	ShopArgs = var_35_0

	if var_35_1 == var_35_0.SkinShop then
		local var_35_2 = arg_35_0
		local var_35_3 = arg_35_0.getSkinId(var_35_2)

		ShipSkin = var_35_2

		local var_35_4 = var_35_2.New({
			id = var_35_3
		})

		return var_2.GetRewardList(var_35_4)
	else
		return var_0_1.super.GetGiftList(arg_35_0)
	end

	return
end

function var_0_1.GetPackageTag(arg_36_0)
	local var_36_0 = arg_36_0
	local var_36_1 = arg_36_0.getConfig(var_36_0, "genre")

	ShopArgs = var_36_0

	if var_36_1 ~= var_36_0.GiftPackage or arg_36_0:getConfig("package_tag_open") == 0 then
		return ""
	else
		return arg_36_0:getConfig("package_tag")
	end

	return
end

function var_0_1.isTip(arg_37_0)
	if arg_37_0:isGiftPackage() or arg_37_0:isActGiftPackage() then
		local var_37_0 = arg_37_0:getConfig("akashi_pick") > 0 and "payshop_pack_red_dot" or "gemshop_pack_red_dot"

		unpack = var_3
		getGameset = var_1_10004

		local var_37_1, var_37_2 = var_3(var_1_10004(var_37_0))

		PlayerPrefs = var_5

		if var_5.GetInt(var_37_0, 0) ~= var_37_1 then
			table = var_5

			if var_5.contains(var_37_2[1], arg_37_0.id) then
				return true
			end
		end

		return arg_37_0:isFree()
	end

	return
end

return var_0_1
