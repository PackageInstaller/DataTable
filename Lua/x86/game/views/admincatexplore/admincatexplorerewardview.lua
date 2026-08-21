local var_0_0 = class("AdminCatExploreRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ExploreUI/ExploCalculusPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.rewardList_ = LuaList.New(handler(arg_4_0, arg_4_0.SetItemData), arg_4_0.listGo_, AdminCatExploreRewardItem)
	arg_4_0.rateController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "rate")
	arg_4_0.stateController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "state")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.buttonBtn_, nil, function()
		if arg_5_0.stateController:GetSelectedState() == "go" then
			arg_5_0:Back()
			JumpTools.GoToSystem("/adminCatExploreRewardAni", {})
		end
	end)
end

function var_0_0.SetItemData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:SetItemData(arg_8_0.reward[arg_8_1], arg_8_1)
end

function var_0_0.UpdateBar(arg_9_0)
	return
end

function var_0_0.UpdateView(arg_10_0)
	local var_10_0 = AdminCatExploreData:GetDataByPara("level")

	arg_10_0.exploreDay = AdminCatExploreData:GetDataByPara("exploreDay")
	arg_10_0.handle_.fillAmount = arg_10_0.exploreDay / 7
	arg_10_0.dayTxt_.text = string.format(GetTips("EXPLORE_ACCUMULATE_TIME"), arg_10_0.exploreDay)
	arg_10_0.isGet = AdminCatExploreData:GetDataByPara("getWeeklyReward") == 1
	arg_10_0.rate = AdminCatExploreData:GetDataByPara("rate")

	local var_10_1 = ExploreLevelCfg[var_10_0].accumulate_rewards

	arg_10_0.reward = {}
	arg_10_0.rateTxt_.text = "x" .. arg_10_0.rate[arg_10_0.exploreDay]

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		table.insert(arg_10_0.reward, {
			iter_10_1[1],
			iter_10_1[2] * arg_10_0.rate[arg_10_0.exploreDay]
		})
	end

	if AdminCatExploreData:CheckCanGetWeeklyReward() then
		arg_10_0.stateController:SetSelectedState(arg_10_0.isGet and "get" or "go")
	else
		arg_10_0.stateController:SetSelectedState("normal")
	end

	for iter_10_2 = 1, 7 do
		arg_10_0["txt" .. iter_10_2].text = "x" .. arg_10_0.rate[iter_10_2]
	end

	arg_10_0.rewardList_:StartScroll(#arg_10_0.reward)
	arg_10_0.rateController:SetSelectedState(tostring(arg_10_0.exploreDay))
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:UpdateView()

	local var_11_0 = AdminCatExploreData:CheckCanGetWeeklyReward()

	arg_11_0.updateTimer_ = Timer.New(function()
		if AdminCatExploreData:CheckCanGetWeeklyReward() ~= var_11_0 then
			arg_11_0:UpdateView()
			arg_11_0.updateTimer_:Stop()
		end
	end, 1, -1, 1)

	arg_11_0.updateTimer_:Start()
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()

	if arg_13_0.updateTimer_ then
		arg_13_0.updateTimer_:Stop()

		arg_13_0.updateTimer_ = nil
	end
end

function var_0_0.Hide(arg_14_0)
	SetActive(arg_14_0.gameObject_, false)
end

function var_0_0.Show(arg_15_0)
	SetActive(arg_15_0.gameObject_, true)
end

function var_0_0.Dispose(arg_16_0)
	if arg_16_0.rewardList_ then
		arg_16_0.rewardList_:Dispose()

		arg_16_0.rewardList_ = nil
	end

	var_0_0.super.Dispose(arg_16_0)
	Object.Destroy(arg_16_0.gameObject_)
end

return var_0_0
