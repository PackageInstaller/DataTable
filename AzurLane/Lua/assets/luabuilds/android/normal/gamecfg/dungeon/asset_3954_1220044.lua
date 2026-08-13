local var_0_0 = {
	id = 1170004,
	map_id = 10001,
	bgm = "ai-fb-inst"
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
			timeout = 20
		}
	},
	{
		triggerType = 1,
		waveIndex = 203,
		preWaves = {},
		triggerParams = {
			timeout = 40
		}
	},
	{
		triggerType = 0,
		waveIndex = 101,
		conditionType = 1,
		preWaves = {
			100
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 12100301,
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
				monsterTemplateID = 12100307,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					65
				}
			},
			{
				monsterTemplateID = 12100301,
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
		triggerType = 9,
		waveIndex = 204,
		preWaves = {
			101
		}
	},
	{
		triggerType = 0,
		waveIndex = 102,
		conditionType = 1,
		preWaves = {
			204,
			202
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 12100307,
				reinforceDelay = 7,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					55
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 12100301,
				delay = 0,
				moveCast = true,
				corrdinate = {
					20,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 12100306,
				delay = 0,
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
				monsterTemplateID = 12100301,
				delay = 0,
				moveCast = true,
				corrdinate = {
					20,
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
		waveIndex = 103,
		conditionType = 0,
		preWaves = {
			102,
			101
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 12100307,
				reinforceDelay = 7,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					65
				}
			},
			{
				monsterTemplateID = 12100308,
				reinforceDelay = 7,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					45
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 12100301,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					70
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 12100302,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					55
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 12100301,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					40
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
			103
		},
		triggerParams = {}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
