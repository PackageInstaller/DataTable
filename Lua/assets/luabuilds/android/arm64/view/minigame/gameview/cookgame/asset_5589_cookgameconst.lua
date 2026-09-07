local CookGameConst = class("CookGameConst")

CookGameConst.sound_marcopolo_skill = "ui-mini_shine"
CookGameConst.sound_serve = "ui-mini_click"
CookGameConst.sound_pickup = ""
CookGameConst.sound_ac = "ui-mini_throw"
CookGameConst.sound_speed_up = "ui-mini_up"
CookGameConst.cook_game_Albacore = "cook_game_Albacore"
CookGameConst.cook_game_august = "cook_game_august"
CookGameConst.cook_game_elbe = "cook_game_elbe"
CookGameConst.cook_game_hakuryu = "cook_game_hakuryu"
CookGameConst.cook_game_howe = "cook_game_howe"
CookGameConst.cook_game_marcopolo = "cook_game_marcopolo"
CookGameConst.cook_game_noshiro = "cook_game_noshiro"
CookGameConst.cook_game_pnelope = "cook_game_pnelope"
CookGameConst.cook_game_laffey = "cook_game_laffey"
CookGameConst.cook_game_janus = "cook_game_janus"
CookGameConst.cook_game_flandre = "cook_game_flandre"
CookGameConst.cook_game_constellation = "cook_game_constellation"
CookGameConst.cook_game_constellation_skill_name = "cook_game_constellation_skill_name"
CookGameConst.cook_game_constellation_skill_desc = "cook_game_constellation_skill_desc"
CookGameConst.char_ids = {
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
CookGameConst.random_ids = {
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

if PLATFORM_CODE == PLATFORM_CHT then
	CookGameConst.char_ids = {
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
	CookGameConst.random_ids = {
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

CookGameConst.camp_player = 1
CookGameConst.camp_enemy = 2
CookGameConst.player_use_ai = false
CookGameConst.ac_dictance = 200
CookGameConst.added_max = 3
CookGameConst.random_score = 3
CookGameConst.puzzle_rate = 25
CookGameConst.puzzle_time = 7
CookGameConst.char_data = {
	{
		id = 1,
		icon = "Albacore",
		ship_id = 108021,
		pos = Vector2(0, 0),
		desc = CookGameConst.cook_game_Albacore
	},
	{
		id = 2,
		icon = "august",
		ship_id = 900921,
		pos = Vector2(0, -30),
		desc = CookGameConst.cook_game_august
	},
	{
		id = 3,
		icon = "elbe",
		ship_id = 406021,
		pos = Vector2(0, 0),
		desc = CookGameConst.cook_game_elbe
	},
	{
		id = 4,
		icon = "hakuryu",
		ship_id = 900919,
		pos = Vector2(0, 0),
		desc = CookGameConst.cook_game_hakuryu
	},
	{
		id = 5,
		icon = "howe",
		ship_id = 205091,
		pos = Vector2(0, 0),
		desc = CookGameConst.cook_game_howe
	},
	{
		id = 6,
		icon = "marcopolo",
		ship_id = 900922,
		pos = Vector2(0, 0),
		desc = CookGameConst.cook_game_marcopolo
	},
	{
		id = 7,
		icon = "noshiro",
		ship_id = 302211,
		pos = Vector2(0, 0),
		desc = CookGameConst.cook_game_noshiro
	},
	{
		id = 8,
		icon = "pnelope",
		ship_id = 202291,
		pos = Vector2(0, 0),
		desc = CookGameConst.cook_game_pnelope
	},
	{
		id = 9,
		icon = "Laffey",
		ship_id = 101511,
		pos = Vector2(0, 0),
		desc = CookGameConst.cook_game_laffey
	},
	{
		id = 10,
		icon = "Janus",
		ship_id = 201351,
		pos = Vector2(0, 0),
		desc = CookGameConst.cook_game_janus
	},
	{
		id = 11,
		icon = "Flandre",
		ship_id = 900398,
		pos = Vector2(0, 0),
		desc = CookGameConst.cook_game_flandre
	},
	{
		id = 12,
		icon = "constellation",
		ship_id = 104011,
		pos = Vector2(0, 0),
		desc = CookGameConst.cook_game_constellation,
		detail_name = CookGameConst.cook_game_constellation_skill_name,
		detail_desc = CookGameConst.cook_game_constellation_skill_desc
	},
	{
		id = 13,
		icon = "manjuu",
		ship_id = 900398,
		pos = Vector2(0, 0)
	}
}
CookGameConst.player_char = "playerChar"
CookGameConst.parter_char = "parterchar"
CookGameConst.parter_pet = "parter_pet"
CookGameConst.enemy1_char = "enemy1Char"
CookGameConst.enemy2_char = "enemy2Char"
CookGameConst.enemy_pet = "enemy_pet"
CookGameConst.char_instiate_data = {
	[CookGameConst.player_char] = {
		parent = "scene",
		bound = "playerBox/collider",
		tf_name = CookGameConst.player_char,
		init_pos = Vector2(-500, 0)
	},
	[CookGameConst.parter_char] = {
		parent = "scene",
		bound = "playerBox/collider",
		tf_name = CookGameConst.parter_char,
		init_pos = Vector2(-300, -300)
	},
	[CookGameConst.parter_pet] = {
		parent = "scene",
		bound = "playerBox/collider",
		tf_name = CookGameConst.parter_pet,
		init_pos = Vector2(-400, -400)
	},
	[CookGameConst.enemy1_char] = {
		parent = "scene",
		bound = "enemyBox/collider",
		tf_name = CookGameConst.enemy1_char,
		init_pos = Vector2(500, 10)
	},
	[CookGameConst.enemy2_char] = {
		parent = "scene",
		bound = "enemyBox/collider",
		tf_name = CookGameConst.enemy2_char,
		init_pos = Vector2(300, -310)
	},
	[CookGameConst.enemy_pet] = {
		parent = "scene",
		bound = "enemyBox/collider",
		tf_name = CookGameConst.enemy_pet,
		init_pos = Vector2(400, -410)
	}
}
CookGameConst.char_battle_data = {
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
	},
	{
		base_speed = 240,
		name = "manjuu",
		speed_able = false,
		double_able = false,
		id = 101,
		ac_able = false,
		offset = Vector2(0, 90)
	}
}
CookGameConst.judge_num = 4
CookGameConst.judge_data = {
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

return CookGameConst
