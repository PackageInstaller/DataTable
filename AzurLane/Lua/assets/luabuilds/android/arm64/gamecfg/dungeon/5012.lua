local var_0_0 = {
	id = 5012,
	bgm = "battle-boss-1"
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
				monsterTemplateID = 900004,
				score = 0,
				delay = 1,
				moveCast = true,
				reinforceDelay = 5,
				corrdinate = {
					-15,
					0,
					55
				},
				bossData = {
					hpBarNum = 30,
					icon = "Z23"
				},
				phase = {
					{
						switchType = 1,
						switchTo = 1,
						index = 0,
						switchParam = 4,
						addWeapon = {
							900431,
							900112
						}
					},
					{
						switchType = 1,
						switchTo = 2,
						index = 1,
						switchParam = 1.5,
						removeWeapon = {
							900431
						}
					},
					{
						switchParam = 2,
						switchTo = 3,
						index = 2,
						switchType = 1,
						setAI = 90027,
						addWeapon = {
							900432
						}
					},
					{
						switchType = 1,
						switchTo = 4,
						index = 3,
						switchParam = 1,
						addWeapon = {
							900801
						}
					},
					{
						switchType = 1,
						switchTo = 5,
						index = 4,
						switchParam = 1.5,
						removeWeapon = {
							900432,
							900801
						}
					},
					{
						switchType = 1,
						switchTo = 6,
						index = 5,
						switchParam = 2,
						addWeapon = {
							900433
						}
					},
					{
						switchType = 1,
						switchTo = 7,
						index = 6,
						switchParam = 10,
						addWeapon = {
							900802
						}
					},
					{
						switchType = 1,
						switchTo = 8,
						index = 7,
						switchParam = 1,
						setAI = 90004
					},
					{
						switchType = 1,
						switchTo = 9,
						index = 8,
						switchParam = 1,
						removeWeapon = {
							900433,
							900802
						}
					},
					{
						switchType = 1,
						switchTo = 10,
						index = 9,
						switchParam = 6,
						addWeapon = {
							900083
						}
					},
					{
						switchType = 1,
						switchTo = 11,
						index = 10,
						switchParam = 5,
						setAI = 10001
					},
					{
						switchType = 1,
						switchTo = 12,
						index = 11,
						switchParam = 1,
						removeWeapon = {
							900083
						}
					},
					{
						switchType = 1,
						switchTo = 13,
						index = 12,
						switchParam = 1,
						addWeapon = {
							900084
						}
					},
					{
						switchType = 1,
						switchTo = 14,
						index = 13,
						switchParam = 11,
						addWeapon = {
							900802
						}
					},
					{
						switchType = 1,
						switchTo = 15,
						index = 14,
						switchParam = 0.5,
						setAI = 90004
					},
					{
						switchType = 1,
						switchTo = 16,
						index = 15,
						switchParam = 1,
						removeWeapon = {
							900084,
							900802
						}
					},
					{
						switchType = 1,
						switchTo = 17,
						index = 16,
						switchParam = 8,
						addWeapon = {
							900437
						}
					},
					{
						switchType = 1,
						switchTo = 18,
						index = 17,
						switchParam = 1,
						removeWeapon = {
							900437
						}
					},
					{
						switchType = 1,
						switchTo = 19,
						index = 18,
						switchParam = 8,
						addWeapon = {
							900438
						}
					},
					{
						switchType = 1,
						switchTo = 100,
						index = 19,
						switchParam = 2,
						removeWeapon = {
							900438,
							900085,
							900802
						}
					},
					{
						switchParam = 8,
						switchTo = 101,
						index = 100,
						switchType = 1,
						setAI = 90027,
						addWeapon = {
							900433,
							900437
						}
					},
					{
						switchType = 1,
						switchTo = 102,
						index = 101,
						switchParam = 1,
						removeWeapon = {
							900437
						}
					},
					{
						switchType = 1,
						switchTo = 103,
						index = 102,
						switchParam = 8,
						addWeapon = {
							900438
						}
					},
					{
						switchType = 1,
						switchTo = 104,
						index = 103,
						switchParam = 2,
						removeWeapon = {
							900438,
							900433
						}
					},
					{
						switchType = 1,
						switchTo = 19,
						index = 104,
						switchParam = 18,
						addWeapon = {
							900085,
							900802
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
				monsterTemplateID = 900004,
				score = 0,
				delay = 1,
				moveCast = true,
				reinforceDelay = 5,
				corrdinate = {
					-15,
					0,
					55
				},
				bossData = {
					hpBarNum = 30,
					icon = "Z23"
				},
				phase = {
					{
						switchType = 1,
						switchTo = 1,
						index = 0,
						switchParam = 4,
						addWeapon = {
							900431,
							900112
						}
					},
					{
						switchType = 1,
						switchTo = 2,
						index = 1,
						switchParam = 1.5,
						removeWeapon = {
							900431
						}
					},
					{
						switchParam = 2,
						switchTo = 3,
						index = 2,
						switchType = 1,
						setAI = 90027,
						addWeapon = {
							900432
						}
					},
					{
						switchType = 1,
						switchTo = 4,
						index = 3,
						switchParam = 1,
						addWeapon = {
							900801
						}
					},
					{
						switchType = 1,
						switchTo = 5,
						index = 4,
						switchParam = 1.5,
						removeWeapon = {
							900432,
							900801
						}
					},
					{
						switchType = 1,
						switchTo = 6,
						index = 5,
						switchParam = 2,
						addWeapon = {
							900433
						}
					},
					{
						switchType = 1,
						switchTo = 7,
						index = 6,
						switchParam = 10,
						addWeapon = {
							900802
						}
					},
					{
						switchType = 1,
						switchTo = 8,
						index = 7,
						switchParam = 1,
						setAI = 90004
					},
					{
						switchType = 1,
						switchTo = 9,
						index = 8,
						switchParam = 1,
						removeWeapon = {
							900433,
							900802
						}
					},
					{
						switchType = 1,
						switchTo = 10,
						index = 9,
						switchParam = 6,
						addWeapon = {
							900083
						}
					},
					{
						switchType = 1,
						switchTo = 11,
						index = 10,
						switchParam = 5,
						setAI = 10001
					},
					{
						switchType = 1,
						switchTo = 12,
						index = 11,
						switchParam = 1,
						removeWeapon = {
							900083
						}
					},
					{
						switchType = 1,
						switchTo = 13,
						index = 12,
						switchParam = 1,
						addWeapon = {
							900084
						}
					},
					{
						switchType = 1,
						switchTo = 14,
						index = 13,
						switchParam = 11,
						addWeapon = {
							900802
						}
					},
					{
						switchType = 1,
						switchTo = 15,
						index = 14,
						switchParam = 0.5,
						setAI = 90004
					},
					{
						switchType = 1,
						switchTo = 16,
						index = 15,
						switchParam = 1,
						removeWeapon = {
							900084,
							900802
						}
					},
					{
						switchType = 1,
						switchTo = 17,
						index = 16,
						switchParam = 8,
						addWeapon = {
							900437
						}
					},
					{
						switchType = 1,
						switchTo = 18,
						index = 17,
						switchParam = 1,
						removeWeapon = {
							900437
						}
					},
					{
						switchType = 1,
						switchTo = 19,
						index = 18,
						switchParam = 8,
						addWeapon = {
							900438
						}
					},
					{
						switchType = 1,
						switchTo = 100,
						index = 19,
						switchParam = 2,
						removeWeapon = {
							900438,
							900085,
							900802
						}
					},
					{
						switchParam = 8,
						switchTo = 101,
						index = 100,
						switchType = 1,
						setAI = 90027,
						addWeapon = {
							900433,
							900437
						}
					},
					{
						switchType = 1,
						switchTo = 102,
						index = 101,
						switchParam = 1,
						removeWeapon = {
							900437
						}
					},
					{
						switchType = 1,
						switchTo = 103,
						index = 102,
						switchParam = 8,
						addWeapon = {
							900438
						}
					},
					{
						switchType = 1,
						switchTo = 104,
						index = 103,
						switchParam = 2,
						removeWeapon = {
							900438,
							900433
						}
					},
					{
						switchType = 1,
						switchTo = 19,
						index = 104,
						switchParam = 18,
						addWeapon = {
							900085,
							900802
						}
					}
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 909002,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					55
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
