local var_0_0 = {
	map_id = 10005,
	id = 7000
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 300,
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
		triggerType = 0,
		key = true,
		waveIndex = 101,
		conditionType = 1,
		preWaves = {},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 780,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					5,
					0,
					60
				},
				bossData = {
					hpBarNum = 30,
					icon = "beierfasite"
				},
				phase = {
					{
						switchType = 1,
						switchTo = 1,
						index = 0,
						switchParam = 1,
						removeWeapon = {}
					},
					{
						switchParam = 3.5,
						switchTo = 2,
						index = 1,
						switchType = 1,
						setAI = 10001,
						addWeapon = {
							300577
						},
						removeWeapon = {}
					},
					{
						switchParam = 3,
						switchTo = 3,
						index = 2,
						switchType = 1,
						setAI = 10001,
						addWeapon = {
							300575
						},
						removeWeapon = {
							300577
						}
					},
					{
						switchParam = 1.5,
						switchTo = 4,
						index = 3,
						switchType = 1,
						setAI = 10001,
						addWeapon = {},
						removeWeapon = {}
					},
					{
						switchParam = 3,
						switchTo = 5,
						index = 4,
						switchType = 1,
						addWeapon = {
							300581
						},
						removeWeapon = {
							300575
						}
					},
					{
						switchParam = 1.5,
						switchTo = 8,
						index = 5,
						switchType = 1,
						setAI = 70077,
						addWeapon = {},
						removeWeapon = {
							300581
						}
					},
					{
						switchParam = 2,
						switchTo = 9,
						index = 8,
						switchType = 1,
						addWeapon = {},
						removeWeapon = {
							300584
						}
					},
					{
						switchParam = 2,
						switchTo = 11,
						index = 9,
						switchType = 1,
						addWeapon = {
							300584
						},
						removeWeapon = {}
					},
					{
						switchParam = 2,
						switchTo = 12,
						index = 11,
						switchType = 1,
						addWeapon = {},
						removeWeapon = {
							300584
						}
					},
					{
						switchParam = 2,
						switchTo = 13,
						index = 12,
						switchType = 1,
						addWeapon = {
							300584
						},
						removeWeapon = {}
					},
					{
						switchType = 1,
						switchTo = 1,
						index = 13,
						switchParam = 0.1,
						removeWeapon = {
							300584
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
