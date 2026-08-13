local var_0_0 = {
	id = 4000,
	map_id = 10005,
	bgm = "battle-maid"
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 300,
	backGroundStageID = 1,
	passCondition = 1,
	totalArea = {
		-70,
		20,
		90,
		70
	},
	playerArea = {
		-70,
		20,
		37,
		68
	},
	enemyArea = {}
}
local var_0_3 = {}
local var_0_4 = {}

Vector3 = var_0_10005
var_0_4[1] = var_0_10005(-105, 0, 58)
Vector3 = var_5
var_0_4[2] = var_5(-105, 0, 78)
Vector3 = var_5
var_0_4[3] = var_5(-105, 0, 38)
var_0_3[1] = var_0_4

local var_0_5 = {}

Vector3 = var_5
var_0_5[1] = var_5(15, 0, 58)
Vector3 = var_5
var_0_5[2] = var_5(15, 0, 78)
Vector3 = var_5
var_0_5[3] = var_5(15, 0, 38)
var_0_3[-1] = var_0_5
var_0_2.mainUnitPosition = var_0_3
var_0_2.fleetCorrdinate = {
	-80,
	0,
	75
}
var_0_2.waves = {
	{
		triggerType = 1,
		waveIndex = 100,
		preWaves = {},
		triggerParams = {
			timeout = 0.5
		}
	},
	{
		triggerType = 3,
		waveIndex = 200,
		preWaves = {
			100
		},
		triggerParams = {
			id = "FENGBAOQIANXI1"
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 101,
		conditionType = 1,
		preWaves = {
			200
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 12300022,
				delay = 0,
				moveCast = true,
				reinforceDelay = 5,
				corrdinate = {
					5,
					0,
					55
				},
				bossData = {
					hpBarNum = 30,
					icon = "xiefeierde"
				},
				buffList = {}
			}
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 102,
		conditionType = 1,
		preWaves = {
			101
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 12300023,
				delay = 0,
				moveCast = true,
				reinforceDelay = 5,
				corrdinate = {
					10,
					0,
					55
				},
				bossData = {
					hpBarNum = 30,
					icon = "huangjiafangzhou"
				},
				buffList = {}
			}
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 103,
		conditionType = 1,
		preWaves = {
			102
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 12300024,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				corrdinate = {
					5,
					0,
					55
				},
				bossData = {
					hpBarNum = 30,
					icon = "weiershi"
				}
			}
		}
	},
	{
		triggerType = 8,
		waveIndex = 900,
		preWaves = {
			103
		},
		triggerParams = {}
	},
	{
		triggerType = 3,
		key = true,
		waveIndex = 202,
		preWaves = {
			900
		},
		triggerParams = {
			id = "FENGBAOQIANXI10"
		}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {
	vanguard_unitList = {
		{
			oil_at_end = 55,
			configId = 900185,
			energy = 10,
			skinId = 900185,
			exp = 10,
			tmpID = 900185,
			id = 1,
			level = 120,
			equipment = {
				false,
				false,
				false
			},
			properties = {
				cannon = 1000,
				reload = 830,
				luck = 70,
				torpedo = 150,
				durability = 85567,
				air = 0,
				dodge = 164,
				antiaircraft = 310,
				speed = 31.5,
				armor = 98,
				hit = 140
			},
			skills = {
				{
					id = 9061,
					level = 1
				},
				{
					id = 9071,
					level = 1
				},
				{
					id = 20142,
					level = 1
				}
			}
		},
		{
			oil_at_end = 55,
			configId = 900186,
			energy = 10,
			skinId = 900186,
			exp = 10,
			tmpID = 900186,
			id = 2,
			level = 120,
			equipment = {
				false,
				false,
				false
			},
			properties = {
				cannon = 1000,
				reload = 830,
				luck = 70,
				torpedo = 150,
				durability = 85567,
				air = 0,
				dodge = 164,
				antiaircraft = 310,
				speed = 31.5,
				armor = 98,
				hit = 140
			},
			skills = {
				{
					id = 9081,
					level = 1
				},
				{
					id = 9071,
					level = 1
				},
				{
					id = 20142,
					level = 1
				}
			}
		}
	},
	main_unitList = {
		{
			configId = 900184,
			level = 120,
			skinId = 900184,
			id = 1,
			tmpID = 900184,
			equipment = {
				false,
				false,
				false
			},
			properties = {
				cannon = 200,
				reload = 83,
				luck = 38,
				torpedo = 0,
				durability = 66744,
				air = 0,
				dodge = 0,
				antiaircraft = 300,
				speed = 31,
				armor = 1150,
				hit = 140
			},
			skills = {
				{
					id = 9050,
					level = 1
				}
			}
		}
	}
}

return var_0_0
