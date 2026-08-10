local var_0_0 = class("QWorldQuestUnlockView", QWorldHintBaseView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay/SandPlay_InScenes/item/SandPlay_QuestUnlock"
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.typeController_ = arg_2_0.conEx_:GetController("quest")

	arg_2_0:AddBtnListener(arg_2_0.trackBtn_, nil, function()
		if arg_2_0.mainQuestId_ == QWorldQuestTool.GetMainQuestTrackingId() then
			return
		end

		QWorldQuestAction.UpdateTrackingMainQuestId(arg_2_0.mainQuestId_, function()
			QWorldQuestAction.SendUpdateQuestTrackToSdk(arg_2_0.mainQuestId_, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.TRACK)
		end)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.mainQuestId_ = arg_5_1
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = SandplayTaskMainCfg[arg_6_0.mainQuestId_]
	local var_6_1 = var_6_0.main_task_type

	if var_6_1 == QWorldQuestConst.QUEST_TASK_TYPE.MAIN then
		arg_6_0.typeController_:SetSelectedState("main")
	elseif var_6_1 == QWorldQuestConst.QUEST_TASK_TYPE.SIDE then
		arg_6_0.typeController_:SetSelectedState("side")
	elseif var_6_1 == QWorldQuestConst.QUEST_TASK_TYPE.EXPLORE then
		arg_6_0.typeController_:SetSelectedState("explore")
	end

	arg_6_0.questText_.text = var_6_0.title
	arg_6_0.trackText_.text = GetTips("SANDPLAY_TIP_TRACK")
end

return var_0_0
