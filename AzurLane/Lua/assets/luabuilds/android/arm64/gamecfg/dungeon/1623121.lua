local var_0_0 = {
	id = 1623121
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
				monsterTemplateID = 15603001,
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
				monsterTemplateID = 15603101,
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
				monsterTemplateID = 15603001,
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
				monsterTemplateID = 15603102,
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
				monsterTemplateID = 15603002,
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
				monsterTemplateID = 15603003,
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
				monsterTemplateID = 15603003,
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
				monsterTemplateID = 15603002,
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
			bgm = "battle-arcticocean"
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
				monsterTemplateID = 15603302,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-5,
					0,
					55
				},
				bossData = {
					hpBarNum = 60,
					icon = "sairenzhanlie_M"
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 15603002,
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
				monsterTemplateID = 15603002,
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
		waveIndex = 2001,
		conditionType = 1,
		preWaves = {
			100
		},
		triggerParam = {},
		spawn = {},
		reinforcement = {
			{
				monsterTemplateID = 15603007,
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
		triggerType = 0,
		waveIndex = 3001,
		conditionType = 1,
		preWaves = {
			100
		},
		blockFlags = {
			8918
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 15603902,
				delay = 0,
				moveCast = true,
				corrdinate = {
					60,
					0,
					55
				},
				phase = {
					{
						index = 0,
						switchType = 1,
						switchTo = 1,
						switchParam = 1
					},
					{
						switchType = 1,
						switchTo = 0,
						index = 1,
						switchParam = 29,
						addBuff = {
							8921
						}
					}
				}
			},
			{
				monsterTemplateID = 15603902,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					55
				},
				phase = {
					{
						index = 0,
						switchType = 1,
						switchTo = 1,
						switchParam = 0.5
					},
					{
						switchType = 1,
						switchTo = 0,
						index = 1,
						switchParam = 180,
						addWeapon = {
							879105
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
