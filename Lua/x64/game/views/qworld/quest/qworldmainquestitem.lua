local var_0_0 = class("QWorldMainQuestItem", ReduxView)

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

	arg_3_0.trackingController_ = arg_3_0.conEx_:GetController("tracking")
	arg_3_0.seriesController_ = arg_3_0.conEx_:GetController("series")
	arg_3_0.selectController_ = arg_3_0.conEx_:GetController("select")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.mainQuestId_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.mainQuestId_ = arg_6_1

	arg_6_0:RefreshUI()
end

function var_0_0.SetSelected(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedState(arg_7_1 and "true" or "false")
end

function var_0_0.SetClickHandler(arg_8_0, arg_8_1)
	arg_8_0.clickFunc = arg_8_1
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = SandplayTaskMainCfg[arg_9_0.mainQuestId_]
	local var_9_1 = SandplayTaskChapterCfg[var_9_0.chapter_task_id]

	if var_9_1 then
		arg_9_0.seriesText_.text = var_9_1.chapter_name

		arg_9_0.seriesController_:SetSelectedState("true")
	else
		arg_9_0.seriesController_:SetSelectedState("false")
	end

	arg_9_0.titleText_.text = var_9_0.title

	local var_9_2 = QWorldQuestTool.GetMainQuestTrackingId()

	arg_9_0.trackingController_:SetSelectedState(arg_9_0.mainQuestId_ == var_9_2 and "true" or "false")
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
