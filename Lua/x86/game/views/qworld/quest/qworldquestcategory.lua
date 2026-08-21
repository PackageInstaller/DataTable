local var_0_0 = class("QWorldQuestCategory", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.typeController_ = arg_3_0.conEx_:GetController("type")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	if arg_5_1 == QWorldQuestConst.QUEST_TASK_TYPE.MAIN then
		arg_5_0.typeController_:SetSelectedState("main")

		arg_5_0.text_.text = GetTips("SANDPLAY_TASK_1")
	elseif arg_5_1 == QWorldQuestConst.QUEST_TASK_TYPE.SIDE then
		arg_5_0.typeController_:SetSelectedState("side")

		arg_5_0.text_.text = GetTips("SANDPLAY_TASK_2")
	elseif arg_5_1 == QWorldQuestConst.QUEST_TASK_TYPE.EXPLORE then
		arg_5_0.typeController_:SetSelectedState("explore")

		arg_5_0.text_.text = GetTips("SANDPLAY_TASK_3")
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
