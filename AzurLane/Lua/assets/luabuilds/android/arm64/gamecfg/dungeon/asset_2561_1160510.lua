local var_0_0 = {
	id = 1012500,
	map_id = 10008,
	bgm = "battle-uta"
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 300,
	backGroundStageID = 1,
	passCondition = 1,
	totalArea = {
		-80,
		20,
		90,
		70
	},
	playerArea = {
		-80,
		20,
		45,
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
		waveIndex = 106,
		conditionType = 0,
		preWaves = {
			101
		},
		triggerParam = {},
		spawn = {
			{
				score = 0,
				monsterTemplateID = 11600501,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					70
				},
				bossData = {
					hpBarNum = 100,
					icon = "jiuyuan"
				}
			},
			{
				score = 0,
				monsterTemplateID = 11600502,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					50
				},
				bossData = {
					hpBarNum = 100,
					icon = "fumilulu"
				}
			}
		}
	},
	{
		triggerType = 8,
		waveIndex = 900,
		preWaves = {
			106
		},
		triggerParams = {}
	},
	{
		triggerType = 1,
		key = true,
		waveIndex = 211,
		conditionType = 0,
		preWaves = {
			900
		},
		triggerParams = {
			timeout = 0.5
		}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
