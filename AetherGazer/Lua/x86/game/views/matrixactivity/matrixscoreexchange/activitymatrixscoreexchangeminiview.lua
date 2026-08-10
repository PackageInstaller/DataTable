local var_0_0 = class("ActivityMatrixScoreExchangeMiniView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Matrix/ScoreExchange/MatrixScoreExchangeMiniUI"
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

	arg_4_0.exchangeList = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.scoreListGo_, ActivityMatrixScoreExchangeMiniItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.oneKeyGetBtn_, nil, function()
		return
	end)
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.matrix_activity_id = arg_8_0.params_.matrix_activity_id
	arg_8_0.rewards = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_8_0.matrix_activity_id]

	arg_8_0.exchangeList:StartScroll(#arg_8_0.rewards)
	arg_8_0:Refresh()
end

function var_0_0.Refresh(arg_9_0)
	local var_9_0 = ActivityMatrixData:GetMatrixScore(arg_9_0.matrix_activity_id)

	arg_9_0.myScoreText_.text = string.format("%d", var_9_0)

	local var_9_1 = false

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.rewards) do
		if var_9_0 >= ActivityPointRewardCfg[iter_9_1].need and not ActivityMatrixData:GetMatrixPointRewardState(arg_9_0.matrix_activity_id, iter_9_1) then
			var_9_1 = true

			break
		end
	end

	SetActive(arg_9_0.oneKeyGetBtn_.gameObject, var_9_1)

	arg_9_0.countdownText_.text = ""
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.rewards[arg_11_1]

	arg_11_2:SetData(var_11_0, arg_11_0.matrix_activity_id)
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.exchangeList:Dispose()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
