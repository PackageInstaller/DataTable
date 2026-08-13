local var_0_0 = {
	map_id = 10001,
	id = 411330
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
				monsterTemplateID = 104009,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					85
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 104000,
				team = 1,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					70
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 104001,
				team = 1,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					40
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 104009,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					25
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
				formation = 10006,
				templateID = 31200,
				delay = 0,
				totalNumber = 3,
				weaponID = {
					190007
				},
				attr = {
					airPower = 85,
					maxHP = 55,
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
				monsterTemplateID = 104003,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					85
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 104010,
				delay = 0,
				moveCast = true,
				corrdinate = {
					19,
					0,
					70
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 104022,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					55
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 104010,
				delay = 0,
				moveCast = true,
				corrdinate = {
					41,
					0,
					40
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 104003,
				delay = 0,
				moveCast = true,
				corrdinate = {
					52,
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
		waveIndex = 103,
		conditionType = 1,
		preWaves = {
			102,
			203
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 104004,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					80
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 104011,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					80
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 104004,
				delay = 0,
				moveCast = true,
				corrdinate = {
					19,
					0,
					30
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 104011,
				delay = 0,
				moveCast = true,
				corrdinate = {
					41,
					0,
					30
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
				formation = 10006,
				templateID = 31200,
				delay = 0,
				totalNumber = 3,
				weaponID = {
					190007
				},
				attr = {
					airPower = 85,
					maxHP = 55,
					attackRating = 23
				}
			}
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 104,
		conditionType = 1,
		preWaves = {
			103,
			204
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 104004,
				delay = 0,
				moveCast = true,
				corrdinate = {
					19,
					0,
					80
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 104011,
				delay = 0,
				moveCast = true,
				corrdinate = {
					41,
					0,
					80
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 104004,
				delay = 0,
				moveCast = true,
				corrdinate = {
					19,
					0,
					30
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 104011,
				delay = 0,
				moveCast = true,
				corrdinate = {
					41,
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
		key = true,
		triggerType = 0,
		waveIndex = 105,
		conditionType = 1,
		preWaves = {
			104,
			205
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 104013,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					70
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 104028,
				reinforceDelay = 5,
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
				monsterTemplateID = 104027,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				corrdinate = {
					28,
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
				monsterTemplateID = 104010,
				delay = 0,
				moveCast = true,
				corrdinate = {
					28,
					0,
					85
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 104010,
				delay = 0,
				moveCast = true,
				corrdinate = {
					28,
					0,
					25
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
				formation = 10006,
				templateID = 31200,
				delay = 0,
				totalNumber = 6,
				weaponID = {
					190007
				},
				attr = {
					airPower = 85,
					maxHP = 55,
					attackRating = 23
				}
			}
		}
	},
	{
		triggerType = 8,
		waveIndex = 900,
		preWaves = {
			105
		},
		triggerParams = {}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
