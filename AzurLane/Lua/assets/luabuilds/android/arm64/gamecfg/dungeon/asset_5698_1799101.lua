local var_0_0 = {
	id = 1799101
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 600,
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
			timeout = 0.1
		}
	},
	{
		triggerType = 3,
		waveIndex = 500,
		preWaves = {
			100
		},
		triggerParams = {
			id = "CONGLINGKAISHIMOWANG3-1"
		}
	},
	{
		triggerType = 3,
		waveIndex = 501,
		preWaves = {
			900
		},
		triggerParams = {
			id = "CONGLINGKAISHIMOWANG3-2"
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 101,
		conditionType = 0,
		preWaves = {
			500
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 16599501,
				delay = 0,
				corrdinate = {
					-8,
					0,
					50
				},
				buffList = {},
				bossData = {
					hpBarNum = 10,
					icon = ""
				}
			}
		}
	},
	{
		triggerType = 8,
		key = true,
		waveIndex = 900,
		preWaves = {
			101
		},
		triggerParams = {}
	},
	{
		triggerType = 8,
		key = true,
		waveIndex = 901,
		preWaves = {
			501
		},
		triggerParams = {}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {
	vanguard_unitList = {
		{
			oil_at_end = 10,
			configId = 900413,
			energy = 10,
			skinId = 900413,
			exp = 10,
			tmpID = 900413,
			id = 1,
			level = 1,
			equipment = {
				false,
				false,
				false
			},
			properties = {
				cannon = 30,
				reload = 200,
				dodge = 20,
				torpedo = 20,
				durability = 3000,
				air = 0,
				antiaircraft = 200,
				speed = 25,
				luck = 10,
				hit = 20
			},
			skills = {
				{
					id = 200830,
					level = 10
				}
			}
		}
	},
	main_unitList = {
		{
			configId = 900414,
			level = 1,
			skinId = 900414,
			id = 1,
			tmpID = 900414,
			equipment = {
				false,
				false,
				false
			},
			properties = {
				cannon = 25,
				reload = 300,
				dodge = 5,
				torpedo = 0,
				durability = 2000,
				air = 40,
				antiaircraft = 0,
				speed = 1,
				luck = 10,
				hit = 25
			},
			skills = {
				{
					id = 200831,
					level = 10
				}
			}
		},
		{
			configId = 900415,
			level = 1,
			skinId = 900415,
			id = 2,
			tmpID = 900415,
			equipment = {
				false,
				false,
				false
			},
			properties = {
				cannon = 20,
				reload = 300,
				dodge = 5,
				torpedo = 0,
				durability = 1500,
				air = 30,
				antiaircraft = 0,
				speed = 1,
				luck = 20,
				hit = 20
			},
			skills = {
				{
					id = 200832,
					level = 10
				}
			}
		}
	}
}

return var_0_0
