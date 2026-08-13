local var_0_0 = {
	map_id = 10001,
	id = 900000
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 300,
	backGroundStageID = 1,
	passCondition = 1,
	totalArea = {
		-45,
		20,
		90,
		70
	},
	playerArea = {
		-45,
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
		waveIndex = 101,
		conditionType = 1,
		preWaves = {
			100
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1026,
				delay = 0,
				chance = 1,
				corrdinate = {
					65,
					0,
					80
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 1026,
				delay = 0,
				chance = 1,
				corrdinate = {
					65,
					0,
					70
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 1026,
				delay = 0,
				chance = 1,
				corrdinate = {
					65,
					0,
					60
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 1026,
				delay = 0,
				chance = 1,
				corrdinate = {
					65,
					0,
					30
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
		waveIndex = 102,
		conditionType = 1,
		preWaves = {
			101
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1026,
				delay = 0,
				chance = 1,
				corrdinate = {
					65,
					0,
					40
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 1026,
				delay = 0,
				chance = 1,
				corrdinate = {
					65,
					0,
					45
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 1026,
				delay = 0,
				chance = 1,
				corrdinate = {
					65,
					0,
					55
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 1026,
				delay = 0,
				chance = 1,
				corrdinate = {
					65,
					0,
					60
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
		conditionType = 1,
		preWaves = {
			102
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1026,
				delay = 0,
				chance = 1,
				corrdinate = {
					65,
					0,
					70
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 1026,
				delay = 3,
				chance = 1,
				corrdinate = {
					65,
					0,
					40
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 1026,
				delay = 6,
				chance = 1,
				corrdinate = {
					65,
					0,
					55
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 1026,
				delay = 9,
				chance = 1,
				corrdinate = {
					65,
					0,
					20
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 1026,
				delay = 12,
				chance = 1,
				corrdinate = {
					65,
					0,
					60
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 1026,
				delay = 15,
				chance = 1,
				corrdinate = {
					65,
					0,
					30
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
