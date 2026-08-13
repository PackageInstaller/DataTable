local var_0_0 = {
	map_id = 10001,
	id = 1201120
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 180,
	backGroundStageID = 1,
	passCondition = 1,
	totalArea = {
		-70,
		20,
		90,
		70
	},
	playerArea = {
		-70,
		20,
		37,
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
		waveIndex = 1001,
		preWaves = {},
		triggerParams = {
			timeout = 1
		}
	},
	{
		triggerType = 1,
		waveIndex = 1002,
		preWaves = {},
		triggerParams = {
			timeout = 15
		}
	},
	{
		triggerType = 1,
		waveIndex = 1003,
		preWaves = {},
		triggerParams = {
			timeout = 30
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 2001,
		conditionType = 1,
		preWaves = {
			1001
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 12037,
				delay = 0,
				moveCast = true,
				corrdinate = {
					5,
					0,
					85
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
						switchParam = 10,
						setAI = 20007
					},
					{
						switchType = 1,
						dive = "STATE_RAID",
						index = 1,
						switchParam = 10,
						setAI = 20009
					}
				}
			}
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 2002,
		conditionType = 1,
		preWaves = {
			1002,
			2001
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 12037,
				delay = 0,
				moveCast = true,
				corrdinate = {
					5,
					0,
					30
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
						switchParam = 10,
						setAI = 20008
					},
					{
						switchType = 1,
						dive = "STATE_DIVE",
						index = 1,
						switchParam = 10,
						setAI = 20009
					}
				}
			}
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 2003,
		conditionType = 1,
		preWaves = {
			1003,
			2002
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 12037,
				delay = 0,
				moveCast = true,
				corrdinate = {
					5,
					0,
					85
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
						switchParam = 10,
						setAI = 20007
					},
					{
						switchType = 1,
						dive = "STATE_RAID",
						index = 1,
						switchParam = 10,
						setAI = 20009
					}
				}
			},
			{
				monsterTemplateID = 12037,
				delay = 0,
				moveCast = true,
				corrdinate = {
					5,
					0,
					30
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
						switchParam = 10,
						setAI = 20008
					},
					{
						switchType = 1,
						dive = "STATE_RAID",
						index = 1,
						switchParam = 10,
						setAI = 20009
					}
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 12039,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					40
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 12039,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					70
				},
				buffList = {
					8001,
					8002
				}
			}
		}
	},
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
			timeout = 15
		}
	},
	{
		triggerType = 1,
		waveIndex = 203,
		preWaves = {},
		triggerParams = {
			timeout = 30
		}
	},
	{
		triggerType = 1,
		waveIndex = 204,
		preWaves = {},
		triggerParams = {
			timeout = 50
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
				monsterTemplateID = 12003,
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
				monsterTemplateID = 12004,
				score = 0,
				delay = 0,
				moveCast = true,
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
				monsterTemplateID = 12010,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					55
				}
			},
			{
				monsterTemplateID = 12004,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					20,
					0,
					55
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 12003,
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
				interval = 1,
				onceNumber = 6,
				formation = 10006,
				templateID = 330020,
				delay = 0,
				totalNumber = 6,
				weaponID = {
					330009
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
				monsterTemplateID = 12011,
				score = 0,
				reinforceDelay = 6,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					70
				}
			},
			{
				monsterTemplateID = 12012,
				score = 0,
				reinforceDelay = 6,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					40
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 12006,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					65
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 12006,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					45
				},
				buffList = {
					8001,
					8007
				}
			}
		},
		airFighter = {
			{
				interval = 1,
				onceNumber = 6,
				formation = 10006,
				templateID = 330020,
				delay = 0,
				totalNumber = 6,
				weaponID = {
					330009
				},
				attr = {
					airPower = 40,
					maxHP = 999,
					attackRating = 23
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
				monsterTemplateID = 12034,
				score = 0,
				delay = 0,
				moveCast = true,
				reinforceDelay = 6,
				corrdinate = {
					10,
					0,
					55
				},
				buffList = {
					8050,
					8051
				}
			},
			{
				monsterTemplateID = 12015,
				score = 0,
				delay = 0,
				moveCast = true,
				reinforceDelay = 6,
				corrdinate = {
					15,
					0,
					55
				},
				buffList = {
					8050,
					8051
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 12002,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					70
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 12002,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
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
		triggerType = 8,
		waveIndex = 900,
		conditionType = 0,
		preWaves = {
			103,
			2003
		},
		triggerParams = {}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
