local var_0_0 = {
	map_id = 10008,
	id = 10205100
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
			timeout = 20
		}
	},
	{
		triggerType = 1,
		waveIndex = 204,
		preWaves = {},
		triggerParams = {
			timeout = 32
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
				monsterTemplateID = 102001,
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
				monsterTemplateID = 102002,
				delay = 0,
				moveCast = true,
				corrdinate = {
					5,
					0,
					60
				},
				buffList = {
					8001
				}
			},
			{
				monsterTemplateID = 102003,
				delay = 0,
				moveCast = true,
				corrdinate = {
					5,
					0,
					50
				},
				buffList = {
					8001
				}
			},
			{
				monsterTemplateID = 102001,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
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
				monsterTemplateID = 102016,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					80
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 102012,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					45
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 102016,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					30
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
				onceNumber = 2,
				formation = 10006,
				templateID = 312065,
				delay = 0,
				totalNumber = 4,
				weaponID = {
					312529
				},
				attr = {
					airPower = 110,
					maxHP = 35,
					attackRating = 23
				}
			}
		}
	},
	{
		triggerType = 0,
		waveIndex = 103,
		conditionType = 0,
		preWaves = {
			102,
			203
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 102016,
				delay = 0,
				moveCast = true,
				corrdinate = {
					41,
					0,
					80
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 102004,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					65
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 102008,
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
				monsterTemplateID = 102004,
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
				monsterTemplateID = 102016,
				delay = 0,
				moveCast = true,
				corrdinate = {
					41,
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
		triggerType = 5,
		waveIndex = 400,
		conditionType = 0,
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
				monsterTemplateID = 10205100,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				corrdinate = {
					11,
					0,
					55
				},
				bossData = {
					hpBarNum = 10,
					icon = "qingye"
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 102007,
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
				monsterTemplateID = 102007,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
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
			104
		},
		triggerParams = {}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
