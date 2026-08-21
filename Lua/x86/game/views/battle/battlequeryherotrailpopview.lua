local var_0_0 = class("BattleQueryHeroTrailPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/OperationTryHintPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.heroID_ = arg_4_0.params_.heroID
	arg_4_0.stageType_ = arg_4_0.params_.stageType
	arg_4_0.stageID_ = arg_4_0.params_.stageID
	arg_4_0.trailStageID_ = arg_4_0.params_.trailStageID
	arg_4_0.startCallback_ = arg_4_0.params_.startCallback
	arg_4_0.trailCallback_ = arg_4_0.params_.trailCallback

	JumpTools.RefreshGaussianBg()

	arg_4_0.toggle_.isOn = false

	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.trailBtn_, nil, function()
		arg_7_0:Back()

		if arg_7_0.trailCallback_ then
			arg_7_0.trailCallback_()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.startBtn_, nil, function()
		arg_7_0:Back()

		if arg_7_0.startCallback_ then
			arg_7_0.startCallback_()
		end
	end)
	arg_7_0:AddToggleListener(arg_7_0.toggle_, function(arg_10_0)
		_G.SkipTip.SkipBattleHeroTrialPopTip = arg_10_0
	end)
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.trailText_.text = GetTips("JUMP_TO_HERO_TRIAL_BUTTON2")
	arg_11_0.startText_.text = GetTips("JUMP_TO_HERO_TRIAL_BUTTON1")
	arg_11_0.text_.text = GetTipsF("JUMP_TO_HERO_TRIAL", HeroTools.GetHeroFullName(arg_11_0.heroID_))
	arg_11_0.toggleText_.text = GetTips("LOGIN_MUTE_TIP")
end

return var_0_0
