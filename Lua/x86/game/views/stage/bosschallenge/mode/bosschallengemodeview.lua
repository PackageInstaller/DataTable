local var_0_0 = class("BossChallengeModeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Boss/BossSelectModeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.btnTransform_, "conName")
	arg_3_0.chooseHandler_ = handler(arg_3_0, arg_3_0.ChooseMode)
	arg_3_0.modeUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.uiList_, BossChallengeModeItem)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_MODE_DESC")
	manager.notify:RegistListener(CHALLENGE_CHOOSE_MODE, arg_4_0.chooseHandler_)
	arg_4_0.modeUIList_:StartScroll(#BossChallengeAdvanceCfg.all, 1)
	arg_4_0:RefreshUI()
	BossTools.SaveFirstEnterUIValue()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0.chooseIndex_ = nil

	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CHALLENGE_CHOOSE_MODE, arg_5_0.chooseHandler_)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.chooseHandler_ = nil

	if arg_6_0.modeUIList_ then
		arg_6_0.modeUIList_:Dispose()

		arg_6_0.modeUIList_ = nil
	end
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.chooseBtn_, nil, function()
		if arg_7_0.chooseIndex_ == nil then
			return
		end

		arg_7_0:ClickBtn()
	end)
end

function var_0_0.ClickBtn(arg_9_0)
	local var_9_0 = BossChallengeAdvanceCfg.all[arg_9_0.chooseIndex_]

	if BossChallengeAdvanceCfg[var_9_0].type == 1 then
		BattleBossChallengeAction.RequireBossChallengeData(var_9_0, function()
			arg_9_0:Go("/bossSwitch", nil, true)
		end)
	else
		BattleBossChallengeAction.RequireBossChallengeData(var_9_0, function()
			arg_9_0:Go("/bossAdvanceSwitch", nil, true)
		end)
	end
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0:ChooseMode(arg_12_0.chooseIndex_)
end

function var_0_0.RefreshItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_1, arg_13_0.chooseIndex_)
end

function var_0_0.ChooseMode(arg_14_0, arg_14_1)
	arg_14_0.chooseIndex_ = arg_14_1

	if arg_14_1 then
		arg_14_0.selectController_:SetSelectedState("yellow")
	else
		arg_14_0.selectController_:SetSelectedState("black")
	end
end

return var_0_0
