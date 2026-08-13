local var_0_0 = {
	id = 1221201,
	bgm = "story-4"
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 300,
	backGroundStageID = 1,
	passCondition = 1,
	totalArea = {
		-75,
		20,
		90,
		70
	},
	playerArea = {
		-75,
		20,
		42,
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
		waveIndex = 500,
		preWaves = {
			100
		},
		triggerParams = {
			id = "HUANGJINDEMIBAO2"
		}
	},
	{
		triggerType = 0,
		waveIndex = 201,
		conditionType = 1,
		preWaves = {
			500,
			100
		},
		triggerParams = {},
		spawn = {
			{
				monsterTemplateID = 13400001,
				score = 0,
				delay = 1,
				moveCast = true,
				reinforceDelay = 8,
				corrdinate = {
					-10,
					0,
					55
				},
				buffList = {},
				bossData = {
					hpBarNum = 100,
					icon = "buli"
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 13400002,
				score = 0,
				delay = 2,
				moveCast = true,
				corrdinate = {
					30,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 13400002,
				score = 0,
				delay = 2,
				moveCast = true,
				corrdinate = {
					5,
					0,
					55
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 13400002,
				score = 0,
				delay = 2,
				moveCast = true,
				corrdinate = {
					30,
					0,
					35
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 13400002,
				score = 0,
				delay = 2,
				moveCast = true,
				corrdinate = {
					18,
					0,
					65
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 13400002,
				score = 0,
				delay = 2,
				moveCast = true,
				corrdinate = {
					18,
					0,
					45
				},
				buffList = {
					8001,
					8007
				}
			}
		}
	},
	{
		triggerType = 8,
		key = true,
		waveIndex = 900,
		preWaves = {
			201
		},
		triggerParams = {}
	},
	{
		triggerType = 3,
		key = true,
		waveIndex = 501,
		preWaves = {
			900
		},
		triggerParams = {
			id = "HUANGJINDEMIBAO3"
		}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {
	vanguard_unitList = {
		{
			oil_at_end = 55,
			configId = 900235,
			energy = 10,
			skinId = 900235,
			exp = 10,
			tmpID = 900235,
			id = 1,
			level = 100,
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
			}
		}
	}
}

return var_0_0
