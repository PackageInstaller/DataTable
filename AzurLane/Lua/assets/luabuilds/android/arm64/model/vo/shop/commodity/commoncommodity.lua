local var_0_0 = class("CommonCommodity", import(".BaseCommodity"))

function var_0_0.InCommodityDiscountTime(arg_1_0)
	if pg.shop_template[arg_1_0].discount_time == "always" then
		return true
	end

	if type(pg.shop_template[arg_1_0].discount_time) == "table" then
		return table.getCount(pg.shop_template[arg_1_0].discount_time) == 0 or pg.TimeMgr.GetInstance():inTime(pg.shop_template[arg_1_0].discount_time)
	end

	return false
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.shop_template
end

function var_0_0.canPurchase(arg_3_0)
	if arg_3_0.type == Goods.TYPE_MILITARY then
		return arg_3_0:getBuyCount() == 0
	elseif arg_3_0.type == Goods.TYPE_GIFT_PACKAGE or arg_3_0.type == Goods.TYPE_SKIN or arg_3_0.type == Goods.TYPE_WORLD or arg_3_0.type == Goods.TYPE_NEW_SERVER then
		local var_3_0 = arg_3_0:getLimitCount()

		return var_3_0 <= 0 or var_3_0 > arg_3_0:getBuyCount()
	elseif arg_3_0.type == Goods.TYPE_CRUISE then
		return arg_3_0:getLimitCount() - arg_3_0:GetOwnedCnt() > 0
	else
		return var_0_0.super.canPurchase(arg_3_0)
	end

	return
end

function var_0_0.isDisCount(arg_4_0)
	if arg_4_0:IsItemDiscountType() then
		return true
	else
		return arg_4_0:getConfig("discount") ~= 0 and var_0_0.InCommodityDiscountTime(arg_4_0.id)
	end

	return
end

function var_0_0.GetDiscountEndTime(arg_5_0)
	local var_5_0, var_5_1 = unpack((arg_5_0:getConfig("discount_time")))
	local var_5_2, var_5_3, var_5_4 = unpack(var_5_1[1])

	return (pg.TimeMgr.GetInstance():Table2ServerTime({
		year = var_5_2,
		month = var_5_3,
		day = var_5_4,
		hour = var_5_1[2][1],
		min = var_5_1[2][2],
		sec = var_5_1[2][3]
	}))
end

function var_0_0.IsGroupSale(arg_6_0)
	local var_6_0 = arg_6_0:getConfig("group") > 0
	local var_6_1 = arg_6_0:getConfig("limit_args2")[1]

	return arg_6_0.type == Goods.TYPE_MILITARY and var_6_0 and var_6_1[1] == "purchase"
end

function var_0_0.IsShowWhenGroupSale(arg_7_0, arg_7_1)
	if arg_7_0:IsGroupSale() then
		local var_7_0 = arg_7_0:getConfig("limit_args2")[1]
		local var_7_1 = var_7_0[2]
		local var_7_2 = var_7_0[3]

		if arg_7_1 == var_7_0[3] and var_7_2 == arg_7_0:getConfig("group_limit") then
			return true
		end

		arg_7_1 = arg_7_1 + 1

		return var_7_1 <= arg_7_1 and arg_7_1 <= var_7_2
	end

	return true
end

function var_0_0.GetOwnedCnt(arg_8_0)
	return arg_8_0:getDropInfo():getOwnedCount()
end

function var_0_0.GetPrice(arg_9_0)
	local var_9_0 = arg_9_0:getConfig("resource_num")
	local var_9_1 = 0

	if arg_9_0:isDisCount() then
		if arg_9_0:IsItemDiscountType() then
			var_9_0 = SkinCouponActivity.GetBestReadySkinCouponAct(arg_9_0.id):GetNewPrice(var_9_0)
			var_9_1 = (var_9_0 - var_9_0) * 100 / var_9_0
		else
			var_9_1 = arg_9_0:getConfig("discount")
			var_9_0 = var_9_0 * (100 - var_9_1) / 100
		end
	end

	return var_9_0, var_9_1, var_9_0
end

function var_0_0.GetName(arg_10_0)
	return arg_10_0:getDropInfo():getName()
end

function var_0_0.GetResType(arg_11_0)
	return arg_11_0:getConfig("resource_type")
end

function var_0_0.GetResIcon(arg_12_0)
	local var_12_0 = arg_12_0:GetResType()

	if var_12_0 == 4 or var_12_0 == 14 then
		return "diamond"
	elseif var_12_0 == 1 then
		return "gold"
	end

	return
end

function var_0_0.GetConsume(arg_13_0)
	return Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = arg_13_0:GetResType(),
		count = arg_13_0:GetPrice()
	})
end

function var_0_0.IsItemDiscountType(arg_14_0)
	return arg_14_0:getConfig("genre") == ShopArgs.SkinShop and SkinCouponActivity.StaticExistActivityAndCoupon(arg_14_0.id)
end

function var_0_0.CanUseVoucherType(arg_15_0)
	return arg_15_0:StaticCanUseVoucherType((getProxy(BagProxy):GetSkinShopDiscountItemList()))
end

function var_0_0.ExistExclusiveDiscountItem(arg_16_0)
	local var_16_0 = #getProxy(BagProxy):GetExclusiveDiscountItem4Shop(arg_16_0.id)

	return var_16_0 > 0
end

function var_0_0.StaticCanUseVoucherType(arg_17_0, arg_17_1)
	if #arg_17_1 <= 0 then
		return false
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		if iter_17_1:CanUseForShop(arg_17_0.id) then
			return true
		end
	end

	return false
end

function var_0_0.GetVoucherIdList(arg_18_0)
	for iter_18_0, iter_18_1 in pairs((getProxy(BagProxy):GetSkinShopDiscountItemList())) do
		if iter_18_1:CanUseForShop(arg_18_0.id) then
			table.insert({}, iter_18_1.id)
		end
	end

	return {}
end

function var_0_0.getLimitCount(arg_19_0)
	local var_19_0 = arg_19_0:getConfig("limit_args") or {}

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if iter_19_1[1] == "time" then
			return iter_19_1[2]
		end
	end

	return 0
end

function var_0_0.GetDiscountItem(arg_20_0)
	if arg_20_0:IsItemDiscountType() then
		return SkinCouponActivity.StaticGetItemConfig(arg_20_0.id)
	end

	return nil
end

function var_0_0.isLevelLimit(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0, var_21_1 = arg_21_0:getLevelLimit()

	if arg_21_2 and var_21_1 then
		return false
	end

	return var_21_0 > 0 and arg_21_1 < var_21_0
end

function var_0_0.getLevelLimit(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs((arg_22_0:getConfig("limit_args"))) do
		if type(iter_22_1) == "table" and iter_22_1[1] == "level" then
			return iter_22_1[2], iter_22_1[3]
		end
	end

	return 0
end

function var_0_0.getSkinId(arg_23_0)
	if arg_23_0.type == Goods.TYPE_SKIN then
		return arg_23_0:getConfig("effect_args")[1]
	end

	assert(false)

	return
end

function var_0_0.getDropInfo(arg_24_0)
	return Drop.New((switch(arg_24_0:getConfig("effect_args"), {
		ship_bag_size = function()
			return {
				count = 1,
				type = DROP_TYPE_ITEM,
				id = Goods.SHIP_BAG_SIZE_ITEM
			}
		end,
		equip_bag_size = function()
			return {
				count = 1,
				type = DROP_TYPE_ITEM,
				id = Goods.EQUIP_BAG_SIZE_ITEM
			}
		end,
		commander_bag_size = function()
			return {
				count = 1,
				type = DROP_TYPE_ITEM,
				id = Goods.COMMANDER_BAG_SIZE_ITEM
			}
		end,
		spweapon_bag_size = function()
			return {
				count = 1,
				type = DROP_TYPE_ITEM,
				id = Goods.SPWEAPON_BAG_SIZE_ITEM
			}
		end,
		ship_bag_size = function()
			return {
				count = 1,
				type = DROP_TYPE_ITEM,
				id = Goods.SHIP_BAG_SIZE_ITEM
			}
		end,
		ship_bag_size = function()
			return {
				count = 1,
				type = DROP_TYPE_ITEM,
				id = Goods.SHIP_BAG_SIZE_ITEM
			}
		end
	}, function()
		if arg_24_0:getConfig("genre") == ShopArgs.WorldCollection then
			return {
				type = DROP_TYPE_WORLD_ITEM,
				id = arg_24_0:getConfig("effect_args")[1],
				count = arg_24_0:getConfig("num")
			}
		elseif arg_24_0:getConfig("genre") == ShopArgs.CruiseSkin then
			return {
				type = DROP_TYPE_SKIN,
				id = arg_24_0:getConfig("effect_args")[1],
				count = arg_24_0:getConfig("num")
			}
		elseif arg_24_0:getConfig("genre") == ShopArgs.CruiseGearSkin then
			return {
				type = DROP_TYPE_EQUIPMENT_SKIN,
				id = arg_24_0:getConfig("effect_args")[1],
				count = arg_24_0:getConfig("num")
			}
		else
			return {
				type = arg_24_0:getConfig("type"),
				id = arg_24_0:getConfig("effect_args")[1],
				count = arg_24_0:getConfig("num")
			}
		end

		return
	end)))
end

function var_0_0.GetDropList(arg_32_0)
	local var_32_0 = Item.getConfigData(arg_32_0:getConfig("effect_args")[1]).display_icon

	if type(var_32_0) == "table" then
		for iter_32_0, iter_32_1 in ipairs(var_32_0) do
			table.insert({}, {
				type = iter_32_1[1],
				id = iter_32_1[2],
				count = iter_32_1[3]
			})
		end
	end

	return {}
end

function var_0_0.IsGroupLimit(arg_33_0)
	if arg_33_0:getConfig("group") <= 0 then
		return false
	end

	local var_33_0 = arg_33_0:getConfig("group_limit")

	if var_33_0 > 0 then
		local var_33_1 = arg_33_0.groupCount or 0

		return var_33_0 <= var_33_1
	end
end

function var_0_0.GetLimitDesc(arg_34_0)
	local var_34_0 = arg_34_0:getLimitCount()

	if var_34_0 > 0 then
		return i18n("charge_limit_all", var_34_0 - arg_34_0:getBuyCount(), var_34_0)
	end

	local var_34_1 = arg_34_0:getConfig("group_limit")

	if var_34_1 > 0 then
		local var_34_2 = arg_34_0:getConfig("group_type") or 0

		if var_34_2 == 1 then
			return i18n("charge_limit_daily", var_34_1 - arg_34_0.groupCount, var_34_1)
		elseif var_34_2 == 2 then
			return i18n("charge_limit_weekly", var_34_1 - arg_34_0.groupCount, var_34_1)
		elseif var_34_2 == 3 then
			return i18n("charge_limit_monthly", var_34_1 - arg_34_0.groupCount, var_34_1)
		end
	end

	return ""
end

function var_0_0.GetGiftList(arg_35_0)
	if arg_35_0:getConfig("genre") == ShopArgs.SkinShop then
		return ShipSkin.New({
			id = arg_35_0:getSkinId()
		}):GetRewardList()
	else
		return var_0_0.super.GetGiftList(arg_35_0)
	end

	return
end

function var_0_0.GetPackageTag(arg_36_0)
	if arg_36_0:getConfig("genre") ~= ShopArgs.GiftPackage or arg_36_0:getConfig("package_tag_open") == 0 then
		return ""
	else
		return arg_36_0:getConfig("package_tag")
	end

	return
end

function var_0_0.isTip(arg_37_0)
	if arg_37_0:isGiftPackage() or arg_37_0:isActGiftPackage() then
		local var_37_0 = arg_37_0:getConfig("akashi_pick") > 0 and "payshop_pack_red_dot" or "gemshop_pack_red_dot"
		local var_37_1, var_37_2 = unpack(getGameset(var_37_0))

		if PlayerPrefs.GetInt(var_37_0, 0) ~= var_37_1 and table.contains(var_37_2[1], arg_37_0.id) then
			return true
		end

		return arg_37_0:isFree()
	end

	return
end

return var_0_0
