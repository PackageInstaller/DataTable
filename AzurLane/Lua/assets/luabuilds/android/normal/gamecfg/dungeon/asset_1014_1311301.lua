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
				monsterTemplateID = 12901301,
				score = 0,
				delay = 1,
				moveCast = true,
				corrdinate = {
					-10,
					0,
					55
				},
				buffList = {
					8636
				},
				bossData = {
					hpBarNum = 100,
					icon = "nengdai"
				},
				phase = {
					{
						index = 0,
						switchType = 1,
						switchTo = 1,
						switchParam = 1
					},
					{
						switchParam = 3,
						switchTo = 2,
						index = 1,
						switchType = 1,
						setAI = 10001,
						addWeapon = {
							617181,
							617182,
							617183,
							617184
						},
						removeWeapon = {
							617186,
							617187,
							617189,
							617190,
							617188
						}
					},
					{
						switchParam = 5,
						switchTo = 3,
						index = 2,
						switchType = 1,
						setAI = 10001,
						removeWeapon = {
							617184
						},
						addWeapon = {
							617185
						}
					},
					{
						switchParam = 5,
						index = 3,
						switchType = 1,
						switchTo = 4,
						setAI = 90004,
						removeWeapon = {
							617183
						},
						addWeapon = {
							617186,
							617187,
							617188
						},
						addBuff = {}
					},
					{
						switchType = 1,
						index = 4,
						switchParam = 3,
						switchTo = 5,
						removeWeapon = {
							617186,
							617187,
							617188
						},
						addWeapon = {
							617189,
							617190
						},
						removeBuff = {},
						addBuff = {}
					},
					{
						switchType = 1,
						switchParam = 5,
						index = 5,
						switchTo = 6,
						setAI = 10001,
						removeWeapon = {
							617185
						},
						addWeapon = {
							617184,
							617183
						},
						addBuff = {}
					},
					{
						switchParam = 6,
						switchTo = 7,
						index = 6,
						switchType = 1,
						setAI = 10001,
						removeWeapon = {
							617189,
							617190
						},
						addWeapon = {
							617191
						}
					},
					{
						switchParam = 6,
						switchTo = 202,
						index = 7,
						switchType = 1,
						setAI = 90004,
						removeWeapon = {
							617184,
							617183
						},
						addWeapon = {
							617189,
							617190
						}
					},
					{
						switchParam = 5,
						switchTo = 1,
						index = 202,
						switchType = 1,
						addWeapon = {
							617186,
							617187,
							617188
						},
						removeWeapon = {
							617191
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
			201
		},
		triggerParams = {}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
