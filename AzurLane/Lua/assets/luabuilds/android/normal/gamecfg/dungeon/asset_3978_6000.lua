local var_0_0 = {
	map_id = 10005,
	id = 6000
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 90,
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
				monsterTemplateID = 753,
				pilotAITemplateID = 20005,
				delay = 1,
				moveCast = true,
				score = 0,
				corrdinate = {
					0,
					0,
					60
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 753,
				pilotAITemplateID = 20005,
				delay = 1,
				moveCast = true,
				score = 0,
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
		},
		airFighter = {
			{
				interval = 10,
				onceNumber = 2,
				formation = 10006,
				templateID = 300501,
				delay = 0,
				totalNumber = 2,
				weaponID = {
					300523
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
		triggerType = 0,
		waveIndex = 102,
		conditionType = 1,
		preWaves = {
			101
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 753,
				pilotAITemplateID = 20005,
				delay = 1,
				moveCast = true,
				score = 0,
				corrdinate = {
					-5,
					0,
					60
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 754,
				score = 0,
				delay = 1,
				moveCast = true,
				corrdinate = {
					10,
					0,
					45
				}
			},
			{
				monsterTemplateID = 753,
				pilotAITemplateID = 20005,
				delay = 1,
				moveCast = true,
				score = 0,
				corrdinate = {
					-5,
					0,
					30
				},
				buffList = {
					8001,
					8007
				}
			},
			airFighter = {
				{
					interval = 10,
					onceNumber = 2,
					formation = 10006,
					templateID = 300501,
					delay = 0,
					totalNumber = 2,
					weaponID = {
						300523
					},
					attr = {
						airPower = 40,
						maxHP = 15,
						attackRating = 23
					}
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
				monsterTemplateID = 750,
				pilotAITemplateID = 40001,
				delay = 1,
				moveCast = true,
				reinforceDelay = 10,
				corrdinate = {
					-3,
					0,
					55
				},
				bossData = {
					hpBarNum = 145,
					icon = "ligen"
				},
				buffList = {
					8601,
					8045,
					8046
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 753,
				pilotAITemplateID = 20005,
				delay = 0,
				moveCast = true,
				score = 0,
				corrdinate = {
					-12,
					0,
					65
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 753,
				pilotAITemplateID = 20005,
				delay = 0,
				moveCast = true,
				score = 0,
				corrdinate = {
					-12,
					0,
					30
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 754,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					75
				}
			},
			{
				monsterTemplateID = 754,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					20
				}
			},
			{
				monsterTemplateID = 755,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					75
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 755,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					45
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 755,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					30,
					0,
					25
				},
				buffList = {
					8001,
					8002
				}
			}
		},
		airFighter = {
			{
				interval = 10,
				onceNumber = 3,
				formation = 10006,
				templateID = 300502,
				delay = 0,
				totalNumber = 6,
				weaponID = {
					300524
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
		triggerType = 8,
		key = true,
		waveIndex = 900,
		preWaves = {
			103
		},
		triggerParams = {}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
