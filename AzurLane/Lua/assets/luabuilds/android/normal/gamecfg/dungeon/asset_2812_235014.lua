local var_0_0 = {
	map_id = 10001,
	id = 235014
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
			timeout = 30
		}
	},
	{
		triggerType = 1,
		waveIndex = 203,
		preWaves = {},
		triggerParams = {
			timeout = 50
		}
	},
	{
		triggerType = 5,
		waveIndex = 204,
		preWaves = {
			102,
			101
		},
		triggerParams = {
			bgm = "nagato-boss"
		}
	},
	{
		key = true,
		triggerType = 0,
		waveIndex = 101,
		conditionType = 1,
		preWaves = {
			100
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 203201,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					15,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 203201,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-10,
					0,
					80
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 232101,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					50
				}
			},
			{
				monsterTemplateID = 232108,
				score = 0,
				delay = 0,
				moveCast = true,
				reinforceDelay = 12,
				corrdinate = {
					-15,
					0,
					55
				},
				buffList = {
					8050,
					8051
				}
			},
			{
				monsterTemplateID = 203201,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-10,
					0,
					30
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 203201,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					15,
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
				monsterTemplateID = 209502,
				score = 0,
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
				monsterTemplateID = 209502,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					45,
					0,
					55
				},
				buffList = {
					8001,
					8002
				}
			}
		},
		airFighter = {
			{
				interval = 10,
				onceNumber = 6,
				totalNumber = 6,
				formation = 10006,
				delay = 0,
				templateID = 2200799,
				score = 1,
				weaponID = {
					2020002
				},
				attr = {
					airPower = 125,
					maxHP = 900,
					attackRating = 23
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
				monsterTemplateID = 203208,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-10,
					0,
					80
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 203208,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-10,
					0,
					30
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 232212,
				score = 0,
				reinforceDelay = 10,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					55
				}
			},
			{
				monsterTemplateID = 232010,
				score = 0,
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
				monsterTemplateID = 203201,
				score = 0,
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
				monsterTemplateID = 232106,
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
				monsterTemplateID = 232105,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					45
				}
			},
			{
				score = 0,
				reinforceDelay = 12,
				delay = 0,
				moveCast = true,
				affix = true,
				monsterTemplateID = 233013,
				corrdinate = {
					15,
					0,
					55
				},
				bossData = {
					hpBarNum = 50,
					icon = "rixiang"
				},
				buffList = {
					8050,
					8051
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 203201,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-5,
					0,
					80
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 203201,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					55
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 203201,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-5,
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
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
