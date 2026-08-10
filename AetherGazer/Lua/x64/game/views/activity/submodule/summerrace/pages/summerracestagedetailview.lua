local var_0_0 = class("SummerRaceStageDetailView", SummerRaceModifyView)
local var_0_1 = "stageDetail"

function var_0_0.GetForcedEntryPanelType(arg_1_0)
	return var_0_1
end

function var_0_0.BuildStageDetailPanelModel(arg_2_0)
	return SummerRaceData:GetStageDetailModel(arg_2_0.stageId_)
end

function var_0_0.BuildInfoPanelModel(arg_3_0)
	return arg_3_0:BuildStageDetailPanelModel()
end

function var_0_0.ApplyInfoPanelModel(arg_4_0, arg_4_1)
	arg_4_0.stageId_ = arg_4_1.stageInfo.stageId

	arg_4_0.battleInfoView_:ApplyStageDetailModel(arg_4_1)
end

function var_0_0.HandleStageBattleStart(arg_5_0)
	SummerRaceAction.EnterStageBattle(arg_5_0.stageId_, var_0_1)
end

return var_0_0
