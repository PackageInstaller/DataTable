local var_0_0 = {
	id = 1060500
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
				monsterTemplateID = 10070501,
				score = 0,
				delay = 1,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					55
				},
				bossData = {
					hpBarNum = 100,
					icon = "ceshizhe"
				},
				phase = {
					{
						switchType = 1,
						switchTo = 1,
						index = 0,
						switchParam = 1,
						setAI = 90004
					},
					{
						switchType = 1,
						switchTo = 2,
						index = 1,
						switchParam = 2.5,
						addWeapon = {
							594001,
							594003,
							594002,
							594004
						}
					},
					{
						switchParam = 2.5,
						switchTo = 3,
						index = 2,
						switchType = 1,
						removeWeapon = {
							594003
						},
						addWeapon = {}
					},
					{
						switchParam = 3,
						switchTo = 4,
						index = 3,
						switchType = 1,
						removeWeapon = {
							594001
						},
						addWeapon = {
							594005,
							594006
						}
					},
					{
						switchType = 1,
						switchTo = 5,
						index = 4,
						switchParam = 3,
						addWeapon = {
							594015
						}
					},
					{
						switchParam = 2,
						switchTo = 6,
						index = 5,
						switchType = 1,
						setAI = 10001,
						addWeapon = {
							594001
						},
						removeWeapon = {
							594015,
							594005,
							594006
						}
					},
					{
						switchType = 1,
						switchTo = 7,
						index = 6,
						switchParam = 2,
						addWeapon = {
							594004
						}
					},
					{
						switchType = 1,
						switchTo = 8,
						index = 7,
						switchParam = 1,
						removeWeapon = {
							594002
						}
					},
					{
						switchType = 1,
						switchTo = 9,
						index = 8,
						switchParam = 10,
						addWeapon = {
							594016
						}
					},
					{
						switchType = 1,
						switchTo = 10,
						index = 9,
						switchParam = 2,
						removeWeapon = {
							594016
						}
					},
					{
						switchType = 1,
						switchTo = 200,
						index = 10,
						switchParam = 3,
						removeWeapon = {
							594001
						}
					},
					{
						switchParam = 2,
						switchTo = 201,
						index = 200,
						switchType = 1,
						setAI = 10001,
						addWeapon = {
							594016
						}
					},
					{
						switchType = 1,
						switchTo = 202,
						index = 201,
						switchParam = 15,
						addWeapon = {
							594002
						}
					},
					{
						switchParam = 2,
						switchTo = 0,
						index = 202,
						switchType = 1,
						setAI = 90004,
						removeWeapon = {
							594016
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
