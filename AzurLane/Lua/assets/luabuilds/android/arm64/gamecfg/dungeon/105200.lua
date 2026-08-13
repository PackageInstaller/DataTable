local var_0_0 = {
	map_id = 10010,
	id = 105200
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
			timeout = 18
		}
	},
	{
		triggerType = 1,
		waveIndex = 203,
		preWaves = {},
		triggerParams = {
			timeout = 33
		}
	},
	{
		triggerType = 1,
		waveIndex = 204,
		preWaves = {},
		triggerParams = {
			timeout = 44
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
				monsterTemplateID = 1002,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 1003,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				corrdinate = {
					22,
					0,
					55
				}
			},
			{
				monsterTemplateID = 1002,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
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
		waveIndex = 102,
		conditionType = 1,
		preWaves = {
			101
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1029,
				delay = 0,
				moveCast = true,
				corrdinate = {
					2,
					0,
					80
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 1001,
				delay = 0,
				moveCast = true,
				corrdinate = {
					16,
					0,
					65
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 1001,
				delay = 0,
				moveCast = true,
				corrdinate = {
					16,
					0,
					45
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 1029,
				delay = 0,
				moveCast = true,
				corrdinate = {
					2,
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
		triggerType = 5,
		waveIndex = 400,
		preWaves = {
			101,
			102
		},
		triggerParams = {
			bgm = "battle-boss-1"
		}
	},
	{
		triggerType = 3,
		waveIndex = 500,
		preWaves = {
			101,
			102
		},
		triggerParams = {
			id = "T10201"
		}
	},
	{
		triggerType = 0,
		waveIndex = 103,
		conditionType = 0,
		preWaves = {
			500
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1009,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					55
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 105200,
				delay = 0,
				moveCast = true,
				reinforceDelay = 5,
				corrdinate = {
					22,
					0,
					55
				},
				bossData = {
					hpBarNum = 6,
					icon = "ligen"
				},
				buffList = {
					8015,
					8016
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 1001,
				delay = 0,
				moveCast = true,
				corrdinate = {
					25,
					0,
					80
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 1001,
				delay = 0,
				moveCast = true,
				corrdinate = {
					25,
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
			103
		},
		triggerParams = {}
	},
	{
		triggerType = 1,
		waveIndex = 205,
		preWaves = {
			103
		},
		triggerParams = {
			timeout = 1.5
		}
	},
	{
		triggerType = 3,
		key = true,
		waveIndex = 501,
		preWaves = {
			205
		},
		triggerParams = {
			id = "T10202"
		}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
