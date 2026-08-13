local var_0_0 = {
	map_id = 10001,
	id = 294112
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
			bgm = "battle-boss-4"
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
				monsterTemplateID = 291021,
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
				monsterTemplateID = 291020,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 292001,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-5,
					0,
					65
				}
			},
			{
				monsterTemplateID = 292002,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-5,
					0,
					45
				}
			},
			{
				monsterTemplateID = 291020,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					35
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 291021,
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
		},
		airFighter = {
			{
				interval = 12,
				onceNumber = 6,
				totalNumber = 18,
				formation = 10003,
				delay = 0,
				templateID = 2200901,
				score = 1,
				weaponID = {
					1000850,
					1000855
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
				monsterTemplateID = 291021,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					5,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 291021,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					5,
					0,
					35
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 292203,
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
			},
			{
				monsterTemplateID = 291031,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
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
				monsterTemplateID = 291031,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-10,
					0,
					70
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 291031,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-10,
					0,
					40
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				score = 0,
				reinforceDelay = 12,
				delay = 0,
				moveCast = true,
				affix = true,
				monsterTemplateID = 293022,
				corrdinate = {
					0,
					0,
					55
				},
				bossData = {
					hpBarNum = 50,
					icon = "sairenquzhu_ii"
				},
				buffList = {
					8050,
					8051
				},
				phase = {
					{
						switchType = 1,
						switchTo = 1,
						index = 0,
						switchParam = 2,
						removeWeapon = {
							2029600,
							2029601,
							2029602,
							2029603
						}
					},
					{
						switchType = 1,
						switchTo = 0,
						index = 1,
						switchParam = 180,
						addWeapon = {
							2029650,
							2029660,
							2029603
						}
					}
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 291010,
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
				monsterTemplateID = 291010,
				delay = 0,
				moveCast = true,
				corrdinate = {
					38,
					0,
					55
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 291010,
				delay = 0,
				moveCast = true,
				corrdinate = {
					46,
					0,
					55
				},
				buffList = {
					8001,
					8002
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
