local FushunAdventureGameConst = class("FushunAdventureGameConst")

FushunAdventureGameConst.BGM_NAME = "main-chunjie2"
FushunAdventureGameConst.GAME_BGM_NAME = "bgm-cccp3"
FushunAdventureGameConst.A_BTN_VOICE = "event:/ui/quanji"
FushunAdventureGameConst.B_BTN_VOICE = "event:/ui/tiji"
FushunAdventureGameConst.COUNT_DOWN_VOICE = "event:/ui/ddldaoshu2"
FushunAdventureGameConst.ENTER_EX_VOICE = "event:/ui/baoqi"
FushunAdventureGameConst.EX_TIP_TIME = 3
FushunAdventureGameConst.EX_TIME = 10
FushunAdventureGameConst.EX_CLICK_SCORE = 10
FushunAdventureGameConst.COMBO_SCORE_TARGET = 20
FushunAdventureGameConst.COMBO_EXTRA_SCORE = 5
FushunAdventureGameConst.LEVEL_CNT = 7
FushunAdventureGameConst.SHAKE_RANGE = 0.1
FushunAdventureGameConst.SHAKE_TIME = 0.05
FushunAdventureGameConst.SHAKE_LOOP_CNT = 2
FushunAdventureGameConst.FUSHUN_INIT_POSITION = Vector2(-655.7, -205)
FushunAdventureGameConst.FUSHUN_ATTACK_DISTANCE = 230
FushunAdventureGameConst.FUSHUN_ATTACK_RANGE = 300
FushunAdventureGameConst.ENEMY_SPAWN_POSITION = Vector2(1300, -351)
FushunAdventureGameConst.EX_ENEMY_SPAWN_TIME = 0.5
FushunAdventureGameConst.SPEED_ADDITION = {
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
FushunAdventureGameConst.PROPABILITES = {
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
FushunAdventureGameConst.ENEMY_SPAWN_TIME_ADDITION = {
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
FushunAdventureGameConst.ENEMYS = {
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

return FushunAdventureGameConst
