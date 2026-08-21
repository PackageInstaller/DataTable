NewBattleFailedWithButtonView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedWithButtonView")

local var_0_0 = class("BattleFailedSequentialView", NewBattleFailedWithButtonView)

function var_0_0.OnClickRestart(arg_1_0)
	local var_1_0 = arg_1_0.params_.stageData:GetActivityID()
	local var_1_1 = SequentialBattleData:GetCurrentFinishStageIndex(var_1_0) + 1
	local var_1_2 = var_1_0
	local var_1_3 = var_1_1
	local var_1_4 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, var_1_2, var_1_3, {
		stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
		stageID = SequentialBattleChapterCfg[var_1_0].stage_id[var_1_1],
		activityID = var_1_0
	})
	local var_1_5 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE, SequentialBattleChapterCfg[var_1_0].stage_id[var_1_1], var_1_0, var_1_4)

	BattleController.GetInstance():LaunchBattle(var_1_5)
end

function var_0_0.OnClickBack(arg_2_0)
	local var_2_0 = arg_2_0.params_.stageData:GetActivityID()

	arg_2_0:QuitUI()
end

return var_0_0
