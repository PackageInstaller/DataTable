local var_0_0 = {
	id = 1422113
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
			500
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 13900221,
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
				monsterTemplateID = 13900226,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					55
				}
			},
			{
				monsterTemplateID = 13900221,
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
				monsterTemplateID = 13900227,
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
				monsterTemplateID = 13900221,
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
				monsterTemplateID = 13900223,
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
				monsterTemplateID = 13900223,
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
				monsterTemplateID = 13900221,
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
			102,
			101
		},
		triggerParams = {
			bgm = "battle-boss-3"
		}
	},
	{
		triggerType = 3,
		waveIndex = 500,
		preWaves = {
			100
		},
		triggerParams = {
			id = "YONGYEHUANGUANG17"
		}
	},
	{
		triggerType = 3,
		key = true,
		waveIndex = 501,
		preWaves = {
			900
		},
		triggerParams = {
			id = "YONGYEHUANGUANG18"
		}
	},
	{
		triggerType = 0,
		waveIndex = 104,
		conditionType = 0,
		preWaves = {
			102,
			101
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 13900283,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					55
				},
				bossData = {
					hpBarNum = 60,
					icon = "ganraozhe_ii"
				},
				buffList = {},
				phase = {
					{
						switchParam = 1,
						switchTo = 1,
						index = 0,
						switchType = 1,
						setAI = 10001,
						addWeapon = {},
						removeWeapon = {}
					},
					{
						switchParam = 2.5,
						switchTo = 2,
						index = 1,
						switchType = 1,
						addWeapon = {
							680249,
							680250
						},
						removeWeapon = {
							680252
						}
					},
					{
						switchParam = 0.5,
						switchTo = 3,
						index = 2,
						switchType = 1,
						addWeapon = {},
						removeWeapon = {
							680249,
							680250
						}
					},
					{
						switchParam = 3,
						switchTo = 4,
						index = 3,
						switchType = 1,
						addWeapon = {
							680249,
							680250
						},
						removeWeapon = {}
					},
					{
						switchParam = 4.5,
						switchTo = 5,
						index = 4,
						switchType = 1,
						setAI = 70093,
						addWeapon = {
							680251
						},
						removeWeapon = {
							680249,
							680250
						}
					},
					{
						switchParam = 1,
						switchTo = 6,
						index = 5,
						switchType = 1,
						addWeapon = {
							680247,
							680253
						},
						removeWeapon = {
							680251
						}
					},
					{
						switchParam = 3,
						switchTo = 7,
						index = 6,
						switchType = 1,
						addWeapon = {
							680248
						},
						removeWeapon = {}
					},
					{
						switchParam = 2.5,
						switchTo = 8,
						index = 7,
						switchType = 1,
						addWeapon = {
							680246
						},
						removeWeapon = {}
					},
					{
						switchParam = 2,
						switchTo = 9,
						index = 8,
						switchType = 1,
						setAI = 10001,
						addWeapon = {},
						removeWeapon = {
							680246,
							680247,
							680248,
							680253
						}
					},
					{
						switchParam = 1,
						switchTo = 0,
						index = 9,
						switchType = 1,
						addWeapon = {
							680252
						},
						removeWeapon = {}
					}
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 13900223,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-3,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 13900221,
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
			},
			{
				monsterTemplateID = 13900223,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-3,
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
		waveIndex = 2001,
		conditionType = 1,
		preWaves = {
			100
		},
		triggerParam = {},
		spawn = {},
		reinforcement = {
			{
				monsterTemplateID = 13900215,
				delay = 5,
				moveCast = true,
				corrdinate = {
					5,
					0,
					65
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
			104
		},
		triggerParams = {}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
