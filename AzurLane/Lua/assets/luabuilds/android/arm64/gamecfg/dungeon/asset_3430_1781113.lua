local var_0_0 = {
	id = 1781113
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
				deadFX = "udf_shanshuo",
				sickness = 0.3,
				delay = 0.5,
				monsterTemplateID = 16581004,
				reinforceDelay = 6,
				corrdinate = {
					-5,
					0,
					50
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			}
		},
		reinforcement = {
			{
				deadFX = "udf_shanshuo",
				sickness = 0.3,
				delay = 0,
				monsterTemplateID = 16581001,
				corrdinate = {
					5,
					0,
					75
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			},
			{
				deadFX = "udf_shanshuo",
				sickness = 0.3,
				delay = 0,
				monsterTemplateID = 16581002,
				corrdinate = {
					0,
					0,
					65
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			},
			{
				deadFX = "udf_shanshuo",
				sickness = 0.3,
				delay = 0,
				monsterTemplateID = 16581002,
				corrdinate = {
					0,
					0,
					35
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			},
			{
				deadFX = "udf_shanshuo",
				sickness = 0.3,
				delay = 0,
				monsterTemplateID = 16581001,
				corrdinate = {
					5,
					0,
					25
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			}
		}
	},
	{
		triggerType = 0,
		waveIndex = 102,
		conditionType = 1,
		preWaves = {
			101
		},
		triggerParam = {},
		spawn = {
			{
				deadFX = "udf_shanshuo",
				sickness = 0.3,
				delay = 0.5,
				monsterTemplateID = 16581005,
				reinforceDelay = 6,
				corrdinate = {
					-5,
					0,
					50
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			}
		},
		reinforcement = {
			{
				deadFX = "udf_shanshuo",
				sickness = 0.3,
				delay = 0,
				monsterTemplateID = 16581001,
				corrdinate = {
					5,
					0,
					75
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			},
			{
				deadFX = "udf_shanshuo",
				sickness = 0.3,
				delay = 0,
				monsterTemplateID = 16581002,
				corrdinate = {
					0,
					0,
					65
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			},
			{
				deadFX = "udf_shanshuo",
				sickness = 0.3,
				delay = 0,
				monsterTemplateID = 16581002,
				corrdinate = {
					0,
					0,
					35
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			},
			{
				deadFX = "udf_shanshuo",
				sickness = 0.3,
				delay = 0,
				monsterTemplateID = 16581001,
				corrdinate = {
					5,
					0,
					25
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
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
			bgm = "battle-warprotocol"
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
				deadFX = "udf_shanshuo",
				monsterTemplateID = 16581302,
				delay = 1,
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
				},
				phase = {
					{
						switchParam = 1,
						switchTo = 1,
						index = 0,
						switchType = 1,
						setAI = 70125,
						addWeapon = {}
					},
					{
						switchParam = 1,
						switchTo = 2,
						index = 1,
						switchType = 1,
						setAI = 10001,
						addWeapon = {
							3111101
						}
					},
					{
						switchType = 1,
						switchTo = 3,
						index = 2,
						switchParam = 3,
						addWeapon = {
							3111102
						}
					},
					{
						switchType = 1,
						switchTo = 4,
						index = 3,
						switchParam = 8,
						addWeapon = {
							3111103
						}
					},
					{
						switchParam = 2,
						switchTo = 5,
						index = 4,
						switchType = 1,
						setAI = 70125,
						addWeapon = {},
						removeWeapon = {
							3111101,
							3111102,
							3111103
						}
					},
					{
						switchParam = 2,
						switchTo = 6,
						index = 5,
						switchType = 1,
						addWeapon = {
							3111104,
							3111105
						},
						removeWeapon = {}
					},
					{
						switchType = 1,
						switchTo = 7,
						index = 6,
						switchParam = 3,
						addBuff = {
							200750
						}
					},
					{
						switchType = 1,
						switchTo = 8,
						index = 7,
						switchParam = 5,
						addBuff = {
							200752
						}
					},
					{
						switchType = 1,
						switchTo = 9,
						index = 8,
						switchParam = 5,
						addBuff = {
							200752
						}
					},
					{
						switchType = 1,
						switchTo = 1,
						index = 9,
						switchParam = 1.5,
						removeWeapon = {
							3111104,
							3111105
						}
					}
				}
			}
		},
		reinforcement = {
			{
				deadFX = "udf_shanshuo",
				sickness = 0.3,
				delay = 0,
				monsterTemplateID = 16581002,
				corrdinate = {
					5,
					0,
					75
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			},
			{
				deadFX = "udf_shanshuo",
				sickness = 0.3,
				delay = 0,
				monsterTemplateID = 16581002,
				corrdinate = {
					5,
					0,
					25
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
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
