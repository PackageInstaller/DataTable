local var_0_0 = class("BossSingleVariableEnemyData", import(".BossSingleEnemyData"))

var_0_0.TYPE = {
	EAST = 1,
	SP = 4,
	NORMAL = 2,
	HARD = 3
}

function var_0_0.IsContinuousType(arg_1_0)
	return true
end

return var_0_0
