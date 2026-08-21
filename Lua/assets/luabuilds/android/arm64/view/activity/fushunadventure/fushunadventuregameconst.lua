local var_0_0 = class("FushunAdventureGameConst")

var_0_0.BGM_NAME = "main-chunjie2"
var_0_0.GAME_BGM_NAME = "bgm-cccp3"
var_0_0.A_BTN_VOICE = "event:/ui/quanji"
var_0_0.B_BTN_VOICE = "event:/ui/tiji"
var_0_0.COUNT_DOWN_VOICE = "event:/ui/ddldaoshu2"
var_0_0.ENTER_EX_VOICE = "event:/ui/baoqi"
var_0_0.EX_TIP_TIME = 3
var_0_0.EX_TIME = 10
var_0_0.EX_CLICK_SCORE = 10
var_0_0.COMBO_SCORE_TARGET = 20
var_0_0.COMBO_EXTRA_SCORE = 5
var_0_0.LEVEL_CNT = 7
var_0_0.SHAKE_RANGE = 0.1
var_0_0.SHAKE_TIME = 0.05
var_0_0.SHAKE_LOOP_CNT = 2
var_0_0.FUSHUN_INIT_POSITION = Vector2(-655.7, -205)
var_0_0.FUSHUN_ATTACK_DISTANCE = 230
var_0_0.FUSHUN_ATTACK_RANGE = 300
var_0_0.ENEMY_SPAWN_POSITION = Vector2(1300, -351)
var_0_0.EX_ENEMY_SPAWN_TIME = 0.5
var_0_0.SPEED_ADDITION = {
	{
		{
			0,
			1000
		},
		2.5
	},
	{
		{
			1001,
			3000
		},
		3
	},
	{
		{
			3001,
			6000
		},
		3.2
	},
	{
		{
			6001,
			8000
		},
		3.4
	}
}
var_0_0.PROPABILITES = {
	{
		{
			0,
			1000
		},
		60,
		20,
		20
	},
	{
		{
			1001,
			3000
		},
		50,
		30,
		20
	},
	{
		{
			3001,
			5000
		},
		40,
		40,
		20
	},
	{
		{
			5001,
			8000
		},
		20,
		50,
		30
	}
}
var_0_0.ENEMY_SPAWN_TIME_ADDITION = {
	{
		{
			0,
			1000
		},
		{
			2.2,
			2.6
		}
	},
	{
		{
			1001,
			3000
		},
		{
			1.8,
			2.2
		}
	},
	{
		{
			3001,
			5000
		},
		{
			1.5,
			1.8
		}
	},
	{
		{
			5001,
			8000
		},
		{
			1,
			1.6
		}
	}
}
var_0_0.ENEMYS = {
	{
		crazy_speed = 14,
		name = "beast01",
		hp = 1,
		speed = 3,
		id = 1,
		score = 10,
		attackDistance = 150,
		energyScore = 3
	},
	{
		crazy_speed = 13,
		name = "beast02",
		hp = 2,
		speed = 3,
		id = 2,
		score = 20,
		attackDistance = 150,
		energyScore = 5
	},
	{
		crazy_speed = 12,
		name = "beast03",
		hp = 3,
		speed = 3,
		id = 3,
		score = 30,
		attackDistance = 150,
		energyScore = 8
	}
}

return var_0_0
