local var_0_0 = class("ActivityMatrixScoreExchangeMiniView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeRewardshow"
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

	arg_4_0.exchangeList = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.scoreListGo_, ActivityMatrixScoreExchangeItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.oneKeyGetBtn_, nil, function()
		local var_6_0 = {}
		local var_6_1 = ActivityMatrixData:GetMatrixScore(arg_5_0.matrix_activity_id)

		for iter_6_0, iter_6_1 in ipairs(arg_5_0.rewards) do
			if var_6_1 >= ActivityPointRewardCfg[iter_6_1].need and not ActivityMatrixData:GetMatrixPointRewardState(arg_5_0.matrix_activity_id, iter_6_1) then
				table.insert(var_6_0, iter_6_1)
			end
		end

		ActivityAction.ReceivePointReward(var_6_0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgMask_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.matrix_activity_id = arg_9_0.params_.matrix_activity_id
	arg_9_0.rewards = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_9_0.matrix_activity_id] or {}

	arg_9_0.exchangeList:StartScroll(#arg_9_0.rewards)
	arg_9_0:Refresh()
end

function var_0_0.Refresh(arg_10_0)
	local var_10_0 = ActivityMatrixData:GetMatrixScore(arg_10_0.matrix_activity_id)

	arg_10_0.myScoreText_.text = string.format("%d", var_10_0)

	local var_10_1 = false

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.rewards) do
		if var_10_0 >= ActivityPointRewardCfg[iter_10_1].need and not ActivityMatrixData:GetMatrixPointRewardState(arg_10_0.matrix_activity_id, iter_10_1) then
			var_10_1 = true

			break
		end
	end

	SetActive(arg_10_0.oneKeyGetBtn_.gameObject, var_10_1)

	local var_10_2 = ActivityMatrixCfg[arg_10_0.matrix_activity_id]

	arg_10_0.m_name.text = GetI18NText(var_10_2.name)
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.rewards[arg_12_1]

	arg_12_2:SetData(var_12_0, arg_12_0.matrix_activity_id)
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.exchangeList:Dispose()
	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.OnReceivePointReward(arg_14_0)
	arg_14_0:Refresh()
	arg_14_0.exchangeList:Refresh()
end

return var_0_0
