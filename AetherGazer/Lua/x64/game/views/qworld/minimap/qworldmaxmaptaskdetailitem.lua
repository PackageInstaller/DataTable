local var_0_0 = class("QWorldMaxMapTaskDetailItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.finishController_ = arg_2_0.m_controller:GetController("compelet")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.questId_ = arg_3_1

	arg_3_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = SandplayTaskCfg[arg_4_0.questId_]

	arg_4_0.m_text.text = var_4_0.task_target

	local var_4_1 = QWorldQuestTool.GetQuestStatus(arg_4_0.questId_)

	arg_4_0.finishController_:SetSelectedState(var_4_1 == QWorldQuestConst.QUEST_STATUS.FINISH and "true" or "false")
end

return var_0_0
