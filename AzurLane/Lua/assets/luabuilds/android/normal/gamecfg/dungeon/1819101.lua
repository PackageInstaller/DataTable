local var_0_0 = {
	id = 1819101
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
				monsterTemplateID = 16620003,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
				corrdinate = {
					-5,
					0,
					70
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16620101,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
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
				monsterTemplateID = 16620003,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
				corrdinate = {
					-5,
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
		triggerType = 0,
		key = true,
		waveIndex = 102,
		conditionType = 1,
		preWaves = {
			101
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 16620003,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
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
				monsterTemplateID = 16620102,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
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
				monsterTemplateID = 16620103,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
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
				monsterTemplateID = 16620003,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
				corrdinate = {
					5,
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
				monsterTemplateID = 16620004,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
				reinforceDelay = 6,
				corrdinate = {
					-5,
					0,
					55
				},
				buffList = {
					8001,
					8007
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 16620001,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
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
				monsterTemplateID = 16620002,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
				corrdinate = {
					5,
					0,
					65
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16620002,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
				corrdinate = {
					5,
					0,
					45
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16620001,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
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
				monsterTemplateID = 16620104,
				reinforceDelay = 6,
				delay = 0,
				moveCast = true,
				deadFX = "youeryuan_bomb",
				score = 0,
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
				monsterTemplateID = 16620105,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
				corrdinate = {
					0,
					0,
					65
				},
				buffList = {
					8001,
					8007
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 16620003,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
				corrdinate = {
					3,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16620006,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
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
				monsterTemplateID = 16620006,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
				corrdinate = {
					30,
					0,
					45
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 16620003,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
				corrdinate = {
					3,
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
		triggerType = 5,
		waveIndex = 400,
		preWaves = {
			104
		},
		triggerParams = {
			bgm = "votefes-up"
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 105,
		conditionType = 0,
		preWaves = {
			104
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 16620301,
				reinforceDelay = 6,
				delay = 0.1,
				corrdinate = {
					-10,
					0,
					50
				},
				bossData = {
					hpBarNum = 80,
					icon = ""
				},
				buffList = {}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 16620002,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
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
				monsterTemplateID = 16620002,
				deadFX = "youeryuan_bomb",
				delay = 0,
				moveCast = true,
				score = 0,
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
