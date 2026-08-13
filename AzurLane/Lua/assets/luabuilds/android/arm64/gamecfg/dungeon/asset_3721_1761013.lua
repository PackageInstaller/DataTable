local var_0_0 = {
	id = 1761013
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
		triggerType = 3,
		waveIndex = 501,
		preWaves = {
			100
		},
		triggerParams = {
			id = "JUFENGYUQINGCHUNZHIQUAN9"
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 101,
		conditionType = 1,
		preWaves = {
			501
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 16561001,
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
				monsterTemplateID = 16561101,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-5,
					0,
					55
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16561001,
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
				monsterTemplateID = 16561102,
				score = 0,
				delay = 0,
				moveCast = true,
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
				monsterTemplateID = 16561002,
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
				monsterTemplateID = 16561003,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					3,
					0,
					65
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16561003,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					3,
					0,
					45
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16561002,
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
		}
	},
	{
		triggerType = 5,
		waveIndex = 400,
		preWaves = {
			101,
			102
		},
		triggerParams = {
			bgm = "theme-tempest"
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
				score = 0,
				reinforceDelay = 6,
				delay = 0.1,
				moveCast = true,
				monsterTemplateID = 16561301,
				corrdinate = {
					-5,
					0,
					50
				},
				buffList = {},
				bossData = {
					hpBarNum = 40,
					icon = "sairen"
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
						switchParam = 6,
						switchTo = 2,
						index = 1,
						switchType = 1,
						setAI = 10001,
						addWeapon = {
							3091001,
							3091002
						},
						removeWeapon = {}
					},
					{
						switchParam = 2,
						switchTo = 3,
						index = 2,
						switchType = 1,
						setAI = 70093,
						addWeapon = {
							3091003
						},
						removeWeapon = {
							3091001,
							3091002
						}
					},
					{
						switchParam = 8,
						switchTo = 4,
						index = 3,
						switchType = 1,
						addWeapon = {
							3091004
						},
						removeWeapon = {}
					},
					{
						switchParam = 12,
						switchTo = 5,
						index = 4,
						switchType = 1,
						setAI = 10001,
						addWeapon = {
							3091005,
							3091006,
							3091007
						},
						removeWeapon = {
							3091003,
							3091004
						}
					},
					{
						switchParam = 2,
						switchTo = 1,
						index = 5,
						switchType = 1,
						addWeapon = {},
						removeWeapon = {
							3091005,
							3091006,
							3091007
						}
					}
				}
			},
			{
				monsterTemplateID = 16561003,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-5,
					0,
					68
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 16561003,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-5,
					0,
					32
				},
				buffList = {
					8001,
					8007
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 16561001,
				score = 0,
				delay = 4,
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
				monsterTemplateID = 16561001,
				score = 0,
				delay = 4,
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
