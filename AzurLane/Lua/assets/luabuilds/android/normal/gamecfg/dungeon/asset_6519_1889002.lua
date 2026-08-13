local var_0_0 = {
	id = 1889002
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 180,
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
		key = true,
		waveIndex = 101,
		conditionType = 1,
		preWaves = {
			100
		},
		triggerParam = {},
		spawn = {
			{
				deadFX = "chengbao_yanhua_stg",
				sickness = 0.5,
				delay = 0,
				monsterTemplateID = 16589201,
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
				deadFX = "chengbao_yanhua_stg",
				sickness = 0.5,
				delay = 0,
				monsterTemplateID = 16589201,
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
				monsterTemplateID = 16589202,
				delay = 0,
				deadFX = "chengbao_yanhua_stg",
				corrdinate = {
					-5,
					0,
					50
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
				deadFX = "chengbao_yanhua_stg",
				sickness = 0.5,
				delay = 0,
				monsterTemplateID = 16589201,
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
				deadFX = "chengbao_yanhua_stg",
				sickness = 0.5,
				delay = 1,
				monsterTemplateID = 16589201,
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
				deadFX = "chengbao_yanhua_stg",
				sickness = 0.5,
				delay = 1,
				monsterTemplateID = 16589201,
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
				deadFX = "chengbao_yanhua_stg",
				sickness = 0.5,
				delay = 0,
				monsterTemplateID = 16589201,
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
				monsterTemplateID = 16589202,
				delay = 0,
				deadFX = "chengbao_yanhua_stg",
				corrdinate = {
					-5,
					0,
					50
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
				deadFX = "chengbao_yanhua_stg",
				sickness = 0.5,
				delay = 0,
				monsterTemplateID = 16589201,
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
				deadFX = "chengbao_yanhua_stg",
				sickness = 0.5,
				delay = 0,
				monsterTemplateID = 16589201,
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
				deadFX = "chengbao_yanhua_stg",
				sickness = 0.5,
				delay = 0,
				monsterTemplateID = 16589201,
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
				monsterTemplateID = 16589202,
				delay = 0,
				deadFX = "chengbao_yanhua_stg",
				corrdinate = {
					-5,
					0,
					40
				}
			},
			{
				monsterTemplateID = 16589202,
				delay = 0,
				deadFX = "chengbao_yanhua_stg",
				corrdinate = {
					-5,
					0,
					60
				}
			}
		}
	},
	{
		triggerType = 0,
		waveIndex = 104,
		conditionType = 0,
		preWaves = {
			101,
			102,
			103
		},
		triggerParams = {},
		spawn = {
			{
				monsterTemplateID = 16699201,
				delay = 0,
				corrdinate = {
					-10,
					0,
					50
				},
				bossData = {
					hpBarNum = 60,
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
			104
		},
		triggerParams = {}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
