local var_0_0 = {
	id = 1221201,
	bgm = "story-4"
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 300,
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
		triggerParams = {},
		spawn = {
			{
				score = 0,
				reinforceDelay = 8,
				delay = 1,
				moveCast = true,
				monsterTemplateID = 13400003,
				corrdinate = {
					-10,
					0,
					55
				},
				buffList = {},
				bossData = {
					hpBarNum = 100,
					icon = "bulisuper"
				},
				phase = {
					{
						index = 0,
						switchType = 1,
						switchTo = 1,
						switchParam = 0.8
					},
					{
						switchParam = 10,
						switchTo = 2,
						index = 1,
						switchType = 1,
						setAI = 20006,
						removeWeapon = {
							630033
						},
						addWeapon = {
							630032,
							630036
						}
					},
					{
						switchParam = 5,
						switchTo = 3,
						index = 2,
						switchType = 1,
						setAI = 10001,
						removeWeapon = {
							630036
						},
						addWeapon = {
							630034,
							630035
						}
					},
					{
						switchParam = 9,
						switchTo = 4,
						index = 3,
						switchType = 1,
						setAI = 90003,
						removeWeapon = {
							630034,
							630035
						},
						addWeapon = {
							630031
						}
					},
					{
						switchParam = 9,
						switchTo = 1,
						index = 4,
						switchType = 1,
						setAI = 90003,
						removeWeapon = {
							630031
						},
						addWeapon = {
							630033
						}
					}
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 13400002,
				score = 0,
				delay = 2,
				moveCast = true,
				corrdinate = {
					30,
					0,
					80
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 13400002,
				score = 0,
				delay = 2,
				moveCast = true,
				corrdinate = {
					30,
					0,
					40
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 13400002,
				score = 0,
				delay = 2,
				moveCast = true,
				corrdinate = {
					18,
					0,
					70
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 13400002,
				score = 0,
				delay = 2,
				moveCast = true,
				corrdinate = {
					18,
					0,
					50
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
			201
		},
		triggerParams = {}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {
	vanguard_unitList = {
		{
			oil_at_end = 55,
			configId = 900310,
			energy = 10,
			skinId = 900310,
			exp = 10,
			tmpID = 900310,
			id = 1,
			level = 100,
			equipment = {
				false,
				false,
				false
			},
			properties = {
				cannon = 1000,
				reload = 830,
				luck = 70,
				torpedo = 150,
				durability = 85567,
				air = 0,
				dodge = 164,
				antiaircraft = 310,
				speed = 31.5,
				armor = 98,
				hit = 140
			}
		},
		{
			oil_at_end = 55,
			configId = 900311,
			energy = 10,
			skinId = 900311,
			exp = 10,
			tmpID = 900311,
			id = 2,
			level = 100,
			equipment = {
				false,
				false,
				false
			},
			properties = {
				cannon = 1000,
				reload = 830,
				luck = 70,
				torpedo = 150,
				durability = 85567,
				air = 0,
				dodge = 164,
				antiaircraft = 310,
				speed = 31.5,
				armor = 98,
				hit = 140
			}
		}
	}
}

return var_0_0
