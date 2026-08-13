class = var_0_10000

local var_0_0 = var_0_10000("Fushun3GameConst")

var_0_0.mini_game_leave = "mini_game_leave"
var_0_0.mini_game_pause = "mini_game_pause"
var_0_0.game_time = 999999999
var_0_0.level_time = 30
var_0_0.game_scale = 3
Vector3 = var_1
var_0_0.game_scale_v3 = var_1(var_0_0.game_scale, var_0_0.game_scale, var_0_0.game_scale)
Vector2 = var_1
var_0_0.char_init_pos = var_1(300, 450)
var_0_0.attack_cd = 0.45
var_0_0.damage_cd = 1
var_0_0.move_speed = 8
var_0_0.move_speed_shoose = 9
var_0_0.attack_time = 0.3
var_0_0.power_time = 2.5
var_0_0.power_max_num = 8000
var_0_0.power_sub_time = 1400
var_0_0.platform_distance = 2500
var_0_0.platform_remove = 1500
var_0_0.heart_num = 4
var_0_0.day_type = 1
var_0_0.sunset_type = 2
var_0_0.night_type = 3
var_0_0.time_data = {
	{
		time = 30000000,
		name = "day",
		tf = "day1",
		type = 1,
		next = 2,
		anim = "day",
		change_anim = "nightToDay"
	},
	{
		time = 30000000,
		name = "sunset",
		tf = "sunSet",
		type = 2,
		next = 3,
		anim = "sunset",
		change_anim = "dayToSunset"
	},
	{
		time = 30000000,
		name = "night",
		tf = "night",
		type = 3,
		next = 1,
		anim = "night",
		change_anim = "sunsetToNight"
	}
}
var_0_0.platform_data = {
	{
		name = "Roof1",
		distance = 256,
		power = true,
		weight = 100,
		diff = 0
	},
	{
		item = true,
		name = "Roof2",
		distance = 320,
		power = true,
		weight = 50,
		diff = 50
	},
	{
		item = true,
		name = "Roof3",
		distance = 256,
		monster = true,
		power = true,
		weight = 50,
		diff = 25
	},
	{
		monster = true,
		name = "Roof3",
		distance = 256,
		power = true,
		weight = 100,
		diff = 50
	},
	{
		name = "Roof_Cliff1",
		distance = 256,
		power = false,
		weight = 50,
		diff = 50
	},
	{
		item = true,
		name = "Roof_Cliff2",
		distance = 384,
		power = false,
		weight = 50,
		diff = 50
	},
	{
		name = "Roof_Cliff3",
		distance = 320,
		power = false,
		weight = 100,
		diff = 0
	},
	{
		high = true,
		name = "Roof_Obstacle1",
		distance = 256,
		power = true,
		weight = 100,
		diff = 0
	},
	{
		high = true,
		name = "Roof_Obstacle2",
		distance = 320,
		power = true,
		weight = 100,
		diff = 0
	},
	{
		high = true,
		name = "Roof_Obstacle3",
		distance = 320,
		monster = true,
		power = true,
		item = true,
		weight = 50,
		diff = 25
	},
	{
		high = true,
		name = "Roof_Obstacle4",
		distance = 192,
		monster = true,
		power = true,
		weight = 100,
		diff = 50
	},
	{
		high = true,
		name = "Roof_Obstacle5",
		distance = 192,
		monster = true,
		power = true,
		weight = 100,
		diff = 50
	}
}
var_0_0.item_type_score = 1
var_0_0.item_type_buff = 2
var_0_0.item_type_damage = 3
var_0_0.create_time = {
	3,
	5
}
var_0_0.item_h = 94
var_0_0.item_v = 94
var_0_0.item_data = {
	{
		score = 50,
		effect = "EF_fr_Get_Score_Item",
		name = "Score_A",
		id = 1,
		type = var_0_0.item_type_score
	},
	{
		score = 300,
		effect = "EF_fr_Item",
		name = "Score_A2",
		id = 2,
		type = var_0_0.item_type_score
	},
	{
		buff_id = 1,
		effect = "EF_fr_Item",
		name = "Score_B",
		id = 3,
		type = var_0_0.item_type_buff
	},
	{
		buff_id = 2,
		effect = "EF_fr_Item",
		name = "Score_C",
		id = 4,
		type = var_0_0.item_type_buff
	},
	{
		buff_id = 3,
		effect = "EF_fr_Item",
		name = "Score_D",
		id = 5,
		type = var_0_0.item_type_buff
	},
	{
		buff_id = 4,
		effect = "EF_fr_Item",
		name = "Score_F",
		id = 6,
		type = var_0_0.item_type_buff
	},
	{
		speed = 2500,
		effect = "EF_fr_Item",
		name = "rocket",
		id = 7,
		type = var_0_0.item_type_damage
	},
	{
		speed = 2500,
		effect = "EF_fr_Item",
		name = "tamachan",
		id = 8,
		type = var_0_0.item_type_damage
	},
	{
		speed = 2500,
		effect = "EF_fr_Item",
		name = "sushi",
		id = 9,
		type = var_0_0.item_type_damage
	}
}
var_0_0.item_map = {
	{
		id = 1,
		list = {
			{
				1,
				1,
				1
			},
			{
				1,
				2,
				1
			},
			{
				1,
				1,
				1
			}
		}
	},
	{
		id = 2,
		list = {
			{
				1,
				2,
				1
			},
			{
				1,
				1,
				1
			},
			{
				0,
				0,
				0
			}
		}
	},
	{
		id = 3,
		list = {
			{
				0,
				0,
				2,
				0,
				0,
				0,
				2,
				0,
				0,
				0,
				2,
				0,
				0
			},
			{
				0,
				1,
				0,
				1,
				0,
				1,
				0,
				1,
				0,
				1,
				0,
				1,
				0
			},
			{
				1,
				0,
				0,
				0,
				1,
				0,
				0,
				0,
				1,
				0,
				0,
				0,
				1
			}
		}
	},
	{
		id = 4,
		list = {
			{
				3
			}
		}
	},
	{
		id = 5,
		list = {
			{
				4
			}
		}
	},
	{
		id = 6,
		list = {
			{
				6
			}
		}
	},
	{
		id = 7,
		list = {
			{
				0,
				0,
				0,
				2,
				0,
				0,
				0
			},
			{
				0,
				0,
				1,
				0,
				1,
				0,
				0
			},
			{
				0,
				1,
				0,
				0,
				0,
				1,
				0
			},
			{
				1,
				0,
				0,
				0,
				0,
				0,
				1
			}
		}
	},
	{
		id = 8,
		list = {
			{
				0,
				1,
				1,
				0,
				1,
				1,
				0
			},
			{
				1,
				0,
				0,
				2,
				0,
				0,
				1
			},
			{
				0,
				1,
				0,
				0,
				0,
				1,
				0
			},
			{
				0,
				0,
				1,
				0,
				1,
				0,
				0
			},
			{
				0,
				0,
				0,
				1,
				0,
				0,
				0
			}
		}
	},
	{
		id = 9,
		list = {
			{
				0,
				0,
				0,
				0,
				2,
				0,
				0,
				0,
				0
			},
			{
				1,
				1,
				1,
				1,
				1,
				1,
				1,
				1,
				1
			},
			{
				0,
				1,
				1,
				0,
				0,
				0,
				1,
				1,
				0
			},
			{
				0,
				1,
				1,
				0,
				0,
				0,
				1,
				1,
				0
			},
			{
				1,
				1,
				1,
				1,
				1,
				1,
				1,
				1,
				1
			},
			{
				0,
				0,
				0,
				0,
				2,
				0,
				0,
				0,
				0
			}
		}
	},
	{
		id = 10,
		list = {
			{
				0,
				0,
				1,
				0,
				0
			},
			{
				0,
				1,
				0,
				1,
				0
			},
			{
				1,
				0,
				0,
				0,
				1
			},
			{
				0,
				1,
				0,
				1,
				0
			},
			{
				0,
				0,
				1,
				0,
				0
			}
		}
	},
	{
		id = 11,
		list = {
			{
				1,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				1
			},
			{
				0,
				1,
				0,
				0,
				0,
				0,
				0,
				1,
				0
			},
			{
				0,
				0,
				1,
				0,
				0,
				0,
				1,
				0,
				0
			},
			{
				0,
				0,
				0,
				1,
				0,
				1,
				0,
				0,
				0
			},
			{
				0,
				0,
				0,
				0,
				2,
				0,
				0,
				0,
				0
			}
		}
	},
	{
		id = 12,
		list = {
			{
				1,
				1,
				1,
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				2,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				2,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				2,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				2,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1,
				1,
				1,
				1
			}
		}
	},
	{
		id = 13,
		list = {
			{
				1,
				0,
				0,
				0,
				0,
				0,
				1
			},
			{
				0,
				1,
				0,
				0,
				0,
				1,
				0
			},
			{
				0,
				0,
				1,
				0,
				1,
				0,
				0
			},
			{
				0,
				0,
				0,
				2,
				0,
				0,
				0
			},
			{
				0,
				0,
				1,
				0,
				1,
				0,
				0
			},
			{
				0,
				1,
				0,
				0,
				0,
				1,
				0
			},
			{
				1,
				0,
				0,
				0,
				0,
				0,
				1
			}
		}
	},
	{
		id = 14,
		list = {
			{
				0,
				0,
				0,
				2,
				0,
				0,
				0
			},
			{
				0,
				0,
				1,
				2,
				1,
				0,
				0
			},
			{
				0,
				1,
				0,
				1,
				0,
				1,
				0
			},
			{
				1,
				0,
				0,
				1,
				0,
				0,
				1
			},
			{
				0,
				0,
				0,
				1,
				0,
				0,
				0
			},
			{
				0,
				0,
				0,
				1,
				0,
				0,
				0
			}
		}
	},
	{
		id = 15,
		list = {
			{
				0,
				0,
				0,
				1,
				0,
				0
			},
			{
				0,
				0,
				0,
				0,
				1,
				0
			},
			{
				1,
				1,
				1,
				1,
				1,
				2
			},
			{
				0,
				0,
				0,
				0,
				1,
				0
			},
			{
				0,
				0,
				0,
				1,
				0,
				0
			}
		}
	},
	{
		id = 16,
		list = {
			{
				0,
				0,
				0,
				2,
				0,
				0,
				0
			},
			{
				0,
				0,
				0,
				1,
				0,
				0,
				0
			},
			{
				1,
				0,
				0,
				1,
				0,
				0,
				1
			},
			{
				0,
				1,
				0,
				1,
				0,
				1,
				0
			},
			{
				0,
				0,
				1,
				1,
				1,
				0,
				0
			},
			{
				0,
				0,
				0,
				2,
				0,
				0,
				0
			}
		}
	},
	{
		id = 17,
		list = {
			{
				0,
				0,
				1,
				0,
				0,
				0
			},
			{
				0,
				1,
				0,
				0,
				0,
				0
			},
			{
				2,
				1,
				1,
				1,
				1,
				0
			},
			{
				0,
				1,
				0,
				0,
				0,
				0
			},
			{
				0,
				0,
				1,
				0,
				0,
				0
			}
		}
	},
	{
		id = 18,
		list = {
			{
				1,
				0,
				0,
				0,
				1
			},
			{
				0,
				1,
				0,
				1,
				0
			},
			{
				0,
				1,
				1,
				1,
				0
			},
			{
				0,
				1,
				0,
				1,
				0
			},
			{
				1,
				0,
				0,
				0,
				1
			}
		}
	},
	{
		id = 19,
		list = {
			{
				1,
				1,
				1,
				1,
				1
			},
			{
				1,
				0,
				0,
				0,
				1
			},
			{
				1,
				0,
				2,
				0,
				1
			},
			{
				1,
				0,
				0,
				0,
				1
			},
			{
				1,
				1,
				1,
				1,
				1
			}
		}
	},
	{
		id = 20,
		list = {
			{
				1,
				1,
				1,
				1,
				1,
				1,
				1
			},
			{
				1,
				2,
				0,
				0,
				0,
				2,
				1
			},
			{
				1,
				0,
				1,
				0,
				1,
				0,
				1
			},
			{
				1,
				0,
				0,
				2,
				0,
				0,
				1
			},
			{
				1,
				0,
				1,
				0,
				1,
				0,
				1
			},
			{
				1,
				2,
				0,
				0,
				0,
				2,
				1
			},
			{
				1,
				1,
				1,
				1,
				1,
				1,
				1
			}
		}
	}
}
var_0_0.item_map_ids = {
	4,
	5,
	6,
	21
}
var_0_0.item_instance_data = {
	{
		id = 1,
		map = 1,
		weight = 1000
	},
	{
		id = 2,
		map = 2,
		weight = 1000
	},
	{
		id = 3,
		map = 3,
		weight = 1000
	},
	{
		id = 4,
		map = 4,
		weight = 900
	},
	{
		id = 5,
		map = 5,
		weight = 800
	},
	{
		id = 6,
		map = 6,
		weight = 800
	},
	{
		id = 7,
		map = 7,
		weight = 1000
	},
	{
		id = 8,
		map = 8,
		weight = 1000
	},
	{
		id = 9,
		map = 9,
		weight = 1000
	},
	{
		id = 10,
		map = 10,
		weight = 1000
	},
	{
		id = 11,
		map = 11,
		weight = 1000
	},
	{
		id = 12,
		map = 12,
		weight = 500
	},
	{
		id = 13,
		map = 13,
		weight = 1000
	},
	{
		id = 14,
		map = 14,
		weight = 1000
	},
	{
		id = 15,
		map = 15,
		weight = 1000
	},
	{
		id = 16,
		map = 16,
		weight = 1000
	},
	{
		id = 17,
		map = 17,
		weight = 1000
	},
	{
		id = 18,
		map = 18,
		weight = 1000
	},
	{
		id = 19,
		map = 19,
		weight = 1000
	},
	{
		id = 20,
		map = 20,
		weight = 1000
	},
	{
		id = 21,
		map = 21,
		weight = 1000
	}
}
var_0_0.follow_bound_mid = 300
var_0_0.follow_spring = 0.05
var_0_0.backgroud_data = {
	{
		rate = 0.05,
		name = "bgBottom"
	},
	{
		rate = 0.1,
		name = "bgFire"
	},
	{
		rate = 0.15,
		name = "bgMid"
	},
	{
		rate = 0.2,
		name = "bgTop"
	}
}
var_0_0.buff_weapon = 1
var_0_0.buff_speed = 2
var_0_0.buff_power_speed = 3
var_0_0.buff_catch = 4
var_0_0.buff_shield = 5
var_0_0.buff_data = {
	{
		id = 1,
		buff = var_0_0.buff_weapon
	},
	{
		id = 2,
		buff = var_0_0.buff_speed
	},
	{
		id = 3,
		lock_item = true,
		buff = var_0_0.buff_power_speed
	},
	{
		id = 4,
		buff = var_0_0.buff_catch
	},
	{
		id = 5,
		buff = var_0_0.buff_shield
	}
}
var_0_0.BG_TYPE_LOOP = 1
var_0_0.BG_TYPE_MID = 2
var_0_0.BG_TYPE_TOP = 3
var_0_0.BG_TYPE_FIRE = 4
var_0_0.BG_TYPE_PETAL = 5

local var_0_1 = {}
local var_0_2 = {
	name = "line",
	id = 1
}

Vector2 = var_3
var_0_2.bound = var_3(640, 420)
Vector2 = var_3
var_0_2.pos = var_3(0, -90)
var_0_2.type = var_0_0.BG_TYPE_LOOP
var_0_1[1] = var_0_2

local var_0_3 = {
	name = "bg",
	id = 2
}

Vector2 = var_3
var_0_3.bound = var_3(672, 420)
Vector2 = var_3
var_0_3.pos = var_3(0, -90)
var_0_3.type = var_0_0.BG_TYPE_LOOP
var_0_1[2] = var_0_3

local var_0_4 = {
	name = "bg_A",
	id = 3
}

Vector2 = var_3
var_0_4.bound = var_3(200, 420)
Vector2 = var_3
var_0_4.pos = var_3(0, -90)
var_0_4.type = var_0_0.BG_TYPE_MID
var_0_1[3] = var_0_4

local var_0_5 = {
	name = "bg_B",
	id = 4
}

Vector2 = var_3
var_0_5.bound = var_3(200, 420)
Vector2 = var_3
var_0_5.pos = var_3(0, -90)
var_0_5.type = var_0_0.BG_TYPE_MID
var_0_1[4] = var_0_5

local var_0_6 = {
	name = "bg_C",
	id = 5
}

Vector2 = var_3
var_0_6.bound = var_3(100, 420)
Vector2 = var_3
var_0_6.pos = var_3(0, -90)
var_0_6.type = var_0_0.BG_TYPE_MID
var_0_1[5] = var_0_6

local var_0_7 = {
	name = "bg_D",
	id = 6
}

Vector2 = var_3
var_0_7.bound = var_3(100, 420)
Vector2 = var_3
var_0_7.pos = var_3(0, -90)
var_0_7.type = var_0_0.BG_TYPE_MID
var_0_1[6] = var_0_7

local var_0_8 = {
	name = "bg_E",
	id = 7
}

Vector2 = var_3
var_0_8.bound = var_3(100, 420)
Vector2 = var_3
var_0_8.pos = var_3(0, -90)
var_0_8.type = var_0_0.BG_TYPE_MID
var_0_1[7] = var_0_8

local var_0_9 = {
	name = "bg_F",
	id = 8
}

Vector2 = var_3
var_0_9.bound = var_3(100, 420)
Vector2 = var_3
var_0_9.pos = var_3(0, -90)
var_0_9.type = var_0_0.BG_TYPE_MID
var_0_1[8] = var_0_9

local var_0_10 = {
	name = "bg_G",
	id = 9
}

Vector2 = var_3
var_0_10.bound = var_3(0, 420)
Vector2 = var_3
var_0_10.pos = var_3(0, 500)
var_0_10.type = var_0_0.BG_TYPE_MID
var_0_1[9] = var_0_10

local var_0_11 = {
	name = "bg_H",
	id = 10
}

Vector2 = var_3
var_0_11.bound = var_3(0, 420)
Vector2 = var_3
var_0_11.pos = var_3(0, 500)
var_0_11.type = var_0_0.BG_TYPE_MID
var_0_1[10] = var_0_11

local var_0_12 = {
	name = "BLD_Anshan",
	id = 11
}

Vector2 = var_3
var_0_12.bound = var_3(400, 420)
Vector2 = var_3
var_0_12.pos = var_3(0, -90)
var_0_12.type = var_0_0.BG_TYPE_TOP
var_0_1[11] = var_0_12

local var_0_13 = {
	name = "BLD_Niku",
	id = 12
}

Vector2 = var_3
var_0_13.bound = var_3(400, 420)
Vector2 = var_3
var_0_13.pos = var_3(0, -90)
var_0_13.type = var_0_0.BG_TYPE_TOP
var_0_1[12] = var_0_13

local var_0_14 = {
	name = "BLD_Shiratsuyu",
	id = 13
}

Vector2 = var_3
var_0_14.bound = var_3(400, 420)
Vector2 = var_3
var_0_14.pos = var_3(0, -90)
var_0_14.type = var_0_0.BG_TYPE_TOP
var_0_1[13] = var_0_14

local var_0_15 = {
	name = "BLD_Laffey_Ayanami",
	id = 14
}

Vector2 = var_3
var_0_15.bound = var_3(400, 420)
Vector2 = var_3
var_0_15.pos = var_3(0, -90)
var_0_15.type = var_0_0.BG_TYPE_TOP
var_0_1[14] = var_0_15

local var_0_16 = {
	name = "BLD_PingHai_NingHai",
	id = 15
}

Vector2 = var_3
var_0_16.bound = var_3(400, 420)
Vector2 = var_3
var_0_16.pos = var_3(0, -90)
var_0_16.type = var_0_0.BG_TYPE_TOP
var_0_1[15] = var_0_16

local var_0_17 = {
	name = "BLD_TaiYuan_ChangChun",
	id = 16
}

Vector2 = var_3
var_0_17.bound = var_3(400, 420)
Vector2 = var_3
var_0_17.pos = var_3(0, -90)
var_0_17.type = var_0_0.BG_TYPE_TOP
var_0_1[16] = var_0_17

local var_0_18 = {
	name = "Anchor",
	id = 17
}

Vector2 = var_3
var_0_18.bound = var_3(20, 0)
Vector2 = var_3
var_0_18.pos = var_3(0, 650)
var_0_18.type = var_0_0.BG_TYPE_FIRE
var_0_1[17] = var_0_18

local var_0_19 = {
	name = "LRG_B",
	id = 18
}

Vector2 = var_3
var_0_19.bound = var_3(20, 0)
Vector2 = var_3
var_0_19.pos = var_3(0, 650)
var_0_19.type = var_0_0.BG_TYPE_FIRE
var_0_1[18] = var_0_19

local var_0_20 = {
	name = "LRG_P",
	id = 19
}

Vector2 = var_3
var_0_20.bound = var_3(20, 0)
Vector2 = var_3
var_0_20.pos = var_3(0, 650)
var_0_20.type = var_0_0.BG_TYPE_FIRE
var_0_1[19] = var_0_20

local var_0_21 = {
	name = "LRG_Y",
	id = 20
}

Vector2 = var_3
var_0_21.bound = var_3(20, 0)
Vector2 = var_3
var_0_21.pos = var_3(0, 650)
var_0_21.type = var_0_0.BG_TYPE_FIRE
var_0_1[20] = var_0_21

local var_0_22 = {
	name = "Manjuu_L",
	id = 21
}

Vector2 = var_3
var_0_22.bound = var_3(20, 0)
Vector2 = var_3
var_0_22.pos = var_3(0, 650)
var_0_22.type = var_0_0.BG_TYPE_FIRE
var_0_1[21] = var_0_22

local var_0_23 = {
	name = "Manjuu_S",
	id = 22
}

Vector2 = var_3
var_0_23.bound = var_3(20, 0)
Vector2 = var_3
var_0_23.pos = var_3(0, 650)
var_0_23.type = var_0_0.BG_TYPE_FIRE
var_0_1[22] = var_0_23

local var_0_24 = {
	name = "Materials",
	id = 23
}

Vector2 = var_3
var_0_24.bound = var_3(20, 0)
Vector2 = var_3
var_0_24.pos = var_3(0, 650)
var_0_24.type = var_0_0.BG_TYPE_FIRE
var_0_1[23] = var_0_24

local var_0_25 = {
	name = "MID_B",
	id = 24
}

Vector2 = var_3
var_0_25.bound = var_3(20, 0)
Vector2 = var_3
var_0_25.pos = var_3(0, 650)
var_0_25.type = var_0_0.BG_TYPE_FIRE
var_0_1[24] = var_0_25

local var_0_26 = {
	name = "MID_P",
	id = 25
}

Vector2 = var_3
var_0_26.bound = var_3(20, 0)
Vector2 = var_3
var_0_26.pos = var_3(0, 650)
var_0_26.type = var_0_0.BG_TYPE_FIRE
var_0_1[25] = var_0_26

local var_0_27 = {
	name = "MID_Y",
	id = 26
}

Vector2 = var_3
var_0_27.bound = var_3(20, 0)
Vector2 = var_3
var_0_27.pos = var_3(0, 650)
var_0_27.type = var_0_0.BG_TYPE_FIRE
var_0_1[26] = var_0_27

local var_0_28 = {
	name = "Ofunya",
	id = 27
}

Vector2 = var_3
var_0_28.bound = var_3(20, 0)
Vector2 = var_3
var_0_28.pos = var_3(0, 650)
var_0_28.type = var_0_0.BG_TYPE_FIRE
var_0_1[27] = var_0_28

local var_0_29 = {
	name = "SML_B",
	id = 28
}

Vector2 = var_3
var_0_29.bound = var_3(20, 0)
Vector2 = var_3
var_0_29.pos = var_3(0, 650)
var_0_29.type = var_0_0.BG_TYPE_FIRE
var_0_1[28] = var_0_29

local var_0_30 = {
	name = "SML_P",
	id = 29
}

Vector2 = var_3
var_0_30.bound = var_3(20, 0)
Vector2 = var_3
var_0_30.pos = var_3(0, 650)
var_0_30.type = var_0_0.BG_TYPE_FIRE
var_0_1[29] = var_0_30

local var_0_31 = {
	name = "SML_Y",
	id = 30
}

Vector2 = var_3
var_0_31.bound = var_3(20, 0)
Vector2 = var_3
var_0_31.pos = var_3(0, 650)
var_0_31.type = var_0_0.BG_TYPE_FIRE
var_0_1[30] = var_0_31

local var_0_32 = {
	name = "U_chan",
	id = 31
}

Vector2 = var_3
var_0_32.bound = var_3(20, 0)
Vector2 = var_3
var_0_32.pos = var_3(0, 650)
var_0_32.type = var_0_0.BG_TYPE_FIRE
var_0_1[31] = var_0_32

local var_0_33 = {
	name = "Petal_A",
	id = 32
}

Vector2 = var_3
var_0_33.bound = var_3(20, 0)
Vector2 = var_3
var_0_33.pos = var_3(0, 650)
var_0_33.type = var_0_0.BG_TYPE_PETAL
var_0_1[32] = var_0_33

local var_0_34 = {
	name = "Petal_B",
	id = 33
}

Vector2 = var_3
var_0_34.bound = var_3(20, 0)
Vector2 = var_3
var_0_34.pos = var_3(0, 650)
var_0_34.type = var_0_0.BG_TYPE_PETAL
var_0_1[33] = var_0_34

local var_0_35 = {
	name = "Petal_C",
	id = 34
}

Vector2 = var_3
var_0_35.bound = var_3(20, 0)
Vector2 = var_3
var_0_35.pos = var_3(0, 650)
var_0_35.type = var_0_0.BG_TYPE_PETAL
var_0_1[34] = var_0_35
var_0_0.bg_data = var_0_1
var_0_0.loop_bg = {
	1,
	2
}
var_0_0.loop_nums = 3
var_0_0.top_bg = {
	11,
	12,
	13,
	14,
	15,
	16
}
var_0_0.mid_bg = {
	{
		num = 1,
		ids = {
			3,
			4
		}
	},
	{
		num = 3,
		ids = {
			5,
			6,
			7
		}
	},
	{
		num = 1,
		ids = {
			8
		}
	},
	{
		num = 2,
		ids = {
			5,
			6,
			7
		}
	},
	{
		mid_random = true,
		num = 1,
		ids = {
			9,
			10
		}
	}
}
var_0_0.mid_bg_inst_posX = 2500
var_0_0.fire_group = {
	{
		17
	},
	{
		18
	},
	{
		19
	},
	{
		20
	},
	{
		21
	},
	{
		22
	},
	{
		23
	},
	{
		24
	},
	{
		25
	},
	{
		26
	},
	{
		27
	},
	{
		28
	},
	{
		29
	},
	{
		30
	},
	{
		31
	}
}
var_0_0.fire_time = {
	0.1,
	1
}
var_0_0.fire_remove = 2
var_0_0.petal_ids = {
	32,
	33,
	34
}
var_0_0.petal_count_max = 30
var_0_0.peta_remove_time = {
	7,
	15
}
var_0_0.petal_speed = {
	-100,
	-50
}
var_0_0.petal_speed_offset = 25
var_0_0.petal_remove_y = 200
var_0_0.bg_remove_posX = -500
var_0_0.top_bg_inst_posX = 2500
var_0_0.monster_speed = {
	2,
	5
}
var_0_0.monster_score = 500
var_0_0.monster_data = {
	{
		id = 1,
		name = "monster"
	}
}
var_0_0.effect_data = {
	{
		parent = true,
		name = "EF_bk_Attack",
		trigger = "Attack"
	},
	{
		parent = true,
		name = "EF_bk_Attack_S",
		trigger = "Attack_S"
	},
	{
		parent = true,
		name = "EF_bk_Down",
		trigger = "Down"
	},
	{
		parent = false,
		name = "EF_bk_Jump",
		trigger = "Jump"
	},
	{
		parent = false,
		name = "EF_bk_Jump",
		trigger = "Jump_LA"
	},
	{
		parent = false,
		name = "EF_bk_Land",
		trigger = "Land"
	},
	{
		parent = false,
		name = "EF_bk_Land",
		trigger = "Land_LA"
	},
	{
		parent = false,
		name = "EF_fr_Land_S",
		trigger = "Land_S"
	},
	{
		parent = false,
		name = "EF_fr_Land_S",
		trigger = "Land_S_LA"
	},
	{
		parent = true,
		name = "EF_bk_Run",
		trigger = "Run"
	},
	{
		parent = true,
		name = "EF_bk_Run",
		trigger = "Run_LA"
	},
	{
		parent = true,
		name = "EF_bk_Run_S",
		trigger = "Run_S"
	},
	{
		parent = true,
		name = "EF_bk_Run_S",
		trigger = "Run_S_LA"
	},
	{
		parent = true,
		name = "EF_fr_Attack_LA",
		trigger = "Attack_LA"
	},
	{
		parent = true,
		name = "EF_fr_Attack_LA",
		trigger = "Attack_S_LA"
	},
	{
		parent = true,
		name = "EF_fr_EX_off",
		trigger = "EX_off"
	},
	{
		parent = true,
		name = "EF_fr_EX_on",
		trigger = "EX_on"
	},
	{
		parent = true,
		name = "EF_fr_Run_EX",
		trigger = "Run_EX"
	},
	{
		parent = true,
		name = "EF_fr_Attack"
	},
	{
		parent = false,
		name = "EF_fr_Hit_LA"
	},
	{
		parent = false,
		name = "EF_fr_Hit_LA"
	},
	{
		parent = false,
		name = "EF_fr_Get_Score_Item"
	},
	{
		parent = false,
		name = "EF_fr_Item"
	},
	{
		parent = true,
		name = "EF_Barrier_Get"
	},
	{
		parent = true,
		name = "EF_Barrier_Break"
	}
}

function var_0_0.CheckBoxCollider(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_0.x
	local var_1_1 = arg_1_0.y
	local var_1_2 = arg_1_2.x
	local var_1_3 = arg_1_2.y
	local var_1_4 = arg_1_1.x
	local var_1_5 = arg_1_1.y
	local var_1_6 = arg_1_3.x
	local var_1_7 = arg_1_3.y

	if var_1_4 <= var_1_0 and var_1_0 >= var_1_4 + var_1_6 then
		return false
	elseif var_1_0 <= var_1_4 and var_1_4 >= var_1_0 + var_1_2 then
		return false
	elseif var_1_5 <= var_1_1 and var_1_1 >= var_1_5 + var_1_7 then
		return false
	elseif var_1_1 <= var_1_5 and var_1_5 >= var_1_1 + var_1_3 then
		return false
	else
		return true
	end

	return
end

return var_0_0
