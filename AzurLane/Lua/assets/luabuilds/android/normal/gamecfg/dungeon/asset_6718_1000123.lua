local var_0_0 = {
	map_id = 10008,
	id = 1000223
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 180,
	backGroundStageID = 1,
	passCondition = 1,
	totalArea = {
		-80,
		20,
		90,
		70
	},
	playerArea = {
		-80,
		20,
		45,
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
			timeout = 13
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
		waveIndex = 101,
		conditionType = 1,
		preWaves = {
			502
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 10011002,
				score = 0,
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
				monsterTemplateID = 10011003,
				score = 0,
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
				monsterTemplateID = 10011002,
				score = 0,
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
		triggerType = 0,
		waveIndex = 102,
		conditionType = 1,
		preWaves = {
			101,
			202
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 10011005,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					65
				}
			},
			{
				monsterTemplateID = 10011005,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					45
				}
			}
		},
		airFighter = {
			{
				interval = 10,
				onceNumber = 3,
				totalNumber = 3,
				formation = 10006,
				templateID = 471903,
				delay = 0,
				weaponID = {
					471903,
					471904
				}
			}
		}
	},
	{
		triggerType = 5,
		waveIndex = 400,
		preWaves = {
			102,
			101
		},
		triggerParams = {
			bgm = "battle-boss-2"
		}
	},
	{
		triggerType = 3,
		waveIndex = 500,
		preWaves = {
			102,
			101
		},
		triggerParams = {
			id = "TACT20013"
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 103,
		conditionType = 0,
		preWaves = {
			500
		},
		triggerParam = {},
		spawn = {
			{
				score = 0,
				monsterTemplateID = 10011504,
				delay = 0,
				moveCast = true,
				reinforceDelay = 5,
				corrdinate = {
					-15,
					0,
					50
				},
				bossData = {
					hpBarNum = 82,
					icon = "unknown1"
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 10011002,
				score = 10,
				delay = 0,
				moveCast = true,
				corrdinate = {
					20,
					0,
					65
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 10011002,
				score = 0,
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
			timeout = 1
		}
	},
	{
		triggerType = 3,
		waveIndex = 501,
		preWaves = {
			205
		},
		triggerParams = {
			id = "TACT20014",
			progress = 100
		}
	},
	{
		triggerType = 3,
		waveIndex = 503,
		preWaves = {
			501
		},
		triggerParams = {
			id = "TACT20017"
		}
	},
	{
		triggerType = 1,
		key = true,
		waveIndex = 206,
		conditionType = 0,
		preWaves = {
			501,
			503
		},
		triggerParams = {
			timeout = 0.5
		}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
