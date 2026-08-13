local var_0_0 = {
	map_id = 10001,
	id = 601330
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
		key = true,
		waveIndex = 101,
		conditionType = 1,
		preWaves = {
			100
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 7001,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					33,
					0,
					85
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 7016,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					11,
					0,
					70
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 7011,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					55
				},
				buffList = {
					8030,
					8031
				}
			},
			{
				monsterTemplateID = 7016,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					11,
					0,
					40
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 7001,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					33,
					0,
					25
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
				monsterTemplateID = 7017,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					22,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 7017,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					33,
					0,
					55
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 7017,
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
		},
		airFighter = {
			{
				interval = 10,
				onceNumber = 3,
				totalNumber = 3,
				formation = 10006,
				delay = 0,
				templateID = 316043,
				score = 1,
				weaponID = {
					316509
				},
				attr = {
					airPower = 125,
					maxHP = 90,
					attackRating = 23
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
				monsterTemplateID = 7002,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					70
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 7017,
				score = 0,
				delay = 0,
				moveCast = true,
				reinforceDelay = 5,
				corrdinate = {
					11,
					0,
					70
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 7002,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					40
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 7017,
				score = 0,
				delay = 0,
				moveCast = true,
				reinforceDelay = 5,
				corrdinate = {
					11,
					0,
					40
				},
				buffList = {
					8001,
					8007
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 7023,
				score = 0,
				delay = 3,
				moveCast = true,
				corrdinate = {
					30,
					0,
					85
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 7023,
				score = 0,
				delay = 3,
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
				monsterTemplateID = 7015,
				score = 0,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				team = 1,
				corrdinate = {
					0,
					0,
					85
				}
			},
			{
				monsterTemplateID = 7009,
				score = 0,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				team = 1,
				corrdinate = {
					0,
					0,
					55
				}
			},
			{
				monsterTemplateID = 7010,
				score = 0,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				team = 1,
				corrdinate = {
					0,
					0,
					25
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 7019,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					70
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 7019,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
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
			104
		},
		triggerParams = {}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
