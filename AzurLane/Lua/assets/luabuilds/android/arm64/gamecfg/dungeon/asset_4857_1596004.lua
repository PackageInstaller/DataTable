local var_0_0 = {
	id = 1596004
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
				delay = 0,
				moveCast = true,
				monsterTemplateID = 15306004,
				corrdinate = {
					5,
					0,
					50
				},
				bossData = {
					hpBarNum = 100,
					icon = ""
				},
				buffList = {},
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
						switchType = 1,
						switchParam = 300,
						index = 1,
						switchTo = 2,
						addBuff = {
							200503
						},
						addWeapon = {},
						removeWeapon = {}
					},
					{
						switchParam = 1.5,
						switchTo = 3,
						index = 2,
						switchType = 1,
						addWeapon = {},
						removeWeapon = {}
					},
					{
						switchType = 1,
						switchParam = 6,
						index = 3,
						switchTo = 4,
						setAI = 10001,
						addBuff = {
							200510
						},
						addWeapon = {},
						removeWeapon = {}
					},
					{
						switchParam = 1.5,
						switchTo = 5,
						index = 4,
						switchType = 1,
						setAI = 70126,
						addWeapon = {},
						removeWeapon = {}
					},
					{
						switchParam = 6.5,
						switchTo = 6,
						index = 5,
						switchType = 1,
						addWeapon = {
							844009
						},
						removeWeapon = {}
					},
					{
						switchParam = 0.5,
						switchTo = 3,
						index = 6,
						switchType = 1,
						addWeapon = {},
						removeWeapon = {
							844009
						}
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
