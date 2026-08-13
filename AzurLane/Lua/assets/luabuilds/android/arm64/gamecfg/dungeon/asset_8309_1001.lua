local var_0_0 = {
	map_id = 10008,
	id = 1001
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 90,
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
		waveIndex = 200,
		preWaves = {},
		triggerParams = {
			timeout = 24.5
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
				monsterTemplateID = 811,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-12,
					0,
					80
				},
				buffList = {
					8001,
					8007,
					8103
				}
			},
			{
				monsterTemplateID = 813,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-12,
					0,
					60
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 814,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-12,
					0,
					50
				},
				buffList = {
					8001,
					8007,
					8102
				}
			},
			{
				monsterTemplateID = 813,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-12,
					0,
					40
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 813,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-12,
					0,
					30
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 810,
				delay = 3,
				moveCast = true,
				corrdinate = {
					-6,
					0,
					75
				},
				buffList = {
					8001,
					8007,
					8101
				}
			},
			{
				monsterTemplateID = 810,
				delay = 3,
				moveCast = true,
				corrdinate = {
					-6,
					0,
					35
				},
				buffList = {
					8001,
					8007,
					8101
				}
			},
			{
				monsterTemplateID = 812,
				delay = 6,
				moveCast = true,
				corrdinate = {
					-6,
					0,
					55
				},
				buffList = {
					8001,
					8007,
					8608
				}
			},
			{
				monsterTemplateID = 813,
				delay = 9,
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
				monsterTemplateID = 813,
				delay = 9,
				moveCast = true,
				corrdinate = {
					0,
					0,
					60
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 813,
				delay = 9,
				moveCast = true,
				corrdinate = {
					0,
					0,
					45
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 811,
				delay = 10,
				moveCast = true,
				corrdinate = {
					0,
					0,
					30
				},
				buffList = {
					8001,
					8007,
					8103
				}
			},
			{
				monsterTemplateID = 814,
				delay = 12,
				moveCast = true,
				corrdinate = {
					6,
					0,
					75
				},
				buffList = {
					8001,
					8007,
					8102
				}
			},
			{
				monsterTemplateID = 814,
				delay = 12,
				moveCast = true,
				corrdinate = {
					6,
					0,
					60
				},
				buffList = {
					8001,
					8007,
					8102
				}
			},
			{
				monsterTemplateID = 814,
				delay = 12,
				moveCast = true,
				corrdinate = {
					6,
					0,
					45
				},
				buffList = {
					8001,
					8007,
					8102
				}
			},
			{
				monsterTemplateID = 813,
				delay = 15,
				moveCast = true,
				corrdinate = {
					12,
					0,
					80
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 813,
				delay = 15,
				moveCast = true,
				corrdinate = {
					12,
					0,
					62
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 813,
				delay = 15,
				moveCast = true,
				corrdinate = {
					12,
					0,
					44
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 813,
				delay = 15,
				moveCast = true,
				corrdinate = {
					12,
					0,
					26
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 814,
				delay = 18,
				moveCast = true,
				corrdinate = {
					18,
					0,
					71
				},
				buffList = {
					8001,
					8007,
					8102
				}
			},
			{
				monsterTemplateID = 814,
				delay = 18,
				moveCast = true,
				corrdinate = {
					18,
					0,
					53
				},
				buffList = {
					8001,
					8007,
					8102
				}
			},
			{
				monsterTemplateID = 814,
				delay = 18,
				moveCast = true,
				corrdinate = {
					18,
					0,
					35
				},
				buffList = {
					8001,
					8007,
					8102
				}
			},
			{
				monsterTemplateID = 810,
				delay = 21,
				moveCast = true,
				corrdinate = {
					24,
					0,
					75
				},
				buffList = {
					8001,
					8007,
					8101
				}
			},
			{
				monsterTemplateID = 810,
				delay = 21,
				moveCast = true,
				corrdinate = {
					24,
					0,
					35
				},
				buffList = {
					8001,
					8007,
					8101
				}
			}
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 201,
		conditionType = 1,
		preWaves = {
			200
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 812,
				delay = 0,
				moveCast = true,
				corrdinate = {
					24,
					0,
					62
				},
				buffList = {
					8001,
					8007,
					8608
				}
			},
			{
				monsterTemplateID = 812,
				delay = 0,
				moveCast = true,
				corrdinate = {
					24,
					0,
					48
				},
				buffList = {
					8001,
					8007,
					8608
				}
			}
		}
	},
	{
		triggerType = 8,
		waveIndex = 900,
		preWaves = {
			201
		},
		triggerParams = {}
	},
	{
		triggerType = 1,
		waveIndex = 205,
		preWaves = {
			201
		},
		triggerParams = {
			timeout = 1
		}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
