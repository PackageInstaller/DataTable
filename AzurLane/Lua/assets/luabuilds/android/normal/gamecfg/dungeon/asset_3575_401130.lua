local var_0_0 = {
	map_id = 10001,
	id = 401130
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
			timeout = 8
		}
	},
	{
		triggerType = 1,
		waveIndex = 203,
		preWaves = {},
		triggerParams = {
			timeout = 28
		}
	},
	{
		triggerType = 1,
		waveIndex = 204,
		preWaves = {},
		triggerParams = {
			timeout = 39
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
				monsterTemplateID = 4003,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 4001,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					60
				}
			},
			{
				monsterTemplateID = 4000,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					50
				}
			},
			{
				monsterTemplateID = 4003,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					35
				},
				buffList = {
					8001,
					8007
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 4029,
				delay = 0,
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
				monsterTemplateID = 4029,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					25
				},
				buffList = {
					8001,
					8002
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
				monsterTemplateID = 4010,
				delay = 0,
				moveCast = true,
				corrdinate = {
					11,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 4010,
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
				monsterTemplateID = 4010,
				delay = 0,
				moveCast = true,
				corrdinate = {
					11,
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
		conditionType = 1,
		preWaves = {
			102,
			203
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 4004,
				delay = 0,
				moveCast = true,
				corrdinate = {
					11,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 4007,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					55
				},
				buffList = {
					8024,
					8025
				}
			},
			{
				monsterTemplateID = 4004,
				delay = 0,
				moveCast = true,
				corrdinate = {
					11,
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
		waveIndex = 104,
		conditionType = 0,
		preWaves = {
			103,
			102,
			101
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 4002,
				team = 1,
				delay = 0,
				moveCast = true,
				corrdinate = {
					22,
					0,
					80
				},
				buffList = {
					7026
				}
			},
			{
				monsterTemplateID = 4006,
				team = 1,
				delay = 0,
				moveCast = true,
				corrdinate = {
					11,
					0,
					55
				}
			},
			{
				monsterTemplateID = 4008,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				team = 1,
				corrdinate = {
					22,
					0,
					30
				},
				buffList = {
					8024,
					8025
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 4004,
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
				monsterTemplateID = 4004,
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
		triggerType = 8,
		waveIndex = 900,
		preWaves = {
			104
		},
		triggerParams = {}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
