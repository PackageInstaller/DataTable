local var_0_0 = {
	id = 1729004
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 60,
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
		key = true,
		waveIndex = 101,
		conditionType = 0,
		preWaves = {
			100
		},
		triggerParam = {},
		spawn = {
			{
				score = 0,
				monsterTemplateID = 16529401,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-5,
					0,
					55
				},
				bossData = {
					hpBarNum = 100,
					icon = ""
				},
				phase = {
					{
						switchParam = 1.5,
						switchTo = 1,
						index = 0,
						switchType = 1,
						setAI = 20006,
						addWeapon = {},
						removeWeapon = {}
					},
					{
						switchParam = 5,
						switchTo = 2,
						index = 1,
						switchType = 1,
						setAI = 10001,
						addWeapon = {
							3065403,
							3065402
						},
						removeWeapon = {}
					},
					{
						switchParam = 12,
						switchTo = 3,
						index = 2,
						switchType = 1,
						addWeapon = {
							3065404,
							3065401
						},
						removeWeapon = {
							3065403,
							3065402
						}
					},
					{
						switchType = 1,
						switchParam = 17,
						index = 3,
						switchTo = 4,
						addBuff = {
							200483
						},
						addWeapon = {
							3065407
						},
						removeWeapon = {
							3065404,
							3065401
						}
					},
					{
						switchParam = 0.5,
						switchTo = 5,
						index = 4,
						switchType = 1,
						setAI = 70125,
						addWeapon = {},
						removeWeapon = {
							3065407
						}
					},
					{
						switchType = 1,
						switchParam = 24,
						index = 5,
						switchTo = 1,
						addBuff = {
							200484
						},
						addWeapon = {},
						removeWeapon = {}
					}
				}
			}
		}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
