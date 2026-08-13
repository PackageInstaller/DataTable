pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "island_speedup_ticket") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_speedup_ticket"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.island_speedup_ticket = var_0_2
pg = var_0

local var_0_3 = var_0.island_speedup_ticket

var_0_3.all = {
	10001,
	10002,
	10003,
	10004,
	10005,
	10006,
	10007,
	20001,
	20002,
	20003,
	20004,
	20005,
	20006,
	20007,
	30001,
	30002,
	30003,
	30004,
	30005,
	30006,
	30007
}
pg = var_0_3

local var_0_4 = var_0_3.island_speedup_ticket

var_0_4.get_id_list_by_speedup_time = {
	[60] = {
		10001,
		10002,
		10003,
		10004,
		10005,
		10006,
		10007
	},
	[600] = {
		20001,
		20002,
		20003,
		20004,
		20005,
		20006,
		20007
	},
	[3600] = {
		30001,
		30002,
		30003,
		30004,
		30005,
		30006,
		30007
	}
}
pg = var_0_4
pg = var_1

local var_0_5

if not var_1.base then
	var_0_5 = {}
end

var_0_4.base = var_0_5
pg = var_0_4
var_0_4.base.island_speedup_ticket = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.island_speedup_ticket

	var_1_0[10001] = {
		name = "1分钟加速券",
		rarity = 2,
		type = 1,
		duration = 0,
		speedup_time = 60,
		desc = "使用后，能加速1分钟的时间，让发展快人一步。（在岛屿开发季I期活动内有效）",
		expiration_type = 2,
		id = 10001,
		icon = "islandprops/item_speedup_ticket1",
		icon_normal = "props/item_speedup_ticket1",
		expiration_time = {
			{
				2026,
				2,
				5
			},
			{
				12,
				0,
				0
			}
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.island_speedup_ticket

	var_1_1[10002] = {
		name = "1分钟加速券",
		rarity = 2,
		expiration_time = "",
		type = 1,
		duration = 7,
		speedup_time = 60,
		desc = "使用后，能加速1分钟的时间，让发展快人一步。（该加速券有效期为7天）",
		expiration_type = 1,
		id = 10002,
		icon = "islandprops/item_speedup_ticket1",
		icon_normal = "props/item_speedup_ticket1"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.island_speedup_ticket

	var_1_2[10003] = {
		name = "1分钟加速券",
		rarity = 2,
		expiration_time = "",
		type = 1,
		duration = 3,
		speedup_time = 60,
		desc = "使用后，能加速1分钟的时间，让发展快人一步。（该加速券有效期为3天）",
		expiration_type = 1,
		id = 10003,
		icon = "islandprops/item_speedup_ticket1",
		icon_normal = "props/item_speedup_ticket1"
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.island_speedup_ticket

	var_1_3[10004] = {
		name = "1分钟加速券",
		rarity = 2,
		expiration_time = "",
		type = 1,
		duration = 2,
		speedup_time = 60,
		desc = "使用后，能加速1分钟的时间，让发展快人一步。（该加速券有效期为2天）",
		expiration_type = 1,
		id = 10004,
		icon = "islandprops/item_speedup_ticket1",
		icon_normal = "props/item_speedup_ticket1"
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.island_speedup_ticket

	var_1_4[10005] = {
		name = "1分钟加速券",
		rarity = 2,
		type = 1,
		duration = 0,
		speedup_time = 60,
		desc = "使用后，能加速1分钟的时间，让发展快人一步。（在岛屿开发季II期活动内有效）",
		expiration_type = 2,
		id = 10005,
		icon = "islandprops/item_speedup_ticket1",
		icon_normal = "props/item_speedup_ticket1",
		expiration_time = {
			{
				2026,
				5,
				7
			},
			{
				12,
				0,
				0
			}
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.island_speedup_ticket

	var_1_5[10006] = {
		name = "1分钟加速券",
		rarity = 2,
		type = 1,
		duration = 0,
		speedup_time = 60,
		desc = "使用后，能加速1分钟的时间，让发展快人一步。（在岛屿开发季III期活动内有效）",
		expiration_type = 2,
		id = 10006,
		icon = "islandprops/item_speedup_ticket1",
		icon_normal = "props/item_speedup_ticket1",
		expiration_time = {
			{
				2026,
				8,
				6
			},
			{
				12,
				0,
				0
			}
		}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.island_speedup_ticket

	var_1_6[10007] = {
		name = "1分钟加速券",
		rarity = 2,
		type = 1,
		duration = 0,
		speedup_time = 60,
		desc = "使用后，能加速1分钟的时间，让发展快人一步。（在岛屿开发季IV期活动内有效）",
		expiration_type = 2,
		id = 10007,
		icon = "islandprops/item_speedup_ticket1",
		icon_normal = "props/item_speedup_ticket1",
		expiration_time = {
			{
				2026,
				11,
				5
			},
			{
				12,
				0,
				0
			}
		}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.island_speedup_ticket

	var_1_7[20001] = {
		name = "10分钟加速券",
		rarity = 3,
		type = 2,
		duration = 0,
		speedup_time = 600,
		desc = "使用后，能加速10分钟的时间，让发展快人一步。（在岛屿开发季I期活动内有效）",
		expiration_type = 2,
		id = 20001,
		icon = "islandprops/item_speedup_ticket2",
		icon_normal = "props/item_speedup_ticket2",
		expiration_time = {
			{
				2026,
				2,
				5
			},
			{
				12,
				0,
				0
			}
		}
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.island_speedup_ticket

	var_1_8[20002] = {
		name = "10分钟加速券",
		rarity = 3,
		expiration_time = "",
		type = 2,
		duration = 7,
		speedup_time = 600,
		desc = "使用后，能加速10分钟的时间，让发展快人一步。（该加速券有效期为7天）",
		expiration_type = 1,
		id = 20002,
		icon = "islandprops/item_speedup_ticket2",
		icon_normal = "props/item_speedup_ticket2"
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.island_speedup_ticket

	var_1_9[20003] = {
		name = "10分钟加速券",
		rarity = 3,
		expiration_time = "",
		type = 2,
		duration = 3,
		speedup_time = 600,
		desc = "使用后，能加速10分钟的时间，让发展快人一步。（该加速券有效期为3天）",
		expiration_type = 1,
		id = 20003,
		icon = "islandprops/item_speedup_ticket2",
		icon_normal = "props/item_speedup_ticket2"
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.island_speedup_ticket

	var_1_10[20004] = {
		name = "10分钟加速券",
		rarity = 3,
		expiration_time = "",
		type = 2,
		duration = 2,
		speedup_time = 600,
		desc = "使用后，能加速10分钟的时间，让发展快人一步。（该加速券有效期为2天）",
		expiration_type = 1,
		id = 20004,
		icon = "islandprops/item_speedup_ticket2",
		icon_normal = "props/item_speedup_ticket2"
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.island_speedup_ticket

	var_1_11[20005] = {
		name = "10分钟加速券",
		rarity = 3,
		type = 2,
		duration = 0,
		speedup_time = 600,
		desc = "使用后，能加速10分钟的时间，让发展快人一步。（在岛屿开发季II期活动内有效）",
		expiration_type = 2,
		id = 20005,
		icon = "islandprops/item_speedup_ticket2",
		icon_normal = "props/item_speedup_ticket2",
		expiration_time = {
			{
				2026,
				5,
				7
			},
			{
				12,
				0,
				0
			}
		}
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.island_speedup_ticket

	var_1_12[20006] = {
		name = "10分钟加速券",
		rarity = 3,
		type = 2,
		duration = 0,
		speedup_time = 600,
		desc = "使用后，能加速10分钟的时间，让发展快人一步。（在岛屿开发季II期活动内有效）",
		expiration_type = 2,
		id = 20006,
		icon = "islandprops/item_speedup_ticket2",
		icon_normal = "props/item_speedup_ticket2",
		expiration_time = {
			{
				2026,
				8,
				6
			},
			{
				12,
				0,
				0
			}
		}
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.island_speedup_ticket

	var_1_13[20007] = {
		name = "10分钟加速券",
		rarity = 3,
		type = 2,
		duration = 0,
		speedup_time = 600,
		desc = "使用后，能加速10分钟的时间，让发展快人一步。（在岛屿开发季IV期活动内有效）",
		expiration_type = 2,
		id = 20007,
		icon = "islandprops/item_speedup_ticket2",
		icon_normal = "props/item_speedup_ticket2",
		expiration_time = {
			{
				2026,
				11,
				5
			},
			{
				12,
				0,
				0
			}
		}
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.island_speedup_ticket

	var_1_14[30001] = {
		name = "60分钟加速券",
		rarity = 4,
		type = 3,
		duration = 0,
		speedup_time = 3600,
		desc = "使用后，能加速60分钟的时间，让发展快人一步。（在岛屿开发季I期活动内有效）",
		expiration_type = 2,
		id = 30001,
		icon = "islandprops/item_speedup_ticket3",
		icon_normal = "props/item_speedup_ticket3",
		expiration_time = {
			{
				2026,
				2,
				5
			},
			{
				12,
				0,
				0
			}
		}
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.island_speedup_ticket

	var_1_15[30002] = {
		name = "60分钟加速券",
		rarity = 4,
		expiration_time = "",
		type = 3,
		duration = 7,
		speedup_time = 3600,
		desc = "使用后，能加速60分钟的时间，让发展快人一步。（该加速券有效期为7天）",
		expiration_type = 1,
		id = 30002,
		icon = "islandprops/item_speedup_ticket3",
		icon_normal = "props/item_speedup_ticket3"
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.island_speedup_ticket

	var_1_16[30003] = {
		name = "60分钟加速券",
		rarity = 4,
		expiration_time = "",
		type = 3,
		duration = 3,
		speedup_time = 3600,
		desc = "使用后，能加速60分钟的时间，让发展快人一步。（该加速券有效期为3天）",
		expiration_type = 1,
		id = 30003,
		icon = "islandprops/item_speedup_ticket3",
		icon_normal = "props/item_speedup_ticket3"
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.island_speedup_ticket

	var_1_17[30004] = {
		name = "60分钟加速券",
		rarity = 4,
		expiration_time = "",
		type = 3,
		duration = 2,
		speedup_time = 3600,
		desc = "使用后，能加速60分钟的时间，让发展快人一步。（该加速券有效期为2天）",
		expiration_type = 1,
		id = 30004,
		icon = "islandprops/item_speedup_ticket3",
		icon_normal = "props/item_speedup_ticket3"
	}
	pg = var_1_17

	local var_1_18 = var_1_17.base.island_speedup_ticket

	var_1_18[30005] = {
		name = "60分钟加速券",
		rarity = 4,
		type = 3,
		duration = 0,
		speedup_time = 3600,
		desc = "使用后，能加速60分钟的时间，让发展快人一步。（在岛屿开发季II期活动内有效）",
		expiration_type = 2,
		id = 30005,
		icon = "islandprops/item_speedup_ticket3",
		icon_normal = "props/item_speedup_ticket3",
		expiration_time = {
			{
				2026,
				5,
				7
			},
			{
				12,
				0,
				0
			}
		}
	}
	pg = var_1_18

	local var_1_19 = var_1_18.base.island_speedup_ticket

	var_1_19[30006] = {
		name = "60分钟加速券",
		rarity = 4,
		type = 3,
		duration = 0,
		speedup_time = 3600,
		desc = "使用后，能加速60分钟的时间，让发展快人一步。（在岛屿开发季II期活动内有效）",
		expiration_type = 2,
		id = 30006,
		icon = "islandprops/item_speedup_ticket3",
		icon_normal = "props/item_speedup_ticket3",
		expiration_time = {
			{
				2026,
				8,
				6
			},
			{
				12,
				0,
				0
			}
		}
	}
	pg = var_1_19
	var_1_19.base.island_speedup_ticket[30007] = {
		name = "60分钟加速券",
		rarity = 4,
		type = 3,
		duration = 0,
		speedup_time = 3600,
		desc = "使用后，能加速60分钟的时间，让发展快人一步。（在岛屿开发季IV期活动内有效）",
		expiration_type = 2,
		id = 30007,
		icon = "islandprops/item_speedup_ticket3",
		icon_normal = "props/item_speedup_ticket3",
		expiration_time = {
			{
				2026,
				11,
				5
			},
			{
				12,
				0,
				0
			}
		}
	}

	return
end)()

return
