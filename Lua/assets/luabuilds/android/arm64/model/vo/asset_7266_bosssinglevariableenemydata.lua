local BossSingleVariableEnemyData = class("BossSingleVariableEnemyData", import(".BossSingleEnemyData"))

BossSingleVariableEnemyData.TYPE = {
	EAST = 1,
	SP = 4,
	NORMAL = 2,
	HARD = 3
}

function BossSingleVariableEnemyData:IsContinuousType()
	return true
end

return BossSingleVariableEnemyData
