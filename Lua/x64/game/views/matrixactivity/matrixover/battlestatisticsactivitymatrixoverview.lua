local var_0_0 = import("game.views.battleResult.statistics.matrix.over.BattleStatisticsMatrixOverView")
local var_0_1 = class("BattleStatisticsActivityMatrixOverView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	arg_1_0.matrix_activity_id = arg_1_0.params_.matrix_activity_id

	var_0_1.super.OnEnter(arg_1_0)
end

function var_0_1.GetGameState(arg_2_0)
	return ActivityMatrixData:GetGameState(arg_2_0.matrix_activity_id)
end

function var_0_1.GetCurrentClearTime(arg_3_0)
	return ActivityMatrixData:GetCurrentClearTime(arg_3_0.matrix_activity_id)
end

function var_0_1.GetMatrixHeroTeam(arg_4_0)
	return ActivityMatrixData:GetMatrixHeroTeam(arg_4_0.matrix_activity_id)
end

function var_0_1.GetHeroData(arg_5_0, arg_5_1)
	return ActivityMatrixData:GetHeroData(arg_5_0.matrix_activity_id, arg_5_1)
end

function var_0_1.GetHeroSkin(arg_6_0, arg_6_1)
	return ActivityMatrixData:GetHeroSkin(arg_6_0.matrix_activity_id, arg_6_1)
end

return var_0_1
