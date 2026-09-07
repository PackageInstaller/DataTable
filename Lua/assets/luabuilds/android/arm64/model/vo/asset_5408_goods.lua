local Goods = class("Goods", import(".BaseVO"))

Goods.TYPE_SHOPSTREET = 1
Goods.TYPE_MILITARY = 2
Goods.TYPE_CHARGE = 3
Goods.TYPE_GIFT_PACKAGE = 4
Goods.TYPE_GIFT_PACKAGE_ACT = 5
Goods.TYPE_SKIN = 6
Goods.TYPE_ACTIVITY = 7
Goods.TYPE_ACTIVITY_EXTRA = 8
Goods.TYPE_GUILD = 9
Goods.TYPE_SHAM_BATTLE = 10
Goods.TYPE_ESCORT = 11
Goods.TYPE_FRAGMENT = 12
Goods.TYPE_WORLD = 13
Goods.TYPE_FRAGMENT_NORMAL = 14
Goods.TYPE_NEW_SERVER = 15
Goods.TYPE_MINI_GAME = 16
Goods.TYPE_QUOTA = 17
Goods.TYPE_WORLD_NSHOP = 18
Goods.TYPE_CRUISE = 19
Goods.TYPE_ACTIVITY_SELECTABLE = 20
Goods.GEM = 0
Goods.GIFT_BOX = 1
Goods.MONTH_CARD = 2
Goods.ITEM_BOX = 3
Goods.PASS_ITEM = 4
Goods.EQUIP_BAG_SIZE_ITEM = 59100
Goods.SHIP_BAG_SIZE_ITEM = 59101
Goods.COMMANDER_BAG_SIZE_ITEM = 59114
Goods.SPWEAPON_BAG_SIZE_ITEM = 59360
Goods.CRUISE_QUICK_TASK_TICKET_ID = 61017
Goods.SHOW_TYPE_TECH = "tech"
Goods.SHOW_TYPE_BATTLE_UI = "uigift"
Goods.CUR_PACKET_ID = 27

function Goods:Ctor()
	assert(false, "does not call this function, use Create instead")

	return
end

local var_0_1 = {
	[Goods.TYPE_CHARGE] = function(arg_2_0, arg_2_1)
		return ChargeCommodity.New(arg_2_0, arg_2_1)
	end,
	[Goods.TYPE_GIFT_PACKAGE_ACT] = function(arg_3_0, arg_3_1)
		return GiftActCommodity.New(arg_3_0, arg_3_1)
	end,
	[Goods.TYPE_ACTIVITY] = function(arg_4_0, arg_4_1)
		return ActivityCommodity.New(arg_4_0, arg_4_1)
	end,
	[Goods.TYPE_SHAM_BATTLE] = function(arg_5_0, arg_5_1)
		return ActivityCommodity.New(arg_5_0, arg_5_1)
	end,
	[Goods.TYPE_FRAGMENT] = function(arg_6_0, arg_6_1)
		return ActivityCommodity.New(arg_6_0, arg_6_1)
	end,
	[Goods.TYPE_FRAGMENT_NORMAL] = function(arg_7_0, arg_7_1)
		return ActivityCommodity.New(arg_7_0, arg_7_1)
	end,
	[Goods.TYPE_ESCORT] = function(arg_8_0, arg_8_1)
		return ActivityCommodity.New(arg_8_0, arg_8_1)
	end,
	[Goods.TYPE_ACTIVITY_EXTRA] = function(arg_9_0, arg_9_1)
		return ActivityExtraCommodity.New(arg_9_0, arg_9_1)
	end,
	[Goods.TYPE_MINI_GAME] = function(arg_10_0, arg_10_1)
		return MiniGameGoods.New(arg_10_0, arg_10_1)
	end,
	[Goods.TYPE_QUOTA] = function(arg_11_0, arg_11_1)
		return QuotaCommodity.New(arg_11_0, arg_11_1)
	end,
	[Goods.TYPE_ESCORT] = function(arg_12_0, arg_12_1)
		return ActivityCommodity.New(arg_12_0, arg_12_1)
	end,
	[Goods.TYPE_WORLD_NSHOP] = function(arg_13_0, arg_13_1)
		return WorldNShopCommodity.New(arg_13_0, arg_13_1)
	end,
	[Goods.TYPE_ACTIVITY_SELECTABLE] = function(arg_14_0, arg_14_1)
		return ActivitySelectableCommodity.New(arg_14_0, arg_14_1)
	end
}

function Goods:Create(arg_15_1)
	return switch(arg_15_1, var_0_1, function(arg_16_0, arg_16_1)
		return CommonCommodity.New(arg_16_0, arg_16_1)
	end, self, arg_15_1)
end

function Goods:ExistFurniture()
	return pg.shop_furniture_relation[self] ~= nil
end

function Goods:Id2FurnitureId()
	return pg.shop_furniture_relation[self].fur_id
end

function Goods:FurnitureId2Id()
	return pg.shop_furniture_relation.get_id_list_by_fur_id[self] and pg.shop_furniture_relation.get_id_list_by_fur_id[self][1]
end

function Goods:GetFurnitureConfig()
	return pg.shop_furniture_relation[self]
end

function Goods:Id2ShipSkinId()
	return pg.shop_template[self].effect_args[1]
end

return Goods
