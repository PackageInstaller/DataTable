local var_0_0 = class("FishingRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Fishing/FishingRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uiListGo_, FishingRewardItemView)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetId(arg_6_0.rewardIdList_[arg_6_1])
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.AddEventListeners(arg_10_0)
	arg_10_0:RegistEventListener(FISHING_SCORE_REWARD_CHANGE, function()
		arg_10_0:SortData()
		arg_10_0:UpdateView()
	end)
	arg_10_0:RegistEventListener(RARE_FISH_CHANGE, function(arg_12_0)
		arg_10_0:UpdateView()
	end)
end

function var_0_0.OnTop(arg_13_0)
	arg_13_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_14_0)
	return
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0:AddEventListeners()

	arg_15_0.rewardIdList_ = ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_FISHING]

	arg_15_0:SortData()
	arg_15_0:UpdateView()
end

function var_0_0.SortData(arg_16_0)
	local var_16_0 = 0
	local var_16_1 = FishingData:GetActivityData()

	if var_16_1 then
		var_16_0 = var_16_1.score
	end

	local var_16_2 = FishingData:GetActivityData().received_award_list

	table.sort(arg_16_0.rewardIdList_, function(arg_17_0, arg_17_1)
		local var_17_0 = ActivityPointRewardCfg[arg_17_0]
		local var_17_1 = ActivityPointRewardCfg[arg_17_1]
		local var_17_2 = table.indexof(var_16_2, var_17_0.id) or 0
		local var_17_3 = table.indexof(var_16_2, var_17_1.id) or 0

		if (var_17_2 == 0 or var_17_3 == 0) and var_17_2 ~= var_17_3 then
			return var_17_2 < var_17_3
		end

		local var_17_4 = var_16_0 >= var_17_0.need and 1 or 0
		local var_17_5 = var_16_0 >= var_17_1.need and 1 or 0

		if var_17_4 ~= var_17_5 then
			return var_17_5 < var_17_4
		end

		return arg_17_0 < arg_17_1
	end)
end

function var_0_0.UpdateView(arg_18_0)
	arg_18_0.uiList_:StartScroll(#arg_18_0.rewardIdList_)

	local var_18_0 = 0
	local var_18_1 = FishingData:GetActivityData()

	if var_18_1 then
		var_18_0 = var_18_1.score
	end

	arg_18_0.currentLabel_.text = var_18_0
end

function var_0_0.OnExit(arg_19_0)
	arg_19_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_20_0)
	return
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.uiList_ then
		arg_21_0.uiList_:Dispose()

		arg_21_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
