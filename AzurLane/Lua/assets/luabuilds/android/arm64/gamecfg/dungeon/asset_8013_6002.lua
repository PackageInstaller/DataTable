local var_0_0 = {
	map_id = 10005,
	id = 6002
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
				reinforceDelay = 10,
				delay = 1,
				moveCast = true,
				monsterTemplateID = 752,
				pilotAITemplateID = 10001,
				corrdinate = {
					-12,
					0,
					63
				},
				bossData = {
					hpBarNum = 156,
					icon = "ligen"
				},
				buffList = {
					8603,
					8045,
					8046
				},
				phase = {
					{
						switchType = 1,
						switchTo = 1,
						index = 0,
						switchParam = 5,
						setAI = 10001
					},
					{
						switchType = 1,
						switchTo = 0,
						index = 1,
						switchParam = 3,
						setAI = 20003
					}
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 753,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					65
				}
			},
			{
				monsterTemplateID = 753,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					14,
					0,
					50
				}
			},
			{
				monsterTemplateID = 753,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					35
				}
			},
			{
				monsterTemplateID = 755,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					35,
					0,
					58
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
					35,
					0,
					42
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
		conditionType = 1,
		preWaves = {
			101
		},
		triggerParam = {}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
