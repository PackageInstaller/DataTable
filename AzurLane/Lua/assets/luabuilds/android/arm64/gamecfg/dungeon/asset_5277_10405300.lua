local var_0_0 = {
	map_id = 10008,
	id = 405300
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
			timeout = 20
		}
	},
	{
		triggerType = 1,
		waveIndex = 203,
		preWaves = {},
		triggerParams = {
			timeout = 38
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
				monsterTemplateID = 104009,
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
				monsterTemplateID = 104000,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					45
				}
			},
			{
				monsterTemplateID = 104002,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					65
				}
			},
			{
				monsterTemplateID = 104009,
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
		},
		reinforcement = {
			{
				monsterTemplateID = 104029,
				delay = 0,
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
				monsterTemplateID = 104029,
				delay = 0,
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
		waveIndex = 102,
		conditionType = 1,
		preWaves = {
			101,
			202
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 104010,
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
				monsterTemplateID = 104015,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				corrdinate = {
					14,
					0,
					55
				}
			},
			{
				monsterTemplateID = 104010,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					25
				},
				buffList = {
					8001,
					8007
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 104029,
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
				monsterTemplateID = 104029,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					45
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
				onceNumber = 3,
				formation = 10006,
				templateID = 314084,
				delay = 0,
				totalNumber = 6,
				weaponID = {
					314522
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
		waveIndex = 103,
		conditionType = 1,
		preWaves = {
			102,
			203
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 104009,
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
				monsterTemplateID = 104010,
				delay = 0,
				moveCast = true,
				corrdinate = {
					19,
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
					19,
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
					19,
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
				templateID = 314083,
				delay = 0,
				totalNumber = 6,
				weaponID = {
					314523
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
		triggerType = 5,
		waveIndex = 400,
		preWaves = {
			101,
			102,
			103
		},
		triggerParams = {
			bgm = "battle-boss-1"
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 104,
		conditionType = 0,
		preWaves = {
			101,
			102,
			103
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 104025,
				delay = 0,
				moveCast = true,
				corrdinate = {
					12,
					0,
					30
				},
				buffList = {
					50002
				}
			},
			{
				monsterTemplateID = 10405300,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				team = 1,
				corrdinate = {
					18,
					0,
					55
				},
				bossData = {
					hpBarNum = 25,
					icon = "longxiang"
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 104009,
				delay = 0,
				moveCast = true,
				corrdinate = {
					12,
					0,
					70
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
					12,
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
