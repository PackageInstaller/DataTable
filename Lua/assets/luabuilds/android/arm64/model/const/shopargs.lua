local var_0_0 = class("ShopArgs")

var_0_0.EffecetEquipBagSize = "equip_bag_size"
var_0_0.EffecetShipBagSize = "ship_bag_size"
var_0_0.EffectDromExpPos = "dorm_exp_pos"
var_0_0.EffectDromFixPos = "dorm_fix_pos"
var_0_0.EffectDromFoodMax = "dorm_food_max"
var_0_0.EffectShopStreetFlash = "shop_street_flash"
var_0_0.EffectShopStreetLevel = "shop_street_level"
var_0_0.EffectOilFieldLevel = "oilfield_level"
var_0_0.EffectTradingPortLevel = "tradingport_level"
var_0_0.EffectClassLevel = "class_room_level"
var_0_0.EffectGuildFlash = "guild_store_flash"
var_0_0.EffectDormFloor = "dorm_floor"
var_0_0.EffectSkillPos = "skill_room_pos"
var_0_0.EffectCommanderBagSize = "commander_bag_size"
var_0_0.EffectSpWeaponBagSize = "spweapon_bag_size"
var_0_0.ShoppingStreetUpgrade = "shop_street_upgrade"
var_0_0.BackyardFoodExtend = "backyard_food_extend"
var_0_0.BuyOil = "buy_oil"
var_0_0.ShoppingStreetLimit = "shopping_street"
var_0_0.ArenaShopLimit = "arena_shop"
var_0_0.GiftPackage = "gift_package"
var_0_0.GiftActPackage = "gift_package_act"
var_0_0.GenShop = "gem_shop"
var_0_0.SkinShop = "skin_shop"
var_0_0.ActivityShop = "activity_shop"
var_0_0.guildShop = "guild_store"
var_0_0.guildShopFlash = "guild_shop_flash"
var_0_0.skillRoomUpgrade = "skill_room_upgrade"
var_0_0.SkinShopTimeLimit = "skin_shop_timelimit"
var_0_0.WorldShop = "world"
var_0_0.WorldCollection = "world_collection_task"
var_0_0.NewServerShop = "new_server_shop"
var_0_0.CruiseSkin = "cruise_skin"
var_0_0.CruiseGearSkin = "cruise_gearskin"
var_0_0.BlackFridayShop = "black_friday_shop"
var_0_0.ShopStreet = 1
var_0_0.MilitaryShop = 2
var_0_0.ShopActivity = 3
var_0_0.ShopGUILD = 4
var_0_0.ShopShamBattle = 5
var_0_0.ShopEscort = 6
var_0_0.ShopFragment = 7
var_0_0.ShopMedal = 8
var_0_0.ShopMiniGame = 9
var_0_0.ShopQuota = 10
var_0_0.ShopCruise = 11
var_0_0.DORM_FLOOR_ID = 19
var_0_0.LIMIT_ARGS_META_SHIP_EXISTENCE = 1
var_0_0.LIMIT_ARGS_SALE_START_TIME = 2
var_0_0.LIMIT_ARGS_TRAN_ITEM_WHEN_FULL = 3
var_0_0.LIMIT_ARGS_UNIQUE_SHIP = "uniqueship"

function var_0_0.getOilByLevel(arg_1_0)
	return 500 + arg_1_0 * 3
end

return var_0_0
