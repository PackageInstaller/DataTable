local var_0_0 = {
	map_id = 10005,
	id = 3001
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 80,
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
				monsterTemplateID = 711,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					75
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					60
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 2,
				moveCast = true,
				corrdinate = {
					30,
					0,
					50
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 2,
				moveCast = true,
				corrdinate = {
					30,
					0,
					35
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 4,
				moveCast = true,
				corrdinate = {
					30,
					0,
					80
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 4,
				moveCast = true,
				corrdinate = {
					30,
					0,
					65
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 4,
				moveCast = true,
				corrdinate = {
					30,
					0,
					50
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 6,
				moveCast = true,
				corrdinate = {
					21,
					0,
					65
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 6,
				moveCast = true,
				corrdinate = {
					21,
					0,
					50
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 6,
				moveCast = true,
				corrdinate = {
					21,
					0,
					35
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 8,
				moveCast = true,
				corrdinate = {
					29,
					0,
					75
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 8,
				moveCast = true,
				corrdinate = {
					29,
					0,
					55
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 10,
				moveCast = true,
				corrdinate = {
					29,
					0,
					60
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 12,
				moveCast = true,
				corrdinate = {
					30,
					0,
					70
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 12,
				moveCast = true,
				corrdinate = {
					30,
					0,
					60
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 14,
				moveCast = true,
				corrdinate = {
					30,
					0,
					50
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 14,
				moveCast = true,
				corrdinate = {
					30,
					0,
					30
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 16,
				moveCast = true,
				corrdinate = {
					22,
					0,
					60
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 16,
				moveCast = true,
				corrdinate = {
					30,
					0,
					50
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 18,
				moveCast = true,
				corrdinate = {
					30,
					0,
					60
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 18,
				moveCast = true,
				corrdinate = {
					30,
					0,
					50
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 20,
				moveCast = true,
				corrdinate = {
					30,
					0,
					75
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 20,
				moveCast = true,
				corrdinate = {
					30,
					0,
					60
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 22,
				moveCast = true,
				corrdinate = {
					30,
					0,
					50
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 22,
				moveCast = true,
				corrdinate = {
					30,
					0,
					35
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 24,
				moveCast = true,
				corrdinate = {
					30,
					0,
					80
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 24,
				moveCast = true,
				corrdinate = {
					30,
					0,
					65
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 24,
				moveCast = true,
				corrdinate = {
					30,
					0,
					50
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 26,
				moveCast = true,
				corrdinate = {
					30,
					0,
					50
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 26,
				moveCast = true,
				corrdinate = {
					30,
					0,
					35
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 28,
				moveCast = true,
				corrdinate = {
					30,
					0,
					75
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 28,
				moveCast = true,
				corrdinate = {
					30,
					0,
					55
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 30,
				moveCast = true,
				corrdinate = {
					30,
					0,
					60
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 30,
				moveCast = true,
				corrdinate = {
					30,
					0,
					40
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 32,
				moveCast = true,
				corrdinate = {
					30,
					0,
					80
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 32,
				moveCast = true,
				corrdinate = {
					30,
					0,
					70
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 34,
				moveCast = true,
				corrdinate = {
					30,
					0,
					40
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 34,
				moveCast = true,
				corrdinate = {
					30,
					0,
					30
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 36,
				moveCast = true,
				corrdinate = {
					22,
					0,
					60
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 36,
				moveCast = true,
				corrdinate = {
					30,
					0,
					40
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 38,
				moveCast = true,
				corrdinate = {
					30,
					0,
					75
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 38,
				moveCast = true,
				corrdinate = {
					30,
					0,
					60
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 38,
				moveCast = true,
				corrdinate = {
					30,
					0,
					50
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 41,
				moveCast = true,
				corrdinate = {
					30,
					0,
					75
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 41,
				moveCast = true,
				corrdinate = {
					30,
					0,
					65
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 44,
				moveCast = true,
				corrdinate = {
					30,
					0,
					55
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 44,
				moveCast = true,
				corrdinate = {
					30,
					0,
					35
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 47,
				moveCast = true,
				corrdinate = {
					30,
					0,
					80
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 47,
				moveCast = true,
				corrdinate = {
					30,
					0,
					50
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 50,
				moveCast = true,
				corrdinate = {
					30,
					0,
					65
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 50,
				moveCast = true,
				corrdinate = {
					30,
					0,
					50
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 50,
				moveCast = true,
				corrdinate = {
					30,
					0,
					35
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 53,
				moveCast = true,
				corrdinate = {
					30,
					0,
					75
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 53,
				moveCast = true,
				corrdinate = {
					30,
					0,
					55
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 56,
				moveCast = true,
				corrdinate = {
					30,
					0,
					60
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 56,
				moveCast = true,
				corrdinate = {
					30,
					0,
					40
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 58,
				moveCast = true,
				corrdinate = {
					30,
					0,
					80
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 58,
				moveCast = true,
				corrdinate = {
					30,
					0,
					70
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 60,
				moveCast = true,
				corrdinate = {
					30,
					0,
					50
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 60,
				moveCast = true,
				corrdinate = {
					30,
					0,
					40
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 62,
				moveCast = true,
				corrdinate = {
					30,
					0,
					50
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 62,
				moveCast = true,
				corrdinate = {
					30,
					0,
					40
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 64,
				moveCast = true,
				corrdinate = {
					30,
					0,
					80
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 64,
				moveCast = true,
				corrdinate = {
					30,
					0,
					30
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 66,
				moveCast = true,
				corrdinate = {
					30,
					0,
					65
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 711,
				delay = 66,
				moveCast = true,
				corrdinate = {
					30,
					0,
					45
				},
				buffList = {
					8001,
					8002
				}
			}
		}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
