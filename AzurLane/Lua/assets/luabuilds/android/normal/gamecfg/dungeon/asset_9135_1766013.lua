local var_0_0 = {
	id = 1766013
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
				monsterTemplateID = 16566001,
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
				monsterTemplateID = 16566101,
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
				monsterTemplateID = 16566001,
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
				monsterTemplateID = 16566102,
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
				monsterTemplateID = 16566002,
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
				monsterTemplateID = 16566003,
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
				monsterTemplateID = 16566003,
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
				monsterTemplateID = 16566002,
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
			bgm = "battle-temepest-2"
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
				monsterTemplateID = 16566301,
				delay = 0.1,
				moveCast = true,
				corrdinate = {
					-5,
					0,
					50
				},
				buffList = {},
				bossData = {
					hpBarNum = 80,
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
						switchParam = 13,
						switchTo = 2,
						index = 1,
						switchType = 1,
						setAI = 10001,
						addWeapon = {
							3096001,
							3096002
						},
						removeWeapon = {}
					},
					{
						switchType = 1,
						switchParam = 9.5,
						index = 2,
						switchTo = 3,
						addBuff = {
							200640
						},
						addWeapon = {
							3096004
						},
						removeWeapon = {
							3096001,
							3096002
						}
					},
					{
						switchParam = 4,
						switchTo = 4,
						index = 3,
						switchType = 1,
						setAI = 70093,
						addWeapon = {},
						removeWeapon = {
							3096004
						}
					},
					{
						switchParam = 5,
						switchTo = 5,
						index = 4,
						switchType = 1,
						addWeapon = {
							3096006
						},
						removeWeapon = {}
					},
					{
						switchParam = 7,
						switchTo = 6,
						index = 5,
						switchType = 1,
						addWeapon = {
							3096008
						},
						removeWeapon = {}
					},
					{
						switchParam = 1,
						switchTo = 1,
						index = 6,
						switchType = 1,
						addWeapon = {},
						removeWeapon = {
							3096006,
							3096008
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
