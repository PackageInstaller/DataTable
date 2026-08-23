local var_0_0 = {}
local var_0_1 = g.core.const.ConstMgr.TowerConst

function var_0_0.getModelDataByType(arg_1_0, arg_1_1)
	if arg_1_1 and arg_1_1 == var_0_1.TOWER_DIFFICULTY.HARD then
		return g.core.model.User.towerHardData
	else
		return g.core.model.User.towerData
	end
end

function var_0_0.getMultiTeamType(arg_2_0, arg_2_1)
	return ({
		[var_0_1.STAGE_TYPE_HARD.MAIN] = 4,
		[var_0_1.STAGE_TYPE_HARD.JIAO_GUO] = 5,
		[var_0_1.STAGE_TYPE_HARD.LIN_DONG] = 6,
		[var_0_1.STAGE_TYPE_HARD.DONG_XI] = 7,
		[var_0_1.STAGE_TYPE_HARD.LI_JIN] = 8
	})[arg_2_1]
end

return var_0_0
