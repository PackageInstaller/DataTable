local var_0_0 = {
	lose_condition = 1,
	win_condition = 1,
	map_id = 10001,
	type = 1,
	id = 320001
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 600,
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
		60,
		68
	},
	enemyArea = {},
	fleetCorrdinate = {
		-80,
		0,
		50
	}
}
local var_0_3 = {
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
			timeout = 160
		}
	}
}
local var_0_4 = {
	triggerType = 0,
	key = true,
	waveIndex = 101,
	conditionType = 1,
	preWaves = {
		100
	},
	triggerParam = {}
}
local var_0_5 = {}
local var_0_6 = {
	monsterTemplateID = 211000,
	score = 0,
	delay = 0,
	moveCast = true,
	corrdinate = {
		6,
		0,
		50
	},
	bossData = {
		hpBarNum = 888,
		icon = "unknown3"
	},
	buffList = {
		8001,
		8007
	}
}
local var_0_7 = {
	{
		switchParam = 30,
		switchTo = 1,
		index = 0,
		switchType = 1,
		setAI = 20006,
		addWeapon = {
			2150011,
			2150012
		}
	}
}
local var_0_8 = {
	switchTo = 2,
	switchParam = 30,
	index = 1,
	switchType = 1,
	removeWeapon = {
		2150011,
		2150012
	},
	addWeapon = {
		2150021,
		2150022
	}
}

a = var_9
var_0_8[1] = var_9
var_0_7[2] = var_0_8
var_0_7[3] = {
	switchParam = 30,
	switchTo = 3,
	index = 2,
	switchType = 1,
	removeWeapon = {
		2150021,
		2150022
	},
	addWeapon = {
		2150031
	}
}
var_0_7[4] = {
	switchParam = 30,
	switchTo = 4,
	index = 3,
	switchType = 1,
	removeWeapon = {
		2150031
	},
	addWeapon = {
		2150041,
		2150042
	}
}
var_0_7[5] = {
	switchParam = 100,
	switchTo = 5,
	index = 4,
	switchType = 1,
	removeWeapon = {
		2150041,
		2150042
	},
	addWeapon = {
		2150051
	}
}
var_0_7[6] = {
	switchType = 1,
	switchTo = 6,
	index = 5,
	switchParam = 1,
	removeWeapon = {
		2140018
	}
}
var_0_7[7] = {
	switchType = 1,
	switchTo = 7,
	index = 6,
	switchParam = 20,
	addWeapon = {
		2140021
	}
}
var_0_7[8] = {
	switchType = 1,
	switchTo = 8,
	index = 7,
	switchParam = 1,
	removeWeapon = {
		2140021
	}
}
var_0_7[9] = {
	switchType = 1,
	switchTo = 9,
	index = 8,
	switchParam = 20,
	addWeapon = {
		2140016,
		2140022
	}
}
var_0_7[10] = {
	switchType = 1,
	switchTo = 10,
	index = 9,
	switchParam = 1,
	removeWeapon = {
		2140016,
		2140022
	}
}
var_0_7[11] = {
	switchType = 1,
	switchTo = 11,
	index = 10,
	switchParam = 20,
	addWeapon = {
		2140018,
		2140023
	}
}
var_0_7[12] = {
	switchType = 1,
	switchTo = 12,
	index = 11,
	switchParam = 1,
	removeWeapon = {
		2140018,
		2140023
	}
}
var_0_7[13] = {
	switchType = 1,
	switchTo = 0,
	index = 12,
	switchParam = 500,
	addWeapon = {
		2130034,
		2130035
	}
}
var_0_6.phase = var_0_7
var_0_5[1] = var_0_6
var_0_4.spawn = var_0_5
var_0_3[3] = var_0_4
var_0_3[4] = {
	triggerType = 0,
	key = true,
	waveIndex = 102,
	conditionType = 1,
	preWaves = {
		101,
		202
	},
	triggerParam = {},
	spawn = {
		{
			monsterTemplateID = 211001,
			score = 0,
			delay = 0,
			moveCast = true,
			corrdinate = {
				20,
				0,
				80
			},
			buffList = {
				8001,
				8007
			}
		},
		{
			monsterTemplateID = 211001,
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
			monsterTemplateID = 211001,
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
		},
		{
			monsterTemplateID = 211001,
			score = 0,
			delay = 0,
			moveCast = true,
			corrdinate = {
				20,
				0,
				30
			},
			buffList = {
				8001,
				8007
			}
		}
	}
}
var_0_3[5] = {
	triggerType = 8,
	waveIndex = 900,
	preWaves = {
		103
	},
	triggerParams = {}
}
var_0_2.waves = var_0_3
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
