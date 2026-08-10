local var_0_0 = class("QWorldQuestFinishView", QWorldHintBaseView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay/SandPlay_InScenes/item/SandPlay_QuestClear"
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.typeController_ = arg_2_0.conEx_:GetController("quest")
	arg_2_0.seriesController_ = arg_2_0.conEx_:GetController("series")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.mainQuestId_ = arg_3_1
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = SandplayTaskMainCfg[arg_4_0.mainQuestId_]
	local var_4_1 = SandplayTaskChapterCfg[var_4_0.chapter_task_id]

	if var_4_1 then
		arg_4_0.questExploreText_.text = GetTipsF("SANDPLAY_TIP_SERIES_COMPLETE", GetI18NText(var_4_1.chapter_name))
	else
		arg_4_0.questExploreText_.text = GetTips("ERROR_BAD_TEMPLATE")
	end
end

return var_0_0
