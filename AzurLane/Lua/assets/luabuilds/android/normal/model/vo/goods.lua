class = var_0_10000

local var_0_0 = "Goods"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

var_0_1.TYPE_SHOPSTREET = 1
var_0_1.TYPE_MILITARY = 2
var_0_1.TYPE_CHARGE = 3
var_0_1.TYPE_GIFT_PACKAGE = 4
var_0_1.TYPE_GIFT_PACKAGE_ACT = 5
var_0_1.TYPE_SKIN = 6
var_0_1.TYPE_ACTIVITY = 7
var_0_1.TYPE_ACTIVITY_EXTRA = 8
var_0_1.TYPE_GUILD = 9
var_0_1.TYPE_SHAM_BATTLE = 10
var_0_1.TYPE_ESCORT = 11
var_0_1.TYPE_FRAGMENT = 12
var_0_1.TYPE_WORLD = 13
var_0_1.TYPE_FRAGMENT_NORMAL = 14
var_0_1.TYPE_NEW_SERVER = 15
var_0_1.TYPE_MINI_GAME = 16
var_0_1.TYPE_QUOTA = 17
var_0_1.TYPE_WORLD_NSHOP = 18
var_0_1.TYPE_CRUISE = 19
var_0_1.TYPE_ACTIVITY_SELECTABLE = 20
var_0_1.GEM = 0
var_0_1.GIFT_BOX = 1
var_0_1.MONTH_CARD = 2
var_0_1.ITEM_BOX = 3
var_0_1.PASS_ITEM = 4
var_0_1.EQUIP_BAG_SIZE_ITEM = 59100
var_0_1.SHIP_BAG_SIZE_ITEM = 59101
var_0_1.COMMANDER_BAG_SIZE_ITEM = 59114
var_0_1.SPWEAPON_BAG_SIZE_ITEM = 59360
var_0_1.CRUISE_QUICK_TASK_TICKET_ID = 61017
var_0_1.SHOW_TYPE_TECH = "tech"
var_0_1.SHOW_TYPE_BATTLE_UI = "uigift"
var_0_1.CUR_PACKET_ID = 27

function var_0_1.Ctor(arg_1_0)
	assert = var_1_10001

	var_1_10001(false, "does not call this function, use Create instead")

	return
end

local var_0_2 = {
	[var_0_1.TYPE_CHARGE] = function(arg_2_0, arg_2_1)
		ChargeCommodity = var_1_10002

		return var_1_10002.New(arg_2_0, arg_2_1)
	end,
	[var_0_1.TYPE_GIFT_PACKAGE_ACT] = function(arg_3_0, arg_3_1)
		GiftActCommodity = var_1_10002

		return var_1_10002.New(arg_3_0, arg_3_1)
	end,
	[var_0_1.TYPE_ACTIVITY] = function(arg_4_0, arg_4_1)
		ActivityCommodity = var_1_10002

		return var_1_10002.New(arg_4_0, arg_4_1)
	end,
	[var_0_1.TYPE_SHAM_BATTLE] = function(arg_5_0, arg_5_1)
		ActivityCommodity = var_1_10002

		return var_1_10002.New(arg_5_0, arg_5_1)
	end,
	[var_0_1.TYPE_FRAGMENT] = function(arg_6_0, arg_6_1)
		ActivityCommodity = var_1_10002

		return var_1_10002.New(arg_6_0, arg_6_1)
	end,
	[var_0_1.TYPE_FRAGMENT_NORMAL] = function(arg_7_0, arg_7_1)
		ActivityCommodity = var_1_10002

		return var_1_10002.New(arg_7_0, arg_7_1)
	end,
	[var_0_1.TYPE_ESCORT] = function(arg_8_0, arg_8_1)
		ActivityCommodity = var_1_10002

		return var_1_10002.New(arg_8_0, arg_8_1)
	end,
	[var_0_1.TYPE_ACTIVITY_EXTRA] = function(arg_9_0, arg_9_1)
		ActivityExtraCommodity = var_1_10002

		return var_1_10002.New(arg_9_0, arg_9_1)
	end,
	[var_0_1.TYPE_MINI_GAME] = function(arg_10_0, arg_10_1)
		MiniGameGoods = var_1_10002

		return var_1_10002.New(arg_10_0, arg_10_1)
	end,
	[var_0_1.TYPE_QUOTA] = function(arg_11_0, arg_11_1)
		QuotaCommodity = var_1_10002

		return var_1_10002.New(arg_11_0, arg_11_1)
	end,
	[var_0_1.TYPE_ESCORT] = function(arg_12_0, arg_12_1)
		ActivityCommodity = var_1_10002

		return var_1_10002.New(arg_12_0, arg_12_1)
	end,
	[var_0_1.TYPE_WORLD_NSHOP] = function(arg_13_0, arg_13_1)
		WorldNShopCommodity = var_1_10002

		return var_1_10002.New(arg_13_0, arg_13_1)
	end,
	[var_0_1.TYPE_ACTIVITY_SELECTABLE] = function(arg_14_0, arg_14_1)
		ActivitySelectableCommodity = var_1_10002

		return var_1_10002.New(arg_14_0, arg_14_1)
	end
}

function var_0_1.Create(arg_15_0, arg_15_1)
	switch = var_1_10002

	return var_1_10002(arg_15_1, var_0_2, function(arg_16_0, arg_16_1)
		CommonCommodity = var_2_10002

		return var_2_10002.New(arg_16_0, arg_16_1)
	end, arg_15_0, arg_15_1)
end

function var_0_1.ExistFurniture(arg_17_0)
	pg = var_1_10001

	return var_1_10001.shop_furniture_relation[arg_17_0] ~= nil
end

function var_0_1.Id2FurnitureId(arg_18_0)
	pg = var_1_10001

	return var_1_10001.shop_furniture_relation[arg_18_0].fur_id
end

function var_0_1.FurnitureId2Id(arg_19_0)
	pg = var_1_10001

	return var_1_10001.shop_furniture_relation.get_id_list_by_fur_id[arg_19_0] and var_1[1]
end

function var_0_1.GetFurnitureConfig(arg_20_0)
	pg = var_1_10001

	return var_1_10001.shop_furniture_relation[arg_20_0]
end

function var_0_1.Id2ShipSkinId(arg_21_0)
	pg = var_1_10001

	return var_1_10001.shop_template[arg_21_0].effect_args[1]
end

return var_0_1
