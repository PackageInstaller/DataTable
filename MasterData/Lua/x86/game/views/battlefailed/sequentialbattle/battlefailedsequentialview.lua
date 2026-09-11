NewBattleFailedWithButtonView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedWithButtonView")

local BattleFailedSequentialView = class("BattleFailedSequentialView", NewBattleFailedWithButtonView)

function BattleFailedSequentialView:OnClickRestart()
	local var_1_0 = self.params_.stageData:GetActivityID()
	local var_1_1 = SequentialBattleData:GetCurrentFinishStageIndex(var_1_0) + 1

	BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE, SequentialBattleChapterCfg[var_1_0].stage_id[var_1_1], var_1_0, (ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, var_1_0, var_1_1, {
		stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
		stageID = SequentialBattleChapterCfg[var_1_0].stage_id[var_1_1],
		activityID = var_1_0
	})))))
end

function BattleFailedSequentialView:OnClickBack()
	local var_2_0 = self.params_.stageData:GetActivityID()

	self:QuitUI()
end

return BattleFailedSequentialView
