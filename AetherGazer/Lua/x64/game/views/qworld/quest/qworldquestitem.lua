local var_0_0 = class("QWorldQuestItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.finishController_ = arg_2_0.conEx_:GetController("finish")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.questId_ = arg_5_1

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = SandplayTaskCfg[arg_6_0.questId_]

	arg_6_0.objectiveText_.text = var_6_0.task_target
	arg_6_0.progressText_.text = QWorldQuestTool.GetQuestProgressText(arg_6_0.questId_)

	local var_6_1 = QWorldQuestTool.GetQuestStatus(arg_6_0.questId_)

	arg_6_0.finishController_:SetSelectedState(var_6_1 == QWorldQuestConst.QUEST_STATUS.FINISH and "true" or "false")
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
