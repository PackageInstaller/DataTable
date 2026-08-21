local var_0_0 = class("SkuldTravelRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelreward"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.rewardlist_ = deepClone(TravelSkuldRewardCfg.all)

	arg_4_0:RewardSort()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listgo_, SkuldTravelRewardItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.rewardlist_[arg_5_1])
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgbtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RewardSort()
	arg_8_0.list_:StartScroll(#TravelSkuldRewardCfg.all)
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.RewardSort(arg_10_0)
	local var_10_0 = {
		{},
		{},
		{}
	}

	for iter_10_0, iter_10_1 in pairs(arg_10_0.rewardlist_) do
		local var_10_1 = SkuldTravelData:GetTaskStatuByTaskId(iter_10_1)

		table.insert(var_10_0[var_10_1], iter_10_1)
	end

	arg_10_0.rewardlist_ = {}

	for iter_10_2, iter_10_3 in pairs(var_10_0) do
		table.sort(iter_10_3)
		table.insertto(arg_10_0.rewardlist_, iter_10_3)
	end
end

function var_0_0.OnSkuldGetReward(arg_11_0)
	arg_11_0:RewardSort()
	arg_11_0.list_:Refresh()
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.list_ then
		arg_12_0.list_:Dispose()

		arg_12_0.list_ = nil
	end

	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
