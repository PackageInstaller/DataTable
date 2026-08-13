class = var_0_10000

local var_0_0 = var_0_10000("CookGameConst")

var_0_0.sound_marcopolo_skill = "ui-mini_shine"
var_0_0.sound_serve = "ui-mini_click"
var_0_0.sound_pickup = ""
var_0_0.sound_ac = "ui-mini_throw"
var_0_0.sound_speed_up = "ui-mini_up"
var_0_0.cook_game_Albacore = "cook_game_Albacore"
var_0_0.cook_game_august = "cook_game_august"
var_0_0.cook_game_elbe = "cook_game_elbe"
var_0_0.cook_game_hakuryu = "cook_game_hakuryu"
var_0_0.cook_game_howe = "cook_game_howe"
var_0_0.cook_game_marcopolo = "cook_game_marcopolo"
var_0_0.cook_game_noshiro = "cook_game_noshiro"
var_0_0.cook_game_pnelope = "cook_game_pnelope"
var_0_0.cook_game_laffey = "cook_game_laffey"
var_0_0.cook_game_janus = "cook_game_janus"
var_0_0.cook_game_flandre = "cook_game_flandre"
var_0_0.cook_game_constellation = "cook_game_constellation"
var_0_0.cook_game_constellation_skill_name = "cook_game_constellation_skill_name"
var_0_0.cook_game_constellation_skill_desc = "cook_game_constellation_skill_desc"
var_0_0.char_ids = {
	9,
	10,
	12,
	11,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8
}
var_0_0.random_ids = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12
}
PLATFORM_CODE = var_1
PLATFORM_CHT = var_0_10002

if var_1 == var_0_10002 then
	var_0_0.char_ids = {
		1,
		2,
		4,
		5,
		6,
		7,
		8,
		9,
		10,
		11,
		12
	}
	var_0_0.random_ids = {
		1,
		2,
		4,
		5,
		6,
		7,
		8,
		9,
		10,
		11,
		12
	}
end

var_0_0.camp_player = 1
var_0_0.camp_enemy = 2
var_0_0.player_use_ai = false
var_0_0.ac_dictance = 200
var_0_0.added_max = 3
var_0_0.random_score = 3
var_0_0.puzzle_rate = 25
var_0_0.puzzle_time = 7

local var_0_1 = {}
local var_0_2 = {
	id = 1,
	icon = "Albacore",
	ship_id = 108021
}

Vector2 = var_0_10003
var_0_2.pos = var_0_10003(0, 0)
var_0_2.desc = var_0_0.cook_game_Albacore
var_0_1[1] = var_0_2

local var_0_3 = {
	id = 2,
	icon = "august",
	ship_id = 900921
}

Vector2 = var_3
var_0_3.pos = var_3(0, -30)
var_0_3.desc = var_0_0.cook_game_august
var_0_1[2] = var_0_3

local var_0_4 = {
	id = 3,
	icon = "elbe",
	ship_id = 406021
}

Vector2 = var_3
var_0_4.pos = var_3(0, 0)
var_0_4.desc = var_0_0.cook_game_elbe
var_0_1[3] = var_0_4

local var_0_5 = {
	id = 4,
	icon = "hakuryu",
	ship_id = 900919
}

Vector2 = var_3
var_0_5.pos = var_3(0, 0)
var_0_5.desc = var_0_0.cook_game_hakuryu
var_0_1[4] = var_0_5

local var_0_6 = {
	id = 5,
	icon = "howe",
	ship_id = 205091
}

Vector2 = var_3
var_0_6.pos = var_3(0, 0)
var_0_6.desc = var_0_0.cook_game_howe
var_0_1[5] = var_0_6

local var_0_7 = {
	id = 6,
	icon = "marcopolo",
	ship_id = 900922
}

Vector2 = var_3
var_0_7.pos = var_3(0, 0)
var_0_7.desc = var_0_0.cook_game_marcopolo
var_0_1[6] = var_0_7

local var_0_8 = {
	id = 7,
	icon = "noshiro",
	ship_id = 302211
}

Vector2 = var_3
var_0_8.pos = var_3(0, 0)
var_0_8.desc = var_0_0.cook_game_noshiro
var_0_1[7] = var_0_8

local var_0_9 = {
	id = 8,
	icon = "pnelope",
	ship_id = 202291
}

Vector2 = var_3
var_0_9.pos = var_3(0, 0)
var_0_9.desc = var_0_0.cook_game_pnelope
var_0_1[8] = var_0_9

local var_0_10 = {
	id = 9,
	icon = "Laffey",
	ship_id = 101511
}

Vector2 = var_3
var_0_10.pos = var_3(0, 0)
var_0_10.desc = var_0_0.cook_game_laffey
var_0_1[9] = var_0_10

local var_0_11 = {
	id = 10,
	icon = "Janus",
	ship_id = 201351
}

Vector2 = var_3
var_0_11.pos = var_3(0, 0)
var_0_11.desc = var_0_0.cook_game_janus
var_0_1[10] = var_0_11

local var_0_12 = {
	id = 11,
	icon = "Flandre",
	ship_id = 900398
}

Vector2 = var_3
var_0_12.pos = var_3(0, 0)
var_0_12.desc = var_0_0.cook_game_flandre
var_0_1[11] = var_0_12

local var_0_13 = {
	id = 12,
	icon = "constellation",
	ship_id = 104011
}

Vector2 = var_3
var_0_13.pos = var_3(0, 0)
var_0_13.desc = var_0_0.cook_game_constellation
var_0_13.detail_name = var_0_0.cook_game_constellation_skill_name
var_0_13.detail_desc = var_0_0.cook_game_constellation_skill_desc
var_0_1[12] = var_0_13

local var_0_14 = {
	id = 13,
	icon = "manjuu",
	ship_id = 900398
}

Vector2 = var_3
var_0_14.pos = var_3(0, 0)
var_0_1[13] = var_0_14
var_0_0.char_data = var_0_1
var_0_0.player_char = "playerChar"
var_0_0.parter_char = "parterchar"
var_0_0.parter_pet = "parter_pet"
var_0_0.enemy1_char = "enemy1Char"
var_0_0.enemy2_char = "enemy2Char"
var_0_0.enemy_pet = "enemy_pet"

local var_0_15 = {}
local var_0_16 = var_0_0.player_char
local var_0_17 = {
	parent = "scene",
	bound = "playerBox/collider",
	tf_name = var_0_0.player_char
}

Vector2 = var_4
var_0_17.init_pos = var_4(-500, 0)
var_0_15[var_0_16] = var_0_17

local var_0_18 = var_0_0.parter_char
local var_0_19 = {
	parent = "scene",
	bound = "playerBox/collider",
	tf_name = var_0_0.parter_char
}

Vector2 = var_4
var_0_19.init_pos = var_4(-300, -300)
var_0_15[var_0_18] = var_0_19

local var_0_20 = var_0_0.parter_pet
local var_0_21 = {
	parent = "scene",
	bound = "playerBox/collider",
	tf_name = var_0_0.parter_pet
}

Vector2 = var_4
var_0_21.init_pos = var_4(-400, -400)
var_0_15[var_0_20] = var_0_21

local var_0_22 = var_0_0.enemy1_char
local var_0_23 = {
	parent = "scene",
	bound = "enemyBox/collider",
	tf_name = var_0_0.enemy1_char
}

Vector2 = var_4
var_0_23.init_pos = var_4(500, 10)
var_0_15[var_0_22] = var_0_23

local var_0_24 = var_0_0.enemy2_char
local var_0_25 = {
	parent = "scene",
	bound = "enemyBox/collider",
	tf_name = var_0_0.enemy2_char
}

Vector2 = var_4
var_0_25.init_pos = var_4(300, -310)
var_0_15[var_0_24] = var_0_25

local var_0_26 = var_0_0.enemy_pet
local var_0_27 = {
	parent = "scene",
	bound = "enemyBox/collider",
	tf_name = var_0_0.enemy_pet
}

Vector2 = var_4
var_0_27.init_pos = var_4(400, -410)
var_0_15[var_0_26] = var_0_27
var_0_0.char_instiate_data = var_0_15

local var_0_28 = {
	{
		base_speed = 210,
		name = "Albacore",
		speed_able = false,
		double_able = false,
		id = 1,
		ac_able = true
	},
	{
		base_speed = 300,
		name = "august",
		speed_able = false,
		double_able = false,
		id = 2,
		ac_able = false
	},
	{
		base_speed = 240,
		name = "elbe",
		speed_able = false,
		double_able = true,
		id = 3,
		ac_able = false
	},
	{
		base_speed = 240,
		name = "hakuryu",
		speed_able = true,
		double_able = false,
		id = 4,
		speed_max = 3,
		ac_able = false
	},
	{
		base_speed = 240,
		name = "howe",
		speed_able = false,
		double_able = false,
		id = 5,
		half_double = true,
		ac_able = false
	},
	{
		extend = true,
		name = "marcopolo",
		speed_able = false,
		double_able = false,
		id = 6,
		base_speed = 240,
		ac_able = false
	},
	{
		base_speed = 240,
		name = "noshiro",
		speed_able = false,
		double_able = false,
		id = 7,
		cake_allow = true,
		ac_able = false,
		weight = 1
	},
	{
		base_speed = 240,
		name = "pnelope",
		speed_able = false,
		double_able = false,
		id = 8,
		double_score = true,
		ac_able = false
	},
	{
		score_added = true,
		name = "Laffey",
		speed_able = false,
		double_able = false,
		id = 9,
		base_speed = 240,
		ac_able = false,
		effect = {
			"EF_Right_X",
			"EF_Right_Y",
			"EF_Right_Z"
		}
	},
	{
		base_speed = 240,
		name = "Janus",
		speed_able = false,
		double_able = false,
		id = 10,
		random_score = true,
		ac_able = false
	},
	{
		base_speed = 240,
		name = "Flandre",
		speed_able = false,
		double_able = false,
		id = 11,
		pet = 101,
		ac_able = false
	},
	{
		name = "constellation",
		speed_able = false,
		double_able = false,
		weight = 2,
		ac_able = false,
		base_speed = 240,
		id = 12,
		puzzle = true,
		effect = {
			"EF_Skill"
		}
	}
}
local var_0_29 = {
	base_speed = 240,
	name = "manjuu",
	speed_able = false,
	double_able = false,
	id = 101,
	ac_able = false
}

Vector2 = var_3
var_0_29.offset = var_3(0, 90)
var_0_28[13] = var_0_29
var_0_0.char_battle_data = var_0_28
var_0_0.judge_num = 4
var_0_0.judge_data = {
	{
		id = 1,
		name = "judges_1",
		cake_id = 1
	},
	{
		id = 2,
		name = "judges_2",
		cake_id = 2
	},
	{
		id = 3,
		name = "judges_3",
		cake_id = 3
	},
	{
		id = 4,
		name = "judges_4",
		cake_id = 4
	},
	{
		id = 5,
		name = "judges_5",
		cake_id = 5
	}
}

return var_0_0
