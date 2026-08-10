NewBattleFailedWithButtonView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedWithButtonView")

local var_0_0 = class("SoloHeartDemonFailView", NewBattleFailedWithButtonView)

function var_0_0.OnExit(arg_1_0)
	var_0_0.super.OnExit(arg_1_0)

	local var_1_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas
	local var_1_1
	local var_1_2 = 0

	if var_1_0:TryGetValue(8, var_1_1) then
		var_1_2 = var_1_0[8] or 0
	end

	SoloHeartDemonData:UpdateBattleFinishData(1, nil, nil, nil, var_1_2, nil, arg_1_0.params_.stageData:GetDest())
end

return var_0_0
