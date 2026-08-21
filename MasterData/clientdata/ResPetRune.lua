-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResPetRune.lua

local RT = {}

RT[1] = {
	1
}
RT[2] = {
	2
}
RT[3] = {
	{
		type_id = 12,
		num = 300,
		type_name = Lang.get(29890)
	}
}
RT[4] = {
	{
		type_id = 14,
		num = 300,
		type_name = Lang.get(29899)
	}
}
RT[5] = {
	11
}
RT[6] = {
	12
}
RT[7] = {
	13
}
RT[8] = {
	14
}
RT[9] = {
	27
}
RT[10] = {
	28
}
RT[11] = {
	30
}
RT[12] = {
	31
}
RT[13] = {
	45
}
RT[14] = {
	48
}

local Data = {
	{
		cost_num = 1,
		cost_item = 500022,
		group = 1,
		node_type = 1,
		node_id = 1,
		id = 1,
		attr = {
			{
				type_id = 11,
				num = 134,
				type_name = Lang.get(29889)
			}
		},
		buff_desc = Lang.get(77268),
		name = Lang.get(78732)
	},
	{
		cost_num = 1,
		cost_item = 500022,
		group = 2,
		node_type = 1,
		node_id = 1,
		id = 2,
		attr = {
			{
				type_id = 13,
				num = 3118,
				type_name = Lang.get(29898)
			}
		},
		buff_desc = Lang.get(77269),
		name = Lang.get(78737)
	},
	{
		cost_item = 500022,
		state_id = 860001,
		unlock_level = 1,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 2,
		id = 3,
		buff_desc = Lang.get(77270),
		name = Lang.get(78733),
		pre_node = RT[1]
	},
	{
		cost_item = 500022,
		state_id = 860002,
		unlock_level = 1,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 2,
		id = 4,
		buff_desc = Lang.get(77271),
		name = Lang.get(78733),
		pre_node = RT[1]
	},
	{
		cost_item = 500022,
		state_id = 860003,
		unlock_level = 1,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 2,
		id = 5,
		buff_desc = Lang.get(77272),
		name = Lang.get(78733),
		pre_node = RT[1]
	},
	{
		cost_item = 500022,
		state_id = 860004,
		unlock_level = 1,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 2,
		id = 6,
		buff_desc = Lang.get(77273),
		name = Lang.get(78733),
		pre_node = RT[1]
	},
	{
		cost_item = 500022,
		state_id = 860005,
		unlock_level = 1,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 2,
		id = 7,
		buff_desc = Lang.get(77274),
		name = Lang.get(78738),
		pre_node = RT[2]
	},
	{
		cost_item = 500022,
		state_id = 860006,
		unlock_level = 1,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 2,
		id = 8,
		buff_desc = Lang.get(77275),
		name = Lang.get(78738),
		pre_node = RT[2]
	},
	{
		cost_item = 500022,
		state_id = 860007,
		unlock_level = 1,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 2,
		id = 9,
		buff_desc = Lang.get(77276),
		name = Lang.get(78738),
		pre_node = RT[2]
	},
	{
		cost_item = 500022,
		state_id = 860008,
		unlock_level = 1,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 2,
		id = 10,
		buff_desc = Lang.get(77277),
		name = Lang.get(78738),
		pre_node = RT[2]
	},
	{
		cost_num = 1,
		unlock_level = 5,
		group = 1,
		node_type = 1,
		cost_item = 500022,
		node_id = 3,
		id = 11,
		attr = {
			{
				type_id = 11,
				num = 182,
				type_name = Lang.get(29889)
			}
		},
		buff_desc = Lang.get(77278),
		name = Lang.get(78734),
		pre_node = {
			3,
			4,
			5
		}
	},
	{
		cost_num = 1,
		unlock_level = 5,
		group = 1,
		node_type = 1,
		cost_item = 500022,
		node_id = 3,
		id = 12,
		attr = RT[3],
		buff_desc = Lang.get(77279),
		name = Lang.get(78734),
		pre_node = {
			6
		}
	},
	{
		cost_num = 1,
		unlock_level = 5,
		group = 2,
		node_type = 1,
		cost_item = 500022,
		node_id = 3,
		id = 13,
		attr = {
			{
				type_id = 13,
				num = 4191,
				type_name = Lang.get(29898)
			}
		},
		buff_desc = Lang.get(77280),
		name = Lang.get(78739),
		pre_node = {
			7,
			8,
			9
		}
	},
	{
		cost_num = 1,
		unlock_level = 5,
		group = 2,
		node_type = 1,
		cost_item = 500022,
		node_id = 3,
		id = 14,
		attr = RT[4],
		buff_desc = Lang.get(77281),
		name = Lang.get(78739),
		pre_node = {
			10
		}
	},
	{
		cost_item = 500022,
		state_id = 860009,
		unlock_level = 10,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 4,
		id = 15,
		buff_desc = Lang.get(77282),
		name = Lang.get(78735),
		pre_node = RT[5]
	},
	{
		cost_item = 500022,
		state_id = 860010,
		unlock_level = 10,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 4,
		id = 16,
		buff_desc = Lang.get(77283),
		name = Lang.get(78735),
		pre_node = RT[5]
	},
	{
		cost_item = 500022,
		state_id = 860011,
		unlock_level = 10,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 4,
		id = 17,
		buff_desc = Lang.get(77284),
		name = Lang.get(78735),
		pre_node = RT[5]
	},
	{
		cost_item = 500022,
		state_id = 860012,
		unlock_level = 10,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 4,
		id = 18,
		buff_desc = Lang.get(77285),
		name = Lang.get(78735),
		pre_node = RT[6]
	},
	{
		cost_item = 500022,
		state_id = 860013,
		unlock_level = 10,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 4,
		id = 19,
		buff_desc = Lang.get(77286),
		name = Lang.get(78735),
		pre_node = RT[6]
	},
	{
		cost_item = 500022,
		state_id = 860014,
		unlock_level = 10,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 4,
		id = 20,
		buff_desc = Lang.get(80727),
		name = Lang.get(78735),
		pre_node = RT[6]
	},
	{
		cost_item = 500022,
		state_id = 860015,
		unlock_level = 10,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 4,
		id = 21,
		buff_desc = Lang.get(77288),
		name = Lang.get(80728),
		pre_node = RT[7]
	},
	{
		cost_item = 500022,
		state_id = 860016,
		unlock_level = 10,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 4,
		id = 22,
		buff_desc = Lang.get(77289),
		name = Lang.get(80728),
		pre_node = RT[7]
	},
	{
		cost_item = 500022,
		state_id = 860017,
		unlock_level = 10,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 4,
		id = 23,
		buff_desc = Lang.get(77290),
		name = Lang.get(80728),
		pre_node = RT[7]
	},
	{
		cost_item = 500022,
		state_id = 860018,
		unlock_level = 10,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 4,
		id = 24,
		buff_desc = Lang.get(77291),
		name = Lang.get(80728),
		pre_node = RT[8]
	},
	{
		cost_item = 500022,
		state_id = 860019,
		unlock_level = 10,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 4,
		id = 25,
		buff_desc = Lang.get(77292),
		name = Lang.get(80728),
		pre_node = RT[8]
	},
	{
		cost_item = 500022,
		state_id = 860020,
		unlock_level = 10,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 4,
		id = 26,
		buff_desc = Lang.get(80729),
		name = Lang.get(80728),
		pre_node = RT[8]
	},
	{
		cost_item = 500022,
		state_id = 860039,
		unlock_level = 14,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 5,
		id = 27,
		buff_desc = Lang.get(77294),
		name = Lang.get(80730),
		pre_node = {
			15,
			16
		}
	},
	{
		cost_num = 1,
		unlock_level = 14,
		group = 1,
		node_type = 1,
		cost_item = 500022,
		node_id = 5,
		id = 28,
		attr = {
			{
				type_id = 11,
				num = 220,
				type_name = Lang.get(29889)
			}
		},
		buff_desc = Lang.get(80229),
		name = Lang.get(80730),
		pre_node = {
			17,
			18
		}
	},
	{
		cost_num = 1,
		unlock_level = 14,
		group = 1,
		node_type = 1,
		cost_item = 500022,
		node_id = 5,
		id = 29,
		attr = RT[3],
		buff_desc = Lang.get(77279),
		name = Lang.get(80730),
		pre_node = {
			19,
			20
		}
	},
	{
		cost_item = 500022,
		state_id = 860041,
		unlock_level = 14,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 5,
		id = 30,
		buff_desc = Lang.get(77296),
		name = Lang.get(80731),
		pre_node = {
			21,
			22
		}
	},
	{
		cost_num = 1,
		unlock_level = 14,
		group = 2,
		node_type = 1,
		cost_item = 500022,
		node_id = 5,
		id = 31,
		attr = {
			{
				type_id = 13,
				num = 5065,
				type_name = Lang.get(29898)
			}
		},
		buff_desc = Lang.get(80230),
		name = Lang.get(80731),
		pre_node = {
			23,
			24
		}
	},
	{
		cost_num = 1,
		unlock_level = 14,
		group = 2,
		node_type = 1,
		cost_item = 500022,
		node_id = 5,
		id = 32,
		attr = RT[4],
		buff_desc = Lang.get(77281),
		name = Lang.get(80731),
		pre_node = {
			25,
			26
		}
	},
	{
		cost_item = 500022,
		state_id = 860021,
		unlock_level = 20,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 6,
		id = 33,
		buff_desc = Lang.get(77298),
		name = Lang.get(80732),
		pre_node = RT[9]
	},
	{
		cost_item = 500022,
		state_id = 860022,
		unlock_level = 20,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 6,
		id = 34,
		buff_desc = Lang.get(77299),
		name = Lang.get(80732),
		pre_node = RT[9]
	},
	{
		cost_item = 500022,
		state_id = 860023,
		unlock_level = 20,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 6,
		id = 35,
		buff_desc = Lang.get(77300),
		name = Lang.get(80732),
		pre_node = RT[10]
	},
	{
		cost_item = 500022,
		state_id = 860024,
		unlock_level = 20,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 6,
		id = 36,
		buff_desc = Lang.get(77301),
		name = Lang.get(80732),
		pre_node = RT[10]
	},
	{
		cost_item = 500022,
		state_id = 860025,
		unlock_level = 20,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 6,
		id = 37,
		buff_desc = Lang.get(77302),
		name = Lang.get(80732),
		pre_node = {
			29
		}
	},
	{
		cost_item = 500022,
		state_id = 860026,
		unlock_level = 20,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 6,
		id = 38,
		buff_desc = Lang.get(77303),
		name = Lang.get(80733),
		pre_node = RT[11]
	},
	{
		cost_item = 500022,
		state_id = 860027,
		unlock_level = 20,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 6,
		id = 39,
		buff_desc = Lang.get(77304),
		name = Lang.get(80733),
		pre_node = RT[11]
	},
	{
		cost_item = 500022,
		state_id = 860028,
		unlock_level = 20,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 6,
		id = 40,
		buff_desc = Lang.get(77305),
		name = Lang.get(80733),
		pre_node = RT[12]
	},
	{
		cost_item = 500022,
		state_id = 860029,
		unlock_level = 20,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 6,
		id = 41,
		buff_desc = Lang.get(77306),
		name = Lang.get(80733),
		pre_node = RT[12]
	},
	{
		cost_item = 500022,
		state_id = 860030,
		unlock_level = 20,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 6,
		id = 42,
		buff_desc = Lang.get(77307),
		name = Lang.get(80733),
		pre_node = {
			32
		}
	},
	{
		cost_item = 500022,
		state_id = 860040,
		unlock_level = 27,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 7,
		id = 43,
		buff_desc = Lang.get(81109),
		name = Lang.get(80734),
		pre_node = {
			33,
			34
		}
	},
	{
		cost_num = 1,
		unlock_level = 27,
		group = 1,
		node_type = 1,
		cost_item = 500022,
		node_id = 7,
		id = 44,
		attr = RT[3],
		buff_desc = Lang.get(77279),
		name = Lang.get(80734),
		pre_node = {
			35
		}
	},
	{
		cost_num = 1,
		unlock_level = 27,
		group = 1,
		node_type = 1,
		cost_item = 500022,
		node_id = 7,
		id = 45,
		attr = {
			{
				type_id = 11,
				num = 273,
				type_name = Lang.get(29889)
			}
		},
		buff_desc = Lang.get(77309),
		name = Lang.get(80734),
		pre_node = {
			36,
			37
		}
	},
	{
		cost_item = 500022,
		state_id = 860042,
		unlock_level = 27,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 7,
		id = 46,
		buff_desc = Lang.get(81110),
		name = Lang.get(80735),
		pre_node = {
			38,
			39
		}
	},
	{
		cost_num = 1,
		unlock_level = 27,
		group = 2,
		node_type = 1,
		cost_item = 500022,
		node_id = 7,
		id = 47,
		attr = RT[4],
		buff_desc = Lang.get(77281),
		name = Lang.get(80735),
		pre_node = {
			40
		}
	},
	{
		cost_num = 1,
		unlock_level = 27,
		group = 2,
		node_type = 1,
		cost_item = 500022,
		node_id = 7,
		id = 48,
		attr = {
			{
				type_id = 13,
				num = 6278,
				type_name = Lang.get(29898)
			}
		},
		buff_desc = Lang.get(77311),
		name = Lang.get(80735),
		pre_node = {
			41,
			42
		}
	},
	{
		cost_item = 500022,
		state_id = 860031,
		unlock_level = 30,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 8,
		id = 49,
		buff_desc = Lang.get(81111),
		name = Lang.get(80736),
		pre_node = {
			43
		}
	},
	{
		cost_item = 500022,
		state_id = 860032,
		unlock_level = 30,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 8,
		id = 50,
		buff_desc = Lang.get(81112),
		name = Lang.get(80736),
		pre_node = {
			44
		}
	},
	{
		cost_item = 500022,
		state_id = 860033,
		unlock_level = 30,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 8,
		id = 51,
		buff_desc = Lang.get(81113),
		name = Lang.get(80736),
		pre_node = RT[13]
	},
	{
		cost_item = 500022,
		state_id = 860034,
		unlock_level = 30,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 8,
		id = 52,
		buff_desc = Lang.get(81114),
		name = Lang.get(80736),
		pre_node = RT[13]
	},
	{
		cost_item = 500022,
		state_id = 860035,
		unlock_level = 30,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 8,
		id = 53,
		buff_desc = Lang.get(81115),
		name = Lang.get(80737),
		pre_node = {
			46
		}
	},
	{
		cost_item = 500022,
		state_id = 860036,
		unlock_level = 30,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 8,
		id = 54,
		buff_desc = Lang.get(81116),
		name = Lang.get(80737),
		pre_node = {
			47
		}
	},
	{
		cost_item = 500022,
		state_id = 860037,
		unlock_level = 30,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 8,
		id = 55,
		buff_desc = Lang.get(81117),
		name = Lang.get(80737),
		pre_node = RT[14]
	},
	{
		cost_item = 500022,
		state_id = 860038,
		unlock_level = 30,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 8,
		id = 56,
		buff_desc = Lang.get(81118),
		name = Lang.get(80737),
		pre_node = RT[14]
	},
	{
		cost_num = 1,
		unlock_level = 35,
		group = 1,
		node_type = 1,
		cost_item = 500022,
		node_id = 9,
		id = 57,
		attr = {
			{
				type_id = 11,
				num = 330,
				type_name = Lang.get(29889)
			}
		},
		buff_desc = Lang.get(77320),
		name = Lang.get(80738),
		pre_node = {
			49,
			50,
			51
		}
	},
	{
		cost_num = 1,
		unlock_level = 35,
		group = 1,
		node_type = 1,
		cost_item = 500022,
		node_id = 9,
		id = 58,
		attr = RT[3],
		buff_desc = Lang.get(77279),
		name = Lang.get(80738),
		pre_node = {
			52
		}
	},
	{
		cost_num = 1,
		unlock_level = 35,
		group = 2,
		node_type = 1,
		cost_item = 500022,
		node_id = 9,
		id = 59,
		attr = {
			{
				type_id = 13,
				num = 7585,
				type_name = Lang.get(29898)
			}
		},
		buff_desc = Lang.get(77321),
		name = Lang.get(78740),
		pre_node = {
			53,
			54,
			55
		}
	},
	{
		cost_num = 1,
		unlock_level = 35,
		group = 2,
		node_type = 1,
		cost_item = 500022,
		node_id = 9,
		id = 60,
		attr = RT[4],
		buff_desc = Lang.get(77281),
		name = Lang.get(78740),
		pre_node = {
			56
		}
	},
	{
		cost_item = 500022,
		state_id = 860039,
		unlock_level = 40,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 10,
		id = 61,
		buff_desc = Lang.get(77294),
		name = Lang.get(78736),
		pre_node = {
			57
		}
	},
	{
		cost_item = 500022,
		state_id = 860040,
		unlock_level = 40,
		group = 1,
		node_type = 1,
		cost_num = 1,
		node_id = 10,
		id = 62,
		buff_desc = Lang.get(81109),
		name = Lang.get(78736),
		pre_node = {
			58
		}
	},
	{
		cost_item = 500022,
		state_id = 860041,
		unlock_level = 40,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 10,
		id = 63,
		buff_desc = Lang.get(77296),
		name = Lang.get(78741),
		pre_node = {
			59
		}
	},
	{
		cost_item = 500022,
		state_id = 860042,
		unlock_level = 40,
		group = 2,
		node_type = 1,
		cost_num = 1,
		node_id = 10,
		id = 64,
		buff_desc = Lang.get(81110),
		name = Lang.get(78741),
		pre_node = {
			60
		}
	},
	[1001] = {
		cost_item = 500025,
		state_id = 2020010,
		cost_num = 1,
		node_type = 2,
		node_id = 1,
		id = 1001,
		level = 1,
		buff_desc = Lang.get(80739),
		name = Lang.get(80693)
	},
	[1002] = {
		cost_item = 500025,
		state_id = 2020010,
		cost_num = 1,
		node_type = 2,
		node_id = 1,
		id = 1002,
		level = 2,
		buff_desc = Lang.get(80740),
		name = Lang.get(80693),
		pre_node = {
			1001
		}
	},
	[1003] = {
		cost_item = 500025,
		state_id = 2020010,
		icon_path = "Atlas/PetAtlas/PetRuneMainAtlas2",
		node_type = 2,
		cost_num = 1,
		node_id = 1,
		id = 1003,
		icon = "IconCat01",
		level = 3,
		buff_desc = Lang.get(80741),
		name = Lang.get(80693),
		pre_node = {
			1002
		}
	},
	[1011] = {
		cost_item = 500026,
		state_id = 2020020,
		cost_num = 1,
		node_type = 2,
		node_id = 2,
		id = 1011,
		level = 1,
		buff_desc = Lang.get(85474),
		name = Lang.get(80695)
	},
	[1012] = {
		cost_item = 500026,
		state_id = 2020020,
		cost_num = 1,
		node_type = 2,
		node_id = 2,
		id = 1012,
		level = 2,
		buff_desc = Lang.get(85475),
		name = Lang.get(80695),
		pre_node = {
			1011
		}
	},
	[1013] = {
		cost_item = 500026,
		state_id = 2020020,
		icon_path = "Atlas/PetAtlas/PetRuneMainAtlas2",
		node_type = 2,
		cost_num = 1,
		node_id = 2,
		id = 1013,
		icon = "IconDog01",
		level = 3,
		buff_desc = Lang.get(85476),
		name = Lang.get(80695),
		pre_node = {
			1012
		}
	},
	[1021] = {
		cost_item = 500027,
		state_id = 2020030,
		cost_num = 1,
		node_type = 2,
		node_id = 3,
		id = 1021,
		level = 1,
		buff_desc = Lang.get(90818),
		name = Lang.get(90819)
	},
	[1022] = {
		cost_item = 500027,
		state_id = 2020030,
		cost_num = 1,
		node_type = 2,
		node_id = 3,
		id = 1022,
		level = 2,
		buff_desc = Lang.get(90820),
		name = Lang.get(90819),
		pre_node = {
			1021
		}
	},
	[1023] = {
		cost_item = 500027,
		state_id = 2020030,
		icon_path = "Atlas/PetAtlas/PetRuneMainAtlas2",
		node_type = 2,
		cost_num = 1,
		node_id = 3,
		id = 1023,
		icon = "IconRabbit01",
		level = 3,
		buff_desc = Lang.get(90821),
		name = Lang.get(90819),
		pre_node = {
			1022
		}
	},
	[1031] = {
		cost_item = 500028,
		state_id = 2020040,
		cost_num = 1,
		node_type = 2,
		node_id = 4,
		id = 1031,
		level = 1,
		buff_desc = Lang.get(105637),
		name = Lang.get(80697)
	},
	[1032] = {
		cost_item = 500028,
		state_id = 2020040,
		cost_num = 1,
		node_type = 2,
		node_id = 4,
		id = 1032,
		level = 2,
		buff_desc = Lang.get(105638),
		name = Lang.get(80697),
		pre_node = {
			1031
		}
	},
	[1033] = {
		cost_item = 500028,
		state_id = 2020040,
		icon_path = "Atlas/PetAtlas/PetRuneMainAtlas2",
		node_type = 2,
		cost_num = 1,
		node_id = 4,
		id = 1033,
		icon = "IconPig01",
		level = 3,
		buff_desc = Lang.get(105639),
		name = Lang.get(80697),
		pre_node = {
			1032
		}
	},
	[1041] = {
		cost_item = 500029,
		state_id = 2020050,
		cost_num = 1,
		node_type = 2,
		node_id = 5,
		id = 1041,
		level = 1,
		buff_desc = Lang.get(114966),
		name = Lang.get(80699)
	},
	[1042] = {
		cost_item = 500029,
		state_id = 2020050,
		cost_num = 1,
		node_type = 2,
		node_id = 5,
		id = 1042,
		level = 2,
		buff_desc = Lang.get(114967),
		name = Lang.get(80699),
		pre_node = {
			1041
		}
	},
	[1043] = {
		cost_item = 500029,
		state_id = 2020050,
		icon_path = "Atlas/PetAtlas/PetRuneMainAtlas2",
		node_type = 2,
		cost_num = 1,
		node_id = 5,
		id = 1043,
		icon = "IconDragon01",
		level = 3,
		buff_desc = Lang.get(114968),
		name = Lang.get(80699),
		pre_node = {
			1042
		}
	}
}

return Data
