local var_0_0 = class("PaperCutResultView", ReduxView)

function var_0_0.UIBackCount(arg_1_0)
	return 2
end

function var_0_0.UIName(arg_2_0)
	return "UI/EmptyDream/PaperCut/PaperCutResultUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.resultImage_ = arg_5_0.resultImageGo_:GetComponent("PaperCutUIImage")
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.backMask_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID
	arg_8_0.titleText_.text = GetI18NText(PaperCutCfg[arg_8_0.activityID_].name)

	arg_8_0:RefreshImage()
	arg_8_0:RefreshScore()
end

function var_0_0.RefreshImage(arg_9_0)
	PaperCutTool:DisplayResultImage(arg_9_0.resultImage_)

	local var_9_0 = arg_9_0.resultImageTrans_.localPosition
	local var_9_1 = arg_9_0.resultImageTrans_.sizeDelta
	local var_9_2 = arg_9_0.scorePanelTrans_.localPosition

	if var_9_2.y >= var_9_0.y - var_9_1.y * 0.5 then
		var_9_2.y = var_9_0.y - var_9_1.y * 0.5 - 40
		arg_9_0.scorePanelTrans_.localPosition = var_9_2
	end
end

function var_0_0.RefreshScore(arg_10_0)
	local var_10_0 = PaperCutTool:CalculateScore()

	PaperCutAction.RequireComplete(arg_10_0.activityID_, var_10_0)

	arg_10_0.scoreText_.text = var_10_0 or 0
end

return var_0_0
