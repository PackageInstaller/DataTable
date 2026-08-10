local var_0_0 = class("MultHeartDemonReportView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_MatchRecordUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiList_, MultHeartDemonReportItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_1, arg_7_0.data)
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.list:StartScroll(arg_8_0.data ~= nil and arg_8_0.data.stageData ~= nil and #arg_8_0.data.stageData or 0)

	arg_8_0.pointText_.text = arg_8_0.maxScore
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:UpdateData()
	arg_9_0:UpdateView()
end

function var_0_0.UpdateData(arg_10_0)
	arg_10_0.activityId = MultHeartDemonData:GetDataByPara("activityId")
	arg_10_0.maxScore = 0
	arg_10_0.titleTxt_.text = GetTips("MULTI_HEART_DEMON_TOTAL_SCORE")
	arg_10_0.difficult = arg_10_0.params_.difficult
	arg_10_0.cfg = MultHeartDemonCfg[arg_10_0.activityId]
	arg_10_0.data = arg_10_0.params_.data

	for iter_10_0, iter_10_1 in pairs(arg_10_0.data.stageData or {}) do
		arg_10_0.maxScore = iter_10_1.maxScore + arg_10_0.maxScore
	end
end

function var_0_0.OnMultDemonHeartSaveTeam(arg_11_0)
	arg_11_0:UpdateData()
	arg_11_0:UpdateView()
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.list then
		arg_14_0.list:Dispose()

		arg_14_0.list = nil
	end

	var_0_0.super.Dispose(arg_14_0)
	Object.Destroy(arg_14_0.gameObject_)
end

return var_0_0
