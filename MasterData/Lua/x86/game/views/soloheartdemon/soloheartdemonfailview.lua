NewBattleFailedWithButtonView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedWithButtonView")

local SoloHeartDemonFailView = class("SoloHeartDemonFailView", NewBattleFailedWithButtonView)

function SoloHeartDemonFailView:OnExit()
	SoloHeartDemonFailView.super.OnExit(self)

	local var_1_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas

	SoloHeartDemonData:UpdateBattleFinishData(1, nil, nil, nil, (var_1_0:TryGetValue(8, nil) or nil) and (var_1_0[8] or 0), nil, self.params_.stageData:GetDest())
end

return SoloHeartDemonFailView
