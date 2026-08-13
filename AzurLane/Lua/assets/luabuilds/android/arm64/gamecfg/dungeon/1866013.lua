local var_0_0 = {
	id = 1866013
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
				monsterTemplateID = 16676002,
				delay = 0,
				corrdinate = {
					0,
					0,
					67
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16676003,
				delay = 0,
				corrdinate = {
					-5,
					0,
					52
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16676002,
				delay = 0,
				corrdinate = {
					0,
					0,
					37
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
				monsterTemplateID = 16676003,
				reinforceDelay = 6,
				delay = 0,
				corrdinate = {
					-5,
					0,
					64
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16676003,
				reinforceDelay = 6,
				delay = 0,
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
		},
		reinforcement = {
			{
				monsterTemplateID = 16676002,
				delay = 0,
				corrdinate = {
					0,
					0,
					77
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16676001,
				delay = 0,
				corrdinate = {
					0,
					0,
					52
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16676002,
				delay = 0,
				corrdinate = {
					0,
					0,
					27
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
			102,
			101
		},
		triggerParams = {
			bgm = "battle-boss-temepest-1"
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 104,
		conditionType = 0,
		preWaves = {
			500,
			102,
			101
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 16676301,
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
				buffList = {
					200914
				},
				phase = {
					{
						switchType = 1,
						switchTo = 1,
						index = 0,
						switchParam = 1.5,
						setAI = 20006
					},
					{
						switchParam = 9,
						switchTo = 2,
						index = 1,
						switchType = 1,
						setAI = 10001,
						addWeapon = {
							3216003,
							3216004,
							3216005
						}
					},
					{
						switchParam = 3,
						switchTo = 3,
						index = 2,
						switchType = 1,
						addWeapon = {
							3216006,
							3216007
						},
						removeWeapon = {
							3216003,
							3216004,
							3216005
						}
					},
					{
						switchParam = 2,
						switchTo = 4,
						index = 3,
						switchType = 1,
						setAI = 75016,
						removeWeapon = {
							3216006,
							3216007
						}
					},
					{
						switchType = 1,
						switchTo = 5,
						index = 4,
						switchParam = 11,
						addWeapon = {
							3216008,
							3216009
						}
					},
					{
						switchParam = 11,
						switchTo = 6,
						index = 5,
						switchType = 1,
						addWeapon = {
							3216010,
							3216011
						},
						removeWeapon = {
							3216008,
							3216009
						}
					},
					{
						switchType = 1,
						switchTo = 1,
						index = 6,
						switchParam = 3,
						removeWeapon = {
							3216010,
							3216011
						}
					}
				}
			}
		}
	},
	{
		triggerType = 8,
		key = true,
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
