local var_0_0 = {
	map_id = 10001,
	id = 1010090
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
			timeout = 29
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
		key = true,
		waveIndex = 101,
		conditionType = 1,
		preWaves = {
			100
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 10020003,
				score = 0,
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
				monsterTemplateID = 10020026,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					55
				},
				buffList = {
					8030,
					8031
				}
			},
			{
				monsterTemplateID = 10020003,
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
		},
		airFighter = {
			{
				interval = 10,
				onceNumber = 2,
				formation = 10006,
				templateID = 34010,
				delay = 0,
				totalNumber = 2,
				weaponID = {
					480022
				},
				attr = {
					airPower = 40,
					maxHP = 15,
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
				monsterTemplateID = 10020016,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					70
				}
			},
			{
				monsterTemplateID = 10020034,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					35
				}
			}
		},
		airFighter = {
			{
				interval = 10,
				onceNumber = 3,
				formation = 10006,
				templateID = 34007,
				delay = 0,
				totalNumber = 3,
				weaponID = {
					480021
				},
				attr = {
					airPower = 40,
					maxHP = 15,
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
				monsterTemplateID = 10020011,
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
				monsterTemplateID = 10020029,
				score = 0,
				reinforceDelay = 10,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					35
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 10020033,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					20,
					0,
					63
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 10020033,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					20,
					0,
					47
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
				monsterTemplateID = 10020022,
				score = 0,
				reinforceDelay = 10,
				delay = 0,
				moveCast = true,
				team = 1,
				corrdinate = {
					-15,
					0,
					70
				}
			},
			{
				monsterTemplateID = 10020035,
				score = 0,
				reinforceDelay = 10,
				delay = 0,
				moveCast = true,
				team = 1,
				corrdinate = {
					-15,
					0,
					55
				}
			},
			{
				monsterTemplateID = 10020013,
				score = 0,
				reinforceDelay = 10,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					30
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 10020002,
				score = 0,
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
				monsterTemplateID = 10020002,
				score = 0,
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
