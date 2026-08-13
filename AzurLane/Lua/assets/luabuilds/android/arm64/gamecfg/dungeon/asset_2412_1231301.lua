local var_0_0 = {
	id = 1221201,
	bgm = "bsm-3"
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
				monsterTemplateID = 12200501,
				delay = 1,
				moveCast = true,
				score = 0,
				corrdinate = {
					5,
					0,
					55
				},
				bossData = {
					hpBarNum = 100,
					icon = "bisimai"
				},
				buffList = {
					8636
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
							610180,
							610181,
							610182
						},
						removeWeapon = {
							610193
						}
					},
					{
						switchParam = 3,
						switchTo = 3,
						index = 2,
						switchType = 1,
						removeWeapon = {
							610181,
							610182
						},
						addWeapon = {
							610183,
							610184,
							610186
						}
					},
					{
						switchParam = 3,
						index = 3,
						switchType = 1,
						switchTo = 4,
						setAI = 90029,
						removeWeapon = {
							610186,
							610183
						},
						addWeapon = {
							610187,
							610188,
							610193
						},
						addBuff = {}
					},
					{
						switchType = 1,
						index = 4,
						switchParam = 3,
						setAI = 90029,
						switchTo = 5,
						removeWeapon = {
							610187,
							610188,
							610184
						},
						addWeapon = {
							610189,
							610190,
							610191,
							610192
						},
						removeBuff = {},
						addBuff = {}
					},
					{
						switchTo = 6,
						switchParam = 3,
						index = 5,
						switchType = 1,
						setAI = 10001,
						removeWeapon = {
							610191,
							610192,
							610193
						},
						removeBuff = {},
						addBuff = {}
					},
					{
						switchParam = 3,
						switchTo = 7,
						index = 6,
						switchType = 1,
						removeWeapon = {
							610189,
							610190
						},
						addWeapon = {
							610186,
							610187,
							610188
						}
					},
					{
						switchParam = 3,
						switchTo = 202,
						index = 7,
						switchType = 1,
						setAI = 90029,
						removeWeapon = {
							610186,
							610187,
							610188
						},
						addWeapon = {
							610191,
							610192
						}
					},
					{
						switchParam = 3,
						switchTo = 0,
						index = 202,
						switchType = 1,
						removeWeapon = {
							610191,
							610192
						},
						addWeapon = {
							610193
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
