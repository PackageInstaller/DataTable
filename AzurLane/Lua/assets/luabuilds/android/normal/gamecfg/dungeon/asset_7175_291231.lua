local var_0_0 = {
	map_id = 10001,
	id = 291231
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 180,
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
		triggerType = 1,
		waveIndex = 202,
		preWaves = {},
		triggerParams = {
			timeout = 15
		}
	},
	{
		triggerType = 1,
		waveIndex = 203,
		preWaves = {},
		triggerParams = {
			timeout = 30
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 101,
		conditionType = 1,
		preWaves = {
			100
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 209101,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					80
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 292102,
				reinforceDelay = 6,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-10,
					0,
					55
				}
			},
			{
				monsterTemplateID = 209101,
				delay = 0,
				moveCast = true,
				corrdinate = {
					15,
					0,
					55
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 209101,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					30
				},
				buffList = {
					8001,
					8007
				}
			}
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 102,
		conditionType = 1,
		preWaves = {
			101,
			202
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 232007,
				reinforceDelay = 6,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					55
				},
				buffList = {
					8050,
					8051
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 209201,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-10,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 209201,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					55
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 209201,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-10,
					0,
					35
				},
				buffList = {
					8001,
					8007
				}
			}
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 103,
		conditionType = 0,
		preWaves = {
			102,
			101
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 292104,
				reinforceDelay = 6,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-10,
					0,
					65
				},
				buffList = {
					8050,
					8051
				}
			},
			{
				monsterTemplateID = 232005,
				reinforceDelay = 6,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-10,
					0,
					45
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 209101,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 209101,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					35
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
		waveIndex = 900,
		preWaves = {
			103
		},
		triggerParams = {}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
