local var_0_0 = {
	id = 1201201,
	bgm = "story-masazhusai"
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
		triggerType = 0,
		waveIndex = 201,
		conditionType = 1,
		preWaves = {
			100
		},
		triggerParams = {
			round = {
				equal = {
					1
				}
			}
		},
		spawn = {
			{
				monsterTemplateID = 900008,
				score = 0,
				delay = 1,
				moveCast = true,
				corrdinate = {
					0,
					0,
					55
				},
				bossData = {
					hpBarNum = 50,
					icon = "aisaikesi"
				},
				phase = {
					{
						switchType = 1,
						switchTo = 1,
						index = 0,
						switchParam = 1,
						setAI = 10001
					},
					{
						switchType = 1,
						switchTo = 2,
						index = 1,
						switchParam = 3,
						addWeapon = {
							950152,
							950153,
							950154
						}
					},
					{
						switchParam = 3,
						switchTo = 3,
						index = 2,
						switchType = 1,
						setAI = 99990,
						removeWeapon = {},
						addWeapon = {
							950157,
							950159
						}
					},
					{
						switchParam = 3,
						index = 3,
						switchType = 1,
						switchTo = 4,
						setAI = 10001,
						removeWeapon = {
							950159
						},
						addWeapon = {
							950158
						},
						addBuff = {}
					},
					{
						switchType = 1,
						index = 4,
						switchParam = 3,
						switchTo = 5,
						removeWeapon = {
							950158
						},
						addWeapon = {
							950155,
							950156
						},
						removeBuff = {},
						addBuff = {}
					},
					{
						switchParam = 3,
						switchTo = 6,
						index = 5,
						switchType = 1,
						setAI = 99990,
						addWeapon = {
							950157,
							950159
						}
					},
					{
						switchParam = 1,
						switchTo = 7,
						index = 6,
						switchType = 1,
						setAI = 10001,
						removeWeapon = {
							950157,
							950159
						}
					},
					{
						switchType = 1,
						switchTo = 8,
						index = 7,
						switchParam = 5,
						addWeapon = {}
					},
					{
						switchParam = 4,
						switchTo = 9,
						index = 8,
						switchType = 1,
						removeWeapon = {
							950155,
							950156
						},
						addWeapon = {
							950151
						}
					},
					{
						switchType = 1,
						switchTo = 202,
						index = 9,
						switchParam = 3,
						addWeapon = {
							950155
						}
					},
					{
						switchType = 1,
						switchTo = 1,
						index = 202,
						switchParam = 3,
						removeWeapon = {
							950151
						}
					}
				}
			}
		}
	},
	{
		triggerType = 0,
		waveIndex = 202,
		conditionType = 1,
		preWaves = {
			201
		},
		triggerParams = {
			round = {
				more = 1
			}
		},
		spawn = {
			{
				monsterTemplateID = 900008,
				reinforceDelay = 5,
				delay = 1,
				moveCast = true,
				corrdinate = {
					0,
					0,
					55
				},
				bossData = {
					hpBarNum = 50,
					icon = "aisaikesi"
				},
				phase = {
					{
						switchType = 1,
						switchTo = 1,
						index = 0,
						switchParam = 1,
						setAI = 10001
					},
					{
						switchType = 1,
						switchTo = 2,
						index = 1,
						switchParam = 3,
						addWeapon = {
							950152,
							950153,
							950154
						}
					},
					{
						switchParam = 3,
						switchTo = 3,
						index = 2,
						switchType = 1,
						setAI = 99990,
						removeWeapon = {},
						addWeapon = {
							950157,
							950159
						}
					},
					{
						switchParam = 3,
						index = 3,
						switchType = 1,
						switchTo = 4,
						setAI = 10001,
						removeWeapon = {
							950159
						},
						addWeapon = {
							950158
						},
						addBuff = {}
					},
					{
						switchType = 1,
						index = 4,
						switchParam = 3,
						switchTo = 5,
						removeWeapon = {
							950158
						},
						addWeapon = {
							950155,
							950156
						},
						removeBuff = {},
						addBuff = {}
					},
					{
						switchParam = 3,
						switchTo = 6,
						index = 5,
						switchType = 1,
						setAI = 99990,
						addWeapon = {
							950157,
							950159
						}
					},
					{
						switchParam = 1,
						switchTo = 7,
						index = 6,
						switchType = 1,
						setAI = 10001,
						removeWeapon = {
							950157,
							950159
						}
					},
					{
						switchType = 1,
						switchTo = 8,
						index = 7,
						switchParam = 5,
						addWeapon = {}
					},
					{
						switchParam = 4,
						switchTo = 9,
						index = 8,
						switchType = 1,
						removeWeapon = {
							950155,
							950156
						},
						addWeapon = {
							950151
						}
					},
					{
						switchType = 1,
						switchTo = 202,
						index = 9,
						switchParam = 3,
						addWeapon = {
							950155
						}
					},
					{
						switchType = 1,
						switchTo = 1,
						index = 202,
						switchParam = 3,
						removeWeapon = {
							950151
						}
					}
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 909011,
				delay = 0,
				moveCast = true,
				corrdinate = {
					50,
					0,
					35
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 909011,
				delay = 0,
				moveCast = true,
				corrdinate = {
					50,
					0,
					75
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
		key = true,
		waveIndex = 900,
		preWaves = {
			202
		},
		triggerParams = {}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
