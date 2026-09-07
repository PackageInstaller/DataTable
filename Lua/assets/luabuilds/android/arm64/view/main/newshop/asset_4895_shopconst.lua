local var_0_0 = {}

ChargeScene.TYPE_DIAMOND = 1
ChargeScene.TYPE_GIFT = 2
ChargeScene.TYPE_ITEM = 3
ChargeScene.TYPE_PICK = 4
var_0_0.CATEGORY_ACTIVITY = 1
var_0_0.CATEGORY_MONTH = 2
var_0_0.CATEGORY_SUPPLY = 3
var_0_0.SHOP_TYPE = {
	SUPPLY = "supply",
	SKIN = "skin",
	CHARGE = "charge"
}
var_0_0.SHOP_ID = {
	GIFT = 2,
	ACTIVITY = 7,
	DIAMOND = 1,
	ITEM = 3,
	SUPPLY = 6,
	PICK = 4,
	MONTH = 5
}
var_0_0.SHOP_LIST = {
	[var_0_0.SHOP_TYPE.CHARGE] = {
		[ChargeScene.TYPE_DIAMOND] = 1,
		[ChargeScene.TYPE_GIFT] = 2,
		[ChargeScene.TYPE_ITEM] = 3,
		[ChargeScene.TYPE_PICK] = 4
	},
	[var_0_0.SHOP_TYPE.SUPPLY] = {
		[var_0_0.CATEGORY_MONTH] = 5,
		[var_0_0.CATEGORY_SUPPLY] = 6,
		[var_0_0.CATEGORY_ACTIVITY] = 7
	}
}
var_0_0.TYPE_ACTIVITY = 1
var_0_0.TYPE_SHOP_STREET = 2
var_0_0.TYPE_MILITARY_SHOP = 3
var_0_0.TYPE_QUOTA = 4
var_0_0.TYPE_SHAM_SHOP = 5
var_0_0.TYPE_FRAGMENT = 6
var_0_0.TYPE_GUILD = 7
var_0_0.TYPE_MEDAL = 8
var_0_0.TYPE_META = 9
var_0_0.TYPE_MINI_GAME = 10
var_0_0.SUPPLY_SHOP_LIST = {
	[var_0_0.CATEGORY_MONTH] = {
		var_0_0.TYPE_QUOTA,
		var_0_0.TYPE_SHAM_SHOP,
		var_0_0.TYPE_MEDAL,
		var_0_0.TYPE_FRAGMENT
	},
	[var_0_0.CATEGORY_SUPPLY] = {
		var_0_0.TYPE_SHOP_STREET,
		var_0_0.TYPE_MILITARY_SHOP,
		var_0_0.TYPE_GUILD,
		var_0_0.TYPE_META,
		var_0_0.TYPE_MINI_GAME
	},
	[var_0_0.CATEGORY_ACTIVITY] = {
		var_0_0.TYPE_ACTIVITY
	}
}
var_0_0.SHOP_NAME_LIST = {
	activity = {
		var_0_0.CATEGORY_ACTIVITY
	},
	shopstreet = {
		var_0_0.CATEGORY_SUPPLY,
		var_0_0.TYPE_SHOP_STREET
	},
	supplies = {
		var_0_0.CATEGORY_SUPPLY,
		var_0_0.TYPE_MILITARY_SHOP
	},
	guild = {
		var_0_0.CATEGORY_SUPPLY,
		var_0_0.TYPE_GUILD
	},
	meta = {
		var_0_0.CATEGORY_SUPPLY,
		var_0_0.TYPE_META
	},
	minigame = {
		var_0_0.CATEGORY_SUPPLY,
		var_0_0.TYPE_MINI_GAME
	},
	quota = {
		var_0_0.CATEGORY_MONTH,
		var_0_0.TYPE_QUOTA
	},
	sham = {
		var_0_0.CATEGORY_MONTH,
		var_0_0.TYPE_SHAM_SHOP
	},
	medal = {
		var_0_0.CATEGORY_MONTH,
		var_0_0.TYPE_MEDAL
	},
	fragment = {
		var_0_0.CATEGORY_MONTH,
		var_0_0.TYPE_FRAGMENT
	}
}
var_0_0.TYPE2NAME = {
	[var_0_0.TYPE_ACTIVITY] = "activity_shop_title",
	[var_0_0.TYPE_SHOP_STREET] = "street_shop_title",
	[var_0_0.TYPE_MILITARY_SHOP] = "military_shop_title",
	[var_0_0.TYPE_QUOTA] = "quota_shop_title1",
	[var_0_0.TYPE_SHAM_SHOP] = "sham_shop_title",
	[var_0_0.TYPE_FRAGMENT] = "fragment_shop_title",
	[var_0_0.TYPE_GUILD] = "guild_shop_title",
	[var_0_0.TYPE_MEDAL] = "medal_shop_title",
	[var_0_0.TYPE_META] = "meta_shop_title",
	[var_0_0.TYPE_MINI_GAME] = "mini_game_shop_title"
}
var_0_0.NEW_SKIN_SHOP_ID = 1
var_0_0.PERMANANT_SKIN_SHOP_ID = 2

return var_0_0
