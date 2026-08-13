local var_0_0 = {
	id = 1719302
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
			timeout = 18
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
				monsterTemplateID = 16513002,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16513101,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-5,
					0,
					50
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16513002,
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
				onceNumber = 6,
				formation = 10006,
				templateID = 1004188,
				delay = 0,
				totalNumber = 6,
				weaponID = {
					1100972
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
		key = true,
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
				monsterTemplateID = 16513005,
				score = 0,
				reinforceDelay = 6,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					55
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 16513001,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					80
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16513002,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					65
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16513002,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					45
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16513001,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
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
				onceNumber = 6,
				formation = 10006,
				templateID = 1004073,
				delay = 0,
				totalNumber = 12,
				weaponID = {
					1100982,
					1100752
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
				monsterTemplateID = 16513102,
				score = 0,
				reinforceDelay = 6,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-5,
					0,
					55
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 16513001,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-3,
					0,
					80
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16513002,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					5,
					0,
					70
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16513002,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					5,
					0,
					40
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16513001,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-3,
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
		triggerType = 5,
		waveIndex = 400,
		preWaves = {
			101,
			102,
			103
		},
		triggerParams = {
			bgm = "bgm-cccp"
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 105,
		conditionType = 0,
		preWaves = {
			101,
			102,
			103
		},
		triggerParam = {},
		spawn = {
			{
				score = 0,
				monsterTemplateID = 16513302,
				delay = 0.1,
				moveCast = true,
				reinforceDelay = 6,
				corrdinate = {
					-5,
					0,
					50
				},
				buffList = {},
				bossData = {
					hpBarNum = 60,
					icon = ""
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 16513002,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					12,
					0,
					78
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16513002,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					12,
					0,
					22
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
		waveIndex = 2001,
		conditionType = 1,
		preWaves = {
			100
		},
		triggerParam = {},
		spawn = {},
		reinforcement = {
			{
				monsterTemplateID = 16513007,
				delay = 5,
				moveCast = true,
				corrdinate = {
					5,
					0,
					58
				},
				buffList = {
					8001
				},
				phase = {
					{
						switchType = 1,
						dive = "STATE_RAID",
						switchTo = 1,
						index = 0,
						switchParam = 180,
						setAI = 20009
					}
				}
			},
			reinforceDuration = 180
		}
	},
	{
		triggerType = 8,
		key = true,
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
