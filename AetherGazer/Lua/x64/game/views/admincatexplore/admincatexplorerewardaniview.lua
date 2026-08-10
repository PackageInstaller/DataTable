local var_0_0 = class("AdminCatExploreRewardAniView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ExploreUI/ExploCalculusAnimationUI"
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

	arg_4_0.rewardList_ = LuaList.New(handler(arg_4_0, arg_4_0.SetItemData), arg_4_0.listGo_, AdminCatExploreRewardItem)
	arg_4_0.rateController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "rate")
	arg_4_0.itemList = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.getRewardBtn_, nil, function()
		if arg_5_0.isOver ~= true then
			return
		end

		arg_5_0.isOver = nil

		local var_6_0 = LeanTween.value(arg_5_0.nullGo_, arg_5_0.exploreDay, 0, arg_5_0.exploreDay * 0.2)

		var_6_0:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
			arg_5_0.handle_.fillAmount = arg_7_0 / 7
			arg_5_0.numTxt_.text = math.ceil(arg_5_0.rate[arg_5_0.exploreDay] / 7 * arg_7_0 * 100) .. "<size=24>%</size>"

			local var_7_0 = math.floor(arg_7_0)

			arg_5_0.rateController:SetSelectedState(tostring(var_7_0))
		end))
		var_6_0:setOnComplete(System.Action(function()
			LeanTween.cancel(arg_5_0.nullGo_)
			var_6_0:setOnUpdate(nil):setOnComplete(nil)
			AdminCatExploreAction.GetWeekReward()
		end))
		manager.audio:PlayEffect("ui_system_explore", "explore_calculus_0" .. arg_5_0.exploreDay .. "_down", "")
	end)
end

function var_0_0.SetItemData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetItemData(arg_9_0.reward[arg_9_1], arg_9_1)
	table.insert(arg_9_0.itemList, arg_9_2)
end

function var_0_0.OnGetWeeklyReward(arg_10_0)
	arg_10_0:Back()
end

function var_0_0.UpdateView(arg_11_0)
	local var_11_0 = AdminCatExploreData:GetDataByPara("level")

	arg_11_0.rate = AdminCatExploreData:GetDataByPara("rate")
	arg_11_0.exploreDay = AdminCatExploreData:GetDataByPara("exploreDay")

	local var_11_1 = ExploreLevelCfg[var_11_0].accumulate_rewards

	arg_11_0.reward = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		table.insert(arg_11_0.reward, {
			iter_11_1[1],
			iter_11_1[2] * arg_11_0.rate[arg_11_0.exploreDay]
		})
	end

	for iter_11_2 = 1, 7 do
		arg_11_0["txt" .. iter_11_2].text = "x" .. arg_11_0.rate[iter_11_2]
	end

	arg_11_0.rewardList_:StartScroll(#arg_11_0.reward)

	if arg_11_0.exploreDay == 0 then
		arg_11_0.handle_.fillAmount = 0

		arg_11_0.rateController:SetSelectedState("0")

		arg_11_0.numTxt_.text = "0<size=24>%</size>"

		for iter_11_3, iter_11_4 in ipairs(arg_11_0.itemList) do
			iter_11_4:UpdateText(0)
		end

		return
	end

	local var_11_2 = LeanTween.value(arg_11_0.nullGo_, 0, arg_11_0.exploreDay, arg_11_0.exploreDay * 0.1)

	var_11_2:setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
		arg_11_0.handle_.fillAmount = arg_12_0 / 7
		arg_11_0.numTxt_.text = math.ceil(arg_11_0.rate[arg_11_0.exploreDay] / arg_11_0.exploreDay * arg_12_0 * 100) .. "<size=24>%</size>"

		for iter_12_0, iter_12_1 in ipairs(arg_11_0.itemList) do
			iter_12_1:UpdateText(math.ceil(arg_11_0.reward[iter_12_0][2] / arg_11_0.exploreDay * arg_12_0))
		end

		local var_12_0 = math.floor(arg_12_0)

		arg_11_0.rateController:SetSelectedState(tostring(var_12_0))
	end))
	var_11_2:setOnComplete(System.Action(function()
		LeanTween.cancel(arg_11_0.nullGo_)

		arg_11_0.isOver = true

		var_11_2:setOnUpdate(nil):setOnComplete(nil)
	end))
	manager.audio:PlayEffect("ui_system_explore", "explore_calculus_0" .. arg_11_0.exploreDay .. "_up", "")
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:UpdateView()
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0.isOver = nil
	arg_15_0.itemList = {}
end

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		NAVI_BAR
	})
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.rewardList_ then
		arg_17_0.rewardList_:Dispose()

		arg_17_0.rewardList_ = nil
	end

	var_0_0.super.Dispose(arg_17_0)
	Object.Destroy(arg_17_0.gameObject_)
end

return var_0_0
