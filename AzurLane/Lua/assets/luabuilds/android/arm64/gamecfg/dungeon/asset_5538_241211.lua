local var_0_0 = {
	map_id = 10001,
	id = 241211
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
		triggerType = 1,
		waveIndex = 204,
		preWaves = {},
		triggerParams = {
			timeout = 50
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
				monsterTemplateID = 204210,
				score = 0,
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
				monsterTemplateID = 204210,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-5,
					0,
					55
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 242106,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					60
				},
				buffList = {
					8050,
					8051
				}
			},
			{
				monsterTemplateID = 242002,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					40
				}
			},
			{
				monsterTemplateID = 204210,
				score = 0,
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
				monsterTemplateID = 204209,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 204209,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					35
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 242114,
				score = 0,
				delay = 0,
				moveCast = true,
				reinforceDelay = 10,
				corrdinate = {
					-5,
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
				monsterTemplateID = 209502,
				score = 0,
				delay = 0,
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
				monsterTemplateID = 209502,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					50
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 209502,
				score = 0,
				delay = 0,
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
				monsterTemplateID = 242112,
				score = 0,
				delay = 0,
				moveCast = true,
				reinforceDelay = 6,
				corrdinate = {
					10,
					0,
					55
				},
				buffList = {
					8050,
					8051
				}
			},
			{
				monsterTemplateID = 242008,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
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
				monsterTemplateID = 204211,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-5,
					0,
					70
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 209502,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					35,
					0,
					55
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 204211,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-5,
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
