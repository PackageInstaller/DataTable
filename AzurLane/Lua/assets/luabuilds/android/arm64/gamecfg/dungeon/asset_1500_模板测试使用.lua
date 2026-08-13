local var_0_0 = {
	map_id = 10005,
	id = 101110
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 1800,
	backGroundStageID = 1,
	passCondition = 1,
	totalArea = {
		-45,
		20,
		90,
		70
	},
	playerArea = {
		-45,
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
	-52,
	0,
	60
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
		waveIndex = 101,
		conditionType = 1,
		preWaves = {
			100
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					55
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
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
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					55
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
				}
			}
		}
	},
	{
		triggerType = 0,
		waveIndex = 103,
		conditionType = 1,
		preWaves = {
			102
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					55
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
				}
			}
		}
	},
	{
		triggerType = 0,
		waveIndex = 104,
		conditionType = 1,
		preWaves = {
			103
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					65
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					45
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
				}
			}
		}
	},
	{
		triggerType = 0,
		waveIndex = 105,
		conditionType = 1,
		preWaves = {
			104
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					65
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					45
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
				}
			}
		}
	},
	{
		triggerType = 0,
		waveIndex = 106,
		conditionType = 1,
		preWaves = {
			105
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 3,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 3,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
				}
			}
		}
	},
	{
		triggerType = 0,
		waveIndex = 107,
		conditionType = 1,
		preWaves = {
			106
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					65
				}
			},
			{
				monsterTemplateID = 1003,
				delay = 0,
				corrdinate = {
					25,
					0,
					55
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					45
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
				}
			}
		}
	},
	{
		triggerType = 0,
		waveIndex = 108,
		conditionType = 1,
		preWaves = {
			107
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 3,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1003,
				delay = 0,
				corrdinate = {
					25,
					0,
					55
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 3,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
				}
			}
		}
	},
	{
		triggerType = 0,
		waveIndex = 109,
		conditionType = 1,
		preWaves = {
			108
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1003,
				delay = 0,
				corrdinate = {
					25,
					0,
					55
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					55
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
				}
			}
		}
	},
	{
		triggerType = 0,
		waveIndex = 110,
		conditionType = 1,
		preWaves = {
			109
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 3,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1003,
				delay = 0,
				corrdinate = {
					25,
					0,
					65
				}
			},
			{
				monsterTemplateID = 1003,
				delay = 0,
				corrdinate = {
					25,
					0,
					45
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 3,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
				}
			}
		}
	},
	{
		triggerType = 0,
		waveIndex = 111,
		conditionType = 1,
		preWaves = {
			110
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1003,
				delay = 0,
				corrdinate = {
					25,
					0,
					65
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					55
				}
			},
			{
				monsterTemplateID = 1003,
				delay = 0,
				corrdinate = {
					25,
					0,
					45
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
				}
			}
		}
	},
	{
		triggerType = 0,
		waveIndex = 112,
		conditionType = 1,
		preWaves = {
			111
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					65
				}
			},
			{
				monsterTemplateID = 1003,
				delay = 0,
				corrdinate = {
					25,
					0,
					65
				}
			},
			{
				monsterTemplateID = 1003,
				delay = 0,
				corrdinate = {
					25,
					0,
					45
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					45
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
				}
			}
		}
	},
	{
		triggerType = 0,
		waveIndex = 113,
		conditionType = 1,
		preWaves = {
			112
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 3,
				moveCast = true,
				corrdinate = {
					40,
					0,
					80
				}
			},
			{
				monsterTemplateID = 1003,
				delay = 0,
				corrdinate = {
					25,
					0,
					65
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					55
				}
			},
			{
				monsterTemplateID = 1003,
				delay = 0,
				corrdinate = {
					25,
					0,
					45
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 0,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
				}
			},
			{
				monsterTemplateID = 1000,
				delay = 3,
				moveCast = true,
				corrdinate = {
					40,
					0,
					30
				}
			}
		}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
