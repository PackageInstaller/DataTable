local ShopArgs = class("ShopArgs")

ShopArgs.EffecetEquipBagSize = "equip_bag_size"
ShopArgs.EffecetShipBagSize = "ship_bag_size"
ShopArgs.EffectDromExpPos = "dorm_exp_pos"
ShopArgs.EffectDromFixPos = "dorm_fix_pos"
ShopArgs.EffectDromFoodMax = "dorm_food_max"
ShopArgs.EffectShopStreetFlash = "shop_street_flash"
ShopArgs.EffectShopStreetLevel = "shop_street_level"
ShopArgs.EffectOilFieldLevel = "oilfield_level"
ShopArgs.EffectTradingPortLevel = "tradingport_level"
ShopArgs.EffectClassLevel = "class_room_level"
ShopArgs.EffectGuildFlash = "guild_store_flash"
ShopArgs.EffectDormFloor = "dorm_floor"
ShopArgs.EffectSkillPos = "skill_room_pos"
ShopArgs.EffectCommanderBagSize = "commander_bag_size"
ShopArgs.EffectSpWeaponBagSize = "spweapon_bag_size"
ShopArgs.ShoppingStreetUpgrade = "shop_street_upgrade"
ShopArgs.BackyardFoodExtend = "backyard_food_extend"
ShopArgs.BuyOil = "buy_oil"
ShopArgs.ShoppingStreetLimit = "shopping_street"
ShopArgs.ArenaShopLimit = "arena_shop"
ShopArgs.GiftPackage = "gift_package"
ShopArgs.GiftActPackage = "gift_package_act"
ShopArgs.GenShop = "gem_shop"
ShopArgs.SkinShop = "skin_shop"
ShopArgs.ActivityShop = "activity_shop"
ShopArgs.guildShop = "guild_store"
ShopArgs.guildShopFlash = "guild_shop_flash"
ShopArgs.skillRoomUpgrade = "skill_room_upgrade"
ShopArgs.SkinShopTimeLimit = "skin_shop_timelimit"
ShopArgs.WorldShop = "world"
ShopArgs.WorldCollection = "world_collection_task"
ShopArgs.NewServerShop = "new_server_shop"
ShopArgs.CruiseSkin = "cruise_skin"
ShopArgs.CruiseGearSkin = "cruise_gearskin"
ShopArgs.BlackFridayShop = "black_friday_shop"
ShopArgs.ShopStreet = 1
ShopArgs.MilitaryShop = 2
ShopArgs.ShopActivity = 3
ShopArgs.ShopGUILD = 4
ShopArgs.ShopShamBattle = 5
ShopArgs.ShopEscort = 6
ShopArgs.ShopFragment = 7
ShopArgs.ShopMedal = 8
ShopArgs.ShopMiniGame = 9
ShopArgs.ShopQuota = 10
ShopArgs.ShopCruise = 11
ShopArgs.DORM_FLOOR_ID = 19
ShopArgs.LIMIT_ARGS_META_SHIP_EXISTENCE = 1
ShopArgs.LIMIT_ARGS_SALE_START_TIME = 2
ShopArgs.LIMIT_ARGS_TRAN_ITEM_WHEN_FULL = 3
ShopArgs.LIMIT_ARGS_UNIQUE_SHIP = "uniqueship"

function ShopArgs:getOilByLevel()
	return 500 + self * 3
end

return ShopArgs
