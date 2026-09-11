local SummerRaceStageDetailView = class("SummerRaceStageDetailView", SummerRaceModifyView)
local var_0_1 = "stageDetail"

function SummerRaceStageDetailView:GetForcedEntryPanelType()
	return var_0_1
end

function SummerRaceStageDetailView:BuildStageDetailPanelModel()
	return SummerRaceData:GetStageDetailModel(self.stageId_)
end

function SummerRaceStageDetailView:BuildInfoPanelModel()
	return self:BuildStageDetailPanelModel()
end

function SummerRaceStageDetailView:ApplyInfoPanelModel(arg_4_1)
	self.stageId_ = arg_4_1.stageInfo.stageId

	self.battleInfoView_:ApplyStageDetailModel(arg_4_1)
end

function SummerRaceStageDetailView:HandleStageBattleStart()
	SummerRaceAction.EnterStageBattle(self.stageId_, var_0_1)
end

return SummerRaceStageDetailView
