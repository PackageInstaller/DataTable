local var_0_0 = {}
local component_effect_data = require("data.component_effect_data")

var_0_0.COMPONENT_BAGLAYER = 1
var_0_0.MATRIAL_BAGLAYER = 2
var_0_0.FURNITURE_BAGLAYER = 3
var_0_0.WEAPON_BAGLAYER = 4
var_0_0.HORCRUX_LAYER = 5
var_0_0.COMPONENT_ITEMPANEL = 6
var_0_0.WEAPON_ITEMPANEL = 7
var_0_0.WEAPON_EXP_ITEMPANEL = 8
var_0_0.WEAPON_UPGRADE_ITEMPANEL = 9
var_0_0.DORMROOM_FURNITURE_ITEMPANEL = 10
var_0_0.MEDAL_ITEMPANEL = 11
var_0_0.SERVANT = 12
var_0_0.MAJOR = 13
var_0_0.LAB_RD = 14
var_0_0.LAB_RECIPE = 15
var_0_0.DORMITORY = 16
var_0_0.LABMATRIAL_BAGLAYER = 17
var_0_0.BASICMATRIAL_BAGLAYER = 18
var_0_0.AI_MONSTER_BAGLAYER = 19
var_0_0.SPRINGTASKLISTLAYER = 20
var_0_0.LANRERNTASKLISTLAYER = 21
var_0_0.CHAPTERLAMIATASKLISTLAYER = 22
var_0_0.COMPONENT_STRENGTHEN = 23
var_0_0.HORCRUX_UPSTAR_LAYER = 24
var_0_0.TEST_FIGHT = 25
var_0_0.ConfigTable = {
	[var_0_0.COMPONENT_BAGLAYER] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				6,
				4,
				"defence",
				3,
				5,
				2
			},
			{
				3,
				4,
				5
			},
			{
				10006,
				30004,
				20003,
				10002,
				30002,
				30007,
				30008,
				30009
			}
		},
		filter_str = {
			{
				defence = "防御",
				[2] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[2]],
				[3] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[3]],
				[4] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[4]],
				[5] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[5]],
				[6] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[6]]
			},
			L_FILTER_STR.COMPONENT_ITEMPANEL[2],
			{
				[10006] = component_effect_data[10006].name,
				[30004] = component_effect_data[30004].name,
				[20003] = component_effect_data[20003].name,
				[10002] = component_effect_data[10002].name,
				[30002] = component_effect_data[30002].name,
				[30007] = component_effect_data[30007].name,
				[30008] = component_effect_data[30008].name,
				[30009] = component_effect_data[30009].name
			}
		},
		filter_key = {
			"main_attr",
			"equip_quality",
			"component_attr_effect"
		},
		filter_type_str = L_FILTER_TYPE_STR.COMPONENT_BAGLAYER,
		sort_table = {
			1,
			2,
			3,
			4
		},
		sort_str = L_FILTER_SORT_STR.COMPONENT_BAGLAYER
	},
	[var_0_0.MATRIAL_BAGLAYER] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				"other",
				"special_supply",
				"lab_matrial",
				"piece"
			},
			{
				1,
				2,
				3,
				4,
				5,
				6
			}
		},
		filter_str = {
			L_FILTER_STR.MATRIAL_BAGLAYER[1],
			L_FILTER_STR.MATRIAL_BAGLAYER[2]
		},
		filter_key = {
			[1] = "type",
			[2] = "equip_quality"
		},
		filter_type_str = L_FILTER_TYPE_STR.MATRIAL_BAGLAYER,
		sort_table = {
			1,
			2,
			3
		},
		sort_str = L_FILTER_SORT_STR.MATRIAL_BAGLAYER
	},
	[var_0_0.BASICMATRIAL_BAGLAYER] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				"consume",
				"breakout_item",
				"special_supply",
				"activity_item"
			},
			{
				1,
				2,
				3,
				4,
				5,
				6
			}
		},
		filter_str = {
			L_FILTER_STR.BASICMATRIAL_BAGLAYER[1],
			L_FILTER_STR.BASICMATRIAL_BAGLAYER[2]
		},
		filter_key = {
			[1] = "type",
			[2] = "equip_quality"
		},
		filter_type_str = L_FILTER_TYPE_STR.BASICMATRIAL_BAGLAYER,
		sort_table = {
			1,
			2,
			3
		},
		sort_str = L_FILTER_SORT_STR.BASICMATRIAL_BAGLAYER
	},
	[var_0_0.LABMATRIAL_BAGLAYER] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				"lab_matrial",
				"piece"
			},
			{
				1,
				2,
				3,
				4,
				5,
				6
			}
		},
		filter_str = {
			L_FILTER_STR.LABMATRIAL_BAGLAYER[1],
			L_FILTER_STR.LABMATRIAL_BAGLAYER[2]
		},
		filter_key = {
			[1] = "type",
			[2] = "equip_quality"
		},
		filter_type_str = L_FILTER_TYPE_STR.LABMATRIAL_BAGLAYER,
		sort_table = {
			1,
			2,
			3
		},
		sort_str = L_FILTER_SORT_STR.LABMATRIAL_BAGLAYER
	},
	[var_0_0.FURNITURE_BAGLAYER] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				"furniture",
				"gift",
				"skin"
			},
			{
				1,
				2,
				3,
				4,
				5,
				6
			}
		},
		filter_str = {
			L_FILTER_STR.FURNITURE_BAGLAYER[1],
			L_FILTER_STR.FURNITURE_BAGLAYER[2]
		},
		filter_key = {
			[1] = "type",
			[2] = "equip_quality"
		},
		filter_type_str = L_FILTER_TYPE_STR.FURNITURE_BAGLAYER,
		sort_table = {
			1,
			2,
			3
		},
		sort_str = L_FILTER_SORT_STR.FURNITURE_BAGLAYER
	},
	[var_0_0.WEAPON_BAGLAYER] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				"all",
				"special"
			},
			{
				1,
				2,
				3,
				4,
				5,
				6
			},
			{
				0,
				1,
				2,
				3,
				4,
				5
			}
		},
		filter_str = {
			L_FILTER_STR.WEAPON_BAGLAYER[1],
			L_FILTER_STR.WEAPON_BAGLAYER[2],
			L_FILTER_STR.WEAPON_BAGLAYER[3]
		},
		filter_key = {
			"preserves",
			"equip_quality",
			"nowStars"
		},
		filter_type_str = L_FILTER_TYPE_STR.WEAPON_BAGLAYER,
		sort_table = {
			1,
			2,
			3
		},
		sort_str = L_FILTER_SORT_STR.WEAPON_BAGLAYER
	},
	[var_0_0.HORCRUX_LAYER] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			ATTR_HORCRUX_LIST,
			{
				1,
				2,
				3,
				4,
				5,
				6,
				7,
				8,
				9
			},
			{
				2,
				3,
				4,
				5
			},
			{
				1,
				2
			}
		},
		filter_str = {
			L_FILTER_STR.HORCRUX_LAYER[1],
			L_FILTER_STR.HORCRUX_LAYER[2],
			{
				[2] = L_TWIST_LEVEL[4],
				[3] = L_TWIST_LEVEL[3],
				[4] = L_TWIST_LEVEL[2],
				[5] = L_TWIST_LEVEL[1]
			},
			{
				[1] = "已装备",
				[2] = "未装备"
			}
		},
		filter_key = {
			"attr",
			"stars",
			"rarity",
			"hasOwner"
		},
		filter_type_str = L_FILTER_TYPE_STR.HORCRUX_LAYER,
		sort_table = {
			1,
			2,
			3,
			4,
			5,
			6
		},
		sort_str = L_FILTER_SORT_STR.HORCRUX_LAYER
	},
	[var_0_0.COMPONENT_ITEMPANEL] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				6,
				4,
				13,
				7,
				10,
				3,
				5,
				2,
				"other"
			},
			{
				3,
				4,
				5,
				6
			},
			{
				10006,
				30004,
				20003,
				10002,
				30002,
				30007,
				30008,
				30009,
				30012,
				30010
			}
		},
		filter_str = {
			{
				other = "其它",
				[2] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[2]],
				[3] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[3]],
				[4] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[4]],
				[5] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[5]],
				[6] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[6]],
				[7] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[7]],
				[10] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[10]],
				[13] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[13]]
			},
			L_FILTER_STR.COMPONENT_ITEMPANEL[2],
			{
				[10006] = component_effect_data[10006].name,
				[30004] = component_effect_data[30004].name,
				[20003] = component_effect_data[20003].name,
				[10002] = component_effect_data[10002].name,
				[30002] = component_effect_data[30002].name,
				[30007] = component_effect_data[30007].name,
				[30008] = component_effect_data[30008].name,
				[30009] = component_effect_data[30009].name,
				[30012] = component_effect_data[30012].name,
				[30010] = component_effect_data[30010].name
			}
		},
		filter_key = {
			"main_attr",
			"equip_quality",
			"component_attr_effect"
		},
		filter_type_str = L_FILTER_TYPE_STR.COMPONENT_ITEMPANEL,
		sort_table = {
			1,
			2,
			3,
			4
		},
		sort_str = L_FILTER_SORT_STR.COMPONENT_ITEMPANEL
	},
	[var_0_0.WEAPON_ITEMPANEL] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				"all",
				"special"
			},
			{
				1,
				2,
				3,
				4,
				5,
				6
			},
			{
				0,
				1,
				2,
				3,
				4,
				5
			}
		},
		filter_str = {
			L_FILTER_STR.WEAPON_ITEMPANEL[1],
			L_FILTER_STR.WEAPON_ITEMPANEL[2],
			L_FILTER_STR.WEAPON_ITEMPANEL[3]
		},
		filter_key = {
			"preserves",
			"equip_quality",
			"nowStars"
		},
		filter_type_str = L_FILTER_TYPE_STR.WEAPON_ITEMPANEL,
		sort_table = {
			1,
			2,
			3
		},
		sort_str = L_FILTER_SORT_STR.WEAPON_ITEMPANEL
	},
	[var_0_0.WEAPON_EXP_ITEMPANEL] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				1,
				2,
				3,
				4,
				5
			}
		},
		filter_str = {
			L_FILTER_STR.WEAPON_EXP_ITEMPANEL[1]
		},
		filter_key = {
			[1] = "equip_quality"
		},
		filter_type_str = L_FILTER_TYPE_STR.WEAPON_EXP_ITEMPANEL,
		sort_table = {
			1
		},
		sort_str = L_FILTER_SORT_STR.WEAPON_EXP_ITEMPANEL
	},
	[var_0_0.WEAPON_UPGRADE_ITEMPANEL] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				1,
				2,
				3,
				4,
				5
			}
		},
		filter_str = {
			L_FILTER_STR.WEAPON_UPGRADE_ITEMPANEL[1]
		},
		filter_key = {
			[1] = "equip_quality"
		},
		filter_type_str = L_FILTER_TYPE_STR.WEAPON_UPGRADE_ITEMPANEL,
		sort_table = {
			1,
			2,
			3
		},
		sort_str = L_FILTER_SORT_STR.WEAPON_UPGRADE_ITEMPANEL
	},
	[var_0_0.DORMROOM_FURNITURE_ITEMPANEL] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				1,
				2,
				3,
				4,
				5
			},
			{
				1,
				2,
				3,
				4,
				5,
				6
			}
		},
		filter_str = {
			L_FILTER_STR.DORMROOM_FURNITURE_ITEMPANEL[1],
			L_FILTER_STR.DORMROOM_FURNITURE_ITEMPANEL[2]
		},
		filter_key = {
			[1] = "type",
			[2] = "equip_quality"
		},
		filter_type_str = L_FILTER_TYPE_STR.DORMROOM_FURNITURE_ITEMPANEL,
		sort_table = {
			1,
			2,
			3
		},
		sort_str = L_FILTER_SORT_STR.DORMROOM_FURNITURE_ITEMPANEL
	},
	[var_0_0.MEDAL_ITEMPANEL] = {
		default_sort_order = 0,
		default_sort_type = 1
	},
	[var_0_0.MAJOR] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				1,
				2
			}
		},
		filter_str = {
			L_FILTER_STR.MAJOR[1]
		},
		filter_key = {
			[1] = "type"
		},
		filter_type_str = L_FILTER_TYPE_STR.MAJOR,
		sort_table = {
			1
		},
		sort_str = L_FILTER_SORT_STR.MAJOR
	},
	[var_0_0.LAB_RD] = {
		default_sort_type = 1,
		default_sort_order = 0,
		filter_table = {
			{
				"project",
				"blueprint"
			}
		},
		filter_str = {
			L_FILTER_TYPE_STR.LAB_RD
		},
		filter_key = {
			[1] = "type"
		}
	},
	[var_0_0.LAB_RECIPE] = {
		default_sort_type = 1,
		default_sort_order = 0,
		filter_table = {
			{
				"1",
				"2",
				"3",
				"4",
				"5"
			}
		},
		filter_str = {
			{
				["3"] = "3",
				["2"] = "2",
				["5"] = "5",
				["1"] = "1",
				["4"] = "4"
			}
		},
		filter_key = {
			[1] = "type"
		}
	},
	[var_0_0.DORMITORY] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				1
			}
		},
		filter_str = {
			L_FILTER_TYPE_STR.DORMITORY
		},
		filter_key = {
			[1] = "type"
		},
		filter_type_str = L_FILTER_TYPE_STR.DORMITORY,
		sort_table = {
			1
		},
		sort_str = L_FILTER_SORT_STR.DORMITORY
	},
	[var_0_0.AI_MONSTER_BAGLAYER] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				1,
				2,
				3,
				4
			},
			{
				1,
				2,
				3,
				4,
				5,
				6
			}
		},
		filter_str = {
			L_FILTER_STR.AI_MONSTER_BAGLAYER[1],
			L_FILTER_STR.AI_MONSTER_BAGLAYER[2]
		},
		filter_key = {
			[1] = "group",
			[2] = "equip_quality"
		},
		filter_type_str = L_FILTER_TYPE_STR.AI_MONSTER_BAGLAYER,
		sort_table = {
			1,
			2
		},
		sort_str = L_FILTER_SORT_STR.AI_MONSTER_BAGLAYER
	},
	[var_0_0.SPRINGTASKLISTLAYER] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				1,
				2,
				3,
				4,
				5
			}
		},
		filter_str = {
			L_FILTER_TYPE_STR.SPRINGTASKLISTLAYER
		},
		filter_key = {
			[1] = "type"
		},
		filter_type_str = L_FILTER_TYPE_STR.SPRINGTASKLISTLAYER
	},
	[var_0_0.COMPONENT_STRENGTHEN] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				6,
				4,
				"defence",
				3,
				5,
				2,
				"sp"
			},
			{
				3,
				4,
				5
			},
			{
				10006,
				30004,
				20003,
				10002,
				30002,
				30007,
				30008,
				30009
			}
		},
		filter_str = {
			{
				defence = "防御",
				sp = "科技点",
				[2] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[2]],
				[3] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[3]],
				[4] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[4]],
				[5] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[5]],
				[6] = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[6]]
			},
			L_FILTER_STR.COMPONENT_ITEMPANEL[2],
			{
				[10006] = component_effect_data[10006].name,
				[30004] = component_effect_data[30004].name,
				[20003] = component_effect_data[20003].name,
				[10002] = component_effect_data[10002].name,
				[30002] = component_effect_data[30002].name,
				[30007] = component_effect_data[30007].name,
				[30008] = component_effect_data[30008].name,
				[30009] = component_effect_data[30009].name
			}
		},
		filter_key = {
			"main_attr",
			"equip_quality",
			"component_attr_effect"
		},
		filter_type_str = L_FILTER_TYPE_STR.COMPONENT_ITEMPANEL,
		sort_table = {
			1,
			2,
			3,
			4
		},
		sort_str = L_FILTER_SORT_STR.COMPONENT_STRENGTHEN
	},
	[var_0_0.LANRERNTASKLISTLAYER] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				1,
				2
			}
		},
		filter_str = {
			L_FILTER_TYPE_STR.LANRERNTASKLISTLAYER
		},
		filter_key = {
			[1] = "type"
		},
		filter_type_str = L_FILTER_TYPE_STR.LANRERNTASKLISTLAYER
	},
	[var_0_0.CHAPTERLAMIATASKLISTLAYER] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				1,
				2
			}
		},
		filter_str = {
			L_FILTER_TYPE_STR.CHAPTERLAMIATASKLISTLAYER
		},
		filter_key = {
			[1] = "type"
		},
		filter_type_str = L_FILTER_TYPE_STR.CHAPTERLAMIATASKLISTLAYER
	},
	[var_0_0.HORCRUX_UPSTAR_LAYER] = {
		default_sort_order = 0,
		default_sort_type = 1,
		filter_table = {
			{
				1,
				2,
				3,
				4,
				5
			},
			{
				1,
				2,
				3,
				4,
				5,
				6,
				7
			},
			{
				1,
				2,
				3,
				4,
				5
			}
		},
		filter_str = {
			L_FILTER_STR.HORCRUX_LAYER[1],
			L_FILTER_STR.HORCRUX_LAYER[2],
			{
				[1] = "R",
				[2] = L_TWIST_LEVEL[4],
				[3] = L_TWIST_LEVEL[3],
				[4] = L_TWIST_LEVEL[2],
				[5] = L_TWIST_LEVEL[1]
			}
		},
		filter_key = {
			"attr",
			"stars",
			"rarity"
		},
		filter_type_str = L_FILTER_TYPE_STR.HORCRUX_LAYER,
		sort_table = {
			1,
			2,
			3,
			4
		},
		sort_str = L_FILTER_SORT_STR.HORCRUX_LAYER
	}
}

setmetatable(var_0_0.ConfigTable, {
	__index = function(arg_1_0, arg_1_1)
		if arg_1_1 == var_0_0.SERVANT then
			return {
				default_sort_order = 0,
				default_sort_type = 1,
				filter_table = {
					var_0_0:getServantFilterOrder(),
					{
						2,
						3,
						4,
						5
					},
					{
						"STR",
						"DEX",
						"INT",
						"FIG",
						"ASS",
						"SUP"
					},
					{
						"breakLimit",
						"linkage"
					}
				},
				filter_str = {
					L_FILTER_STR.SERVANT[1],
					{
						[2] = L_TWIST_LEVEL[4],
						[3] = L_TWIST_LEVEL[2],
						[4] = L_TWIST_LEVEL[3],
						[5] = L_TWIST_LEVEL[1]
					},
					{
						STR = L_CAREER.STR,
						DEX = L_CAREER.DEX,
						INT = L_CAREER.INT,
						FIG = L_CAREER.FIG,
						ASS = L_CAREER.ASS,
						SUP = L_CAREER.SUP
					},
					{
						breakLimit = L_CAN_BREAKOUT,
						linkage = L_ISLINKAGE
					}
				},
				filter_key = {
					"attr",
					"rarity",
					"career",
					"other"
				},
				filter_type_str = L_FILTER_TYPE_STR.SERVANT,
				sort_table = {
					10,
					1,
					2,
					3
				},
				sort_str = L_FILTER_SORT_STR.SERVANT
			}
		elseif var_0_0.TEST_FIGHT then
			return {
				default_sort_order = 0,
				default_sort_type = 1,
				filter_table = {
					var_0_0:getServantFilterOrder(),
					{
						2,
						3,
						4,
						5
					},
					{
						"STR",
						"DEX",
						"INT",
						"FIG",
						"ASS",
						"SUP"
					}
				},
				filter_str = {
					L_FILTER_STR.SERVANT[1],
					{
						[2] = L_TWIST_LEVEL[4],
						[3] = L_TWIST_LEVEL[3],
						[4] = L_TWIST_LEVEL[2],
						[5] = L_TWIST_LEVEL[1]
					},
					{
						STR = L_CAREER.STR,
						DEX = L_CAREER.DEX,
						INT = L_CAREER.INT,
						FIG = L_CAREER.FIG,
						ASS = L_CAREER.ASS,
						SUP = L_CAREER.SUP
					}
				},
				filter_key = {
					"attr",
					"rarity",
					"career"
				},
				filter_type_str = L_FILTER_TYPE_STR.SERVANT,
				sort_table = {
					2,
					1,
					10,
					3
				},
				sort_str = L_FILTER_SORT_STR.SERVANT
			}
		end
	end
})

var_0_0.BagConfig = {
	[var_0_0.COMPONENT_BAGLAYER] = {
		bagType = 1,
		index = 1
	},
	[var_0_0.MATRIAL_BAGLAYER] = {
		bagType = 2,
		index = 1
	},
	[var_0_0.FURNITURE_BAGLAYER] = {
		bagType = 3,
		index = 1
	},
	[var_0_0.WEAPON_BAGLAYER] = {
		bagType = 4,
		index = 1
	},
	[var_0_0.HORCRUX_LAYER] = {
		bagType = 5,
		index = 1
	},
	[var_0_0.COMPONENT_ITEMPANEL] = {
		bagType = 11,
		index = 1
	},
	[var_0_0.WEAPON_ITEMPANEL] = {
		bagType = 4,
		index = 1
	},
	[var_0_0.WEAPON_EXP_ITEMPANEL] = {
		bagType = 6,
		index = 1
	},
	[var_0_0.WEAPON_UPGRADE_ITEMPANEL] = {
		bagType = 4,
		index = 1
	},
	[var_0_0.DORMROOM_FURNITURE_ITEMPANEL] = {
		bagType = 7,
		index = 1
	},
	[var_0_0.MEDAL_ITEMPANEL] = {
		bagType = 8
	},
	[var_0_0.SERVANT] = {
		bagType = -1,
		index = 1
	},
	[var_0_0.TEST_FIGHT] = {
		bagType = -1,
		index = 1
	},
	[var_0_0.MAJOR] = {
		bagType = -1,
		index = 1
	},
	[var_0_0.LAB_RD] = {
		bagType = 10,
		index = 1
	},
	[var_0_0.LAB_RECIPE] = {
		bagType = -1,
		index = 1
	},
	[var_0_0.DORMITORY] = {
		bagType = -1,
		index = 1
	},
	[var_0_0.LABMATRIAL_BAGLAYER] = {
		bagType = 2,
		index = 1
	},
	[var_0_0.BASICMATRIAL_BAGLAYER] = {
		bagType = 2,
		index = 1
	},
	[var_0_0.AI_MONSTER_BAGLAYER] = {
		bagType = 19,
		index = 1
	},
	[var_0_0.SPRINGTASKLISTLAYER] = {
		bagType = -1,
		index = 1
	},
	[var_0_0.LANRERNTASKLISTLAYER] = {
		bagType = -1,
		index = 1
	},
	[var_0_0.CHAPTERLAMIATASKLISTLAYER] = {
		bagType = -1,
		index = 1
	},
	[var_0_0.COMPONENT_STRENGTHEN] = {
		bagType = 11,
		index = 1
	},
	[var_0_0.HORCRUX_UPSTAR_LAYER] = {
		bagType = 23,
		index = 1
	}
}

function var_0_0.getDefaultFilterData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = {}

	var_2_0.bag_type = var_0_0.BagConfig[arg_2_1].bagType
	var_2_0.sortType = var_0_0.ConfigTable[arg_2_1].default_sort_type
	var_2_0.sortOrder = arg_2_2 or var_0_0.ConfigTable[arg_2_1].default_sort_order
	var_2_0.filterConfig = {}

	if var_0_0.BagConfig[arg_2_1].index then
		var_2_0.filterConfig[var_0_0.ConfigTable[arg_2_1].filter_key[var_0_0.BagConfig[arg_2_1].index]] = {}
		var_2_0.filterConfig[var_0_0.ConfigTable[arg_2_1].filter_key[var_0_0.BagConfig[arg_2_1].index]][#var_2_0.filterConfig[var_0_0.ConfigTable[arg_2_1].filter_key[var_0_0.BagConfig[arg_2_1].index]] + 1] = var_0_0.ConfigTable[arg_2_1].filter_table[var_0_0.BagConfig[arg_2_1].index][arg_2_3 or 0]
	end

	return var_2_0
end

function var_0_0.getFilterValuePos(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	for iter_3_0, iter_3_1 in pairs(var_0_0.ConfigTable[arg_3_1].filter_table[arg_3_3 or var_0_0.BagConfig[arg_3_1].index]) do
		if iter_3_1 == arg_3_2 then
			return iter_3_0
		end
	end
end

function var_0_0.calcuServantFilterOrder(arg_4_0)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(ATTR_ID) do
		if iter_4_0 ~= 0 and not ATTR_LINKAGE_LIST[iter_4_1] and not ATTR_OTHER_LIST[iter_4_1] then
			table.insert(var_4_0, {
				order = iter_4_0,
				attr = iter_4_1
			})
		end
	end

	local var_4_1 = {
		[2] = {
			weight = 1,
			func = function(self, arg_5_1)
				return self.order < arg_5_1.order
			end
		},
		{
			weight = 100,
			func = function(self, arg_6_1)
				local var_6_0 = ATTR_SERVANT_WEIGHT[self.attr] or 0
				local var_6_1 = ATTR_SERVANT_WEIGHT[arg_6_1.attr] or 0

				if var_6_0 == var_6_1 then
					return "=="
				else
					return var_6_1 < var_6_0
				end
			end
		}
	}

	table.sort(var_4_1, function(arg_7_0, arg_7_1)
		return arg_7_0.weight > arg_7_1.weight
	end)
	table.sort(var_4_0, function(arg_8_0, arg_8_1)
		for iter_8_0 = 1, #var_4_1 do
			if var_4_1[iter_8_0].func(arg_8_0, arg_8_1) ~= "==" then
				return var_4_1[iter_8_0].func(arg_8_0, arg_8_1)
			end
		end
	end)

	local var_4_2 = {}

	for iter_4_2, iter_4_3 in pairs(var_4_0) do
		table.insert(var_4_2, iter_4_3.attr)
	end

	var_4_2[#var_4_2 + 1] = "other"

	table.sort(var_4_2, function(arg_9_0, arg_9_1)
		return (ATTR_FILTER_ORDER[arg_9_0] or 999999) < (ATTR_FILTER_ORDER[arg_9_1] or 999999)
	end)

	arg_4_0.servantAttrOrder = var_4_2
end

function var_0_0:getServantFilterOrder()
	if not self.servantAttrOrder then
		self:calcuServantFilterOrder()
	end

	return self.servantAttrOrder
end

return var_0_0
