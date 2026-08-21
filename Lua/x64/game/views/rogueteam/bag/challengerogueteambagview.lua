local var_0_0 = class("ChallengeRogueTeamBagView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RogueTeamBagUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.subViewController_ = arg_3_0.viewCon_:GetController("state")
	arg_3_0.leftToggles_ = {
		arg_3_0.buffBtn_,
		arg_3_0.treasureBtn_,
		arg_3_0.relicBtn_,
		arg_3_0.optionalAffixBtn_
	}
	arg_3_0.subView_ = {
		ChallengeRogueTeamBagBuffView.New(arg_3_0.buffViewGo_),
		ChallengeRogueTeamBagTreasureView.New(arg_3_0.treasureViewGo_),
		ChallengeRogueTeamBagRelicView.New(arg_3_0.relicViewGo_),
		ChallengeRogueTeamBagOptionalAffixView.New(arg_3_0.optionalViewGo_)
	}

	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.leftTabIndex_ = arg_4_0.params_.leftTabIndex or 1

	for iter_4_0 = 1, #arg_4_0.leftToggles_ do
		arg_4_0.subView_[iter_4_0]:OnEnter(arg_4_0.params_)
	end

	arg_4_0:RefreshUI()
	arg_4_0:RefreshWindowBar()
end

function var_0_0.OnTop(arg_5_0)
	arg_5_0:RefreshWindowBar()
	manager.rogueTeamWindowBar:SwitchBar({
		ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT,
		ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD
	})
end

function var_0_0.RefreshWindowBar(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistHomeCallBack(function()
		ChallengeRogueTeamAction.OnPlayingState(ChallengeRogueTeamConst.PLAYING_STATE.EXIT, function()
			gameContext:Go("/home", nil, nil, true)
		end)
	end)
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:SwichLeftTab(arg_9_0.leftTabIndex_)
end

function var_0_0.SwichLeftTab(arg_10_0, arg_10_1)
	arg_10_0.leftTabIndex_ = arg_10_1

	arg_10_0.subViewController_:SetSelectedIndex(arg_10_1 - 1)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.leftToggles_) do
		ControllerUtil.GetController(iter_10_1.transform.parent, "select"):SetSelectedState(tostring(iter_10_0 == arg_10_1))
	end

	arg_10_0.subView_[arg_10_0.leftTabIndex_]:RefreshUI()
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
	manager.rogueTeamWindowBar:HideBar()

	for iter_11_0 = 1, #arg_11_0.leftToggles_ do
		arg_11_0.subView_[iter_11_0]:OnExit()
	end
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)

	for iter_12_0 = 1, #arg_12_0.leftToggles_ do
		arg_12_0.subView_[iter_12_0]:Dispose()
	end
end

function var_0_0.AddListeners(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.leftToggles_) do
		arg_13_0:AddBtnListener(iter_13_1, nil, function()
			arg_13_0:SwichLeftTab(iter_13_0)
		end)
	end
end

return var_0_0
