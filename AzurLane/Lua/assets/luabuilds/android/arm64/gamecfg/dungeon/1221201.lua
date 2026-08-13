local var_0_0 = {
	id = 1221201,
	bgm = "ai-mw-inst"
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
				monsterTemplateID = 12100621,
				delay = 1,
				moveCast = true,
				score = 0,
				corrdinate = {
					15,
					0,
					55
				},
				bossData = {
					hpBarNum = 100,
					icon = "aijiang"
				},
				buffList = {},
				phase = {
					{
						index = 0,
						switchType = 1,
						switchTo = 1,
						switchParam = 1
					},
					{
						switchType = 1,
						switchTo = 2,
						index = 1,
						switchParam = 3,
						addWeapon = {
							609123,
							609124,
							609129
						}
					},
					{
						switchParam = 3,
						switchTo = 3,
						index = 2,
						switchType = 1,
						removeWeapon = {
							609123,
							609124
						},
						addWeapon = {
							609121,
							609122,
							609136
						}
					},
					{
						switchParam = 3,
						index = 3,
						switchType = 1,
						switchTo = 4,
						setAI = 90029,
						removeWeapon = {
							609121
						},
						addWeapon = {
							609125,
							609126
						},
						addBuff = {}
					},
					{
						switchType = 1,
						index = 4,
						switchParam = 3,
						switchTo = 5,
						removeWeapon = {
							609125,
							609126
						},
						addWeapon = {
							609128
						},
						removeBuff = {},
						addBuff = {}
					},
					{
						switchType = 1,
						index = 5,
						switchParam = 3,
						setAI = 10001,
						switchTo = 6,
						removeWeapon = {
							609128
						},
						addWeapon = {
							609127,
							609121,
							609137
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
							609127
						},
						addWeapon = {
							609130,
							609131
						}
					},
					{
						switchParam = 3,
						switchTo = 202,
						index = 7,
						switchType = 1,
						removeWeapon = {
							609122,
							609136,
							609137
						},
						addWeapon = {
							609135,
							609128
						}
					},
					{
						switchType = 1,
						switchTo = 2,
						index = 202,
						switchParam = 3,
						removeWeapon = {
							609135,
							609128
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
