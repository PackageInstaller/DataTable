ChargeScene.TYPE_DIAMOND = 1
ChargeScene.TYPE_GIFT = 2
ChargeScene.TYPE_ITEM = 3
ChargeScene.TYPE_PICK = 4
;({}).CATEGORY_ACTIVITY = 1
;({}).CATEGORY_MONTH = 2
;({}).CATEGORY_SUPPLY = 3
;({}).SHOP_TYPE = {
	SUPPLY = "supply",
	SKIN = "skin",
	CHARGE = "charge"
}
;({}).SHOP_ID = {
	GIFT = 2,
	ACTIVITY = 7,
	DIAMOND = 1,
	ITEM = 3,
	SUPPLY = 6,
	PICK = 4,
	MONTH = 5
}
;({}).SHOP_LIST = {
	[({}).SHOP_TYPE.CHARGE] = {
		[ChargeScene.TYPE_DIAMOND] = 1,
		[ChargeScene.TYPE_GIFT] = 2,
		[ChargeScene.TYPE_ITEM] = 3,
		[ChargeScene.TYPE_PICK] = 4
	},
	[({}).SHOP_TYPE.SUPPLY] = {
		[({}).CATEGORY_MONTH] = 5,
		[({}).CATEGORY_SUPPLY] = 6,
		[({}).CATEGORY_ACTIVITY] = 7
	}
}
;({}).TYPE_ACTIVITY = 1
;({}).TYPE_SHOP_STREET = 2
;({}).TYPE_MILITARY_SHOP = 3
;({}).TYPE_QUOTA = 4
;({}).TYPE_SHAM_SHOP = 5
;({}).TYPE_FRAGMENT = 6
;({}).TYPE_GUILD = 7
;({}).TYPE_MEDAL = 8
;({}).TYPE_META = 9
;({}).TYPE_MINI_GAME = 10
;({}).SUPPLY_SHOP_LIST = {
	[({}).CATEGORY_MONTH] = {
		({}).TYPE_QUOTA,
		({}).TYPE_SHAM_SHOP,
		({}).TYPE_MEDAL,
		({}).TYPE_FRAGMENT
	},
	[({}).CATEGORY_SUPPLY] = {
		({}).TYPE_SHOP_STREET,
		({}).TYPE_MILITARY_SHOP,
		({}).TYPE_GUILD,
		({}).TYPE_META,
		({}).TYPE_MINI_GAME
	},
	[({}).CATEGORY_ACTIVITY] = {
		({}).TYPE_ACTIVITY
	}
}
;({}).SHOP_NAME_LIST = {
	activity = {
		({}).CATEGORY_ACTIVITY
	},
	shopstreet = {
		({}).CATEGORY_SUPPLY,
		({}).TYPE_SHOP_STREET
	},
	supplies = {
		({}).CATEGORY_SUPPLY,
		({}).TYPE_MILITARY_SHOP
	},
	guild = {
		({}).CATEGORY_SUPPLY,
		({}).TYPE_GUILD
	},
	meta = {
		({}).CATEGORY_SUPPLY,
		({}).TYPE_META
	},
	minigame = {
		({}).CATEGORY_SUPPLY,
		({}).TYPE_MINI_GAME
	},
	quota = {
		({}).CATEGORY_MONTH,
		({}).TYPE_QUOTA
	},
	sham = {
		({}).CATEGORY_MONTH,
		({}).TYPE_SHAM_SHOP
	},
	medal = {
		({}).CATEGORY_MONTH,
		({}).TYPE_MEDAL
	},
	fragment = {
		({}).CATEGORY_MONTH,
		({}).TYPE_FRAGMENT
	}
}
;({}).TYPE2NAME = {
	[({}).TYPE_ACTIVITY] = "activity_shop_title",
	[({}).TYPE_SHOP_STREET] = "street_shop_title",
	[({}).TYPE_MILITARY_SHOP] = "military_shop_title",
	[({}).TYPE_QUOTA] = "quota_shop_title1",
	[({}).TYPE_SHAM_SHOP] = "sham_shop_title",
	[({}).TYPE_FRAGMENT] = "fragment_shop_title",
	[({}).TYPE_GUILD] = "guild_shop_title",
	[({}).TYPE_MEDAL] = "medal_shop_title",
	[({}).TYPE_META] = "meta_shop_title",
	[({}).TYPE_MINI_GAME] = "mini_game_shop_title"
}
;({}).NEW_SKIN_SHOP_ID = 1
;({}).PERMANANT_SKIN_SHOP_ID = 2

return {}
