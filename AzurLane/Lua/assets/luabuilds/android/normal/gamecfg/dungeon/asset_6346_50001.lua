local var_0_0 = {
	lose_condition = 1,
	win_condition = 1,
	map_id = 50001,
	type = 11,
	id = 50001
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 300,
	backGroundStageID = 1,
	passCondition = 1,
	totalArea = {
		-90,
		20,
		140,
		70
	},
	playerArea = {
		-80,
		20,
		35,
		68
	},
	enemyArea = {}
}
local var_0_3 = {}
local var_0_4 = {}

Vector3 = var_0_10005
var_0_4[1] = var_0_10005(-85, 0, 58)
Vector3 = var_5
var_0_4[2] = var_5(-85, 0, 78)
Vector3 = var_5
var_0_4[3] = var_5(-85, 0, 38)
var_0_3[1] = var_0_4

local var_0_5 = {}

Vector3 = var_5
var_0_5[1] = var_5(5, 0, 58)
Vector3 = var_5
var_0_5[2] = var_5(5, 0, 78)
Vector3 = var_5
var_0_5[3] = var_5(5, 0, 38)
var_0_3[-1] = var_0_5
var_0_2.mainUnitPosition = var_0_3
var_0_2.fleetCorrdinate = {
	-50,
	0,
	60
}
var_0_2.rivalCorrdinate = {
	-20,
	0,
	60
}
var_0_2.waves = {}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
