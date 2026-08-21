local var_0_0 = class("EatSnakeQuitPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com/SandPlay_Com_PopUI"
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
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		if arg_5_0.params_.cancelAction then
			arg_5_0.params_.cancelAction()
		end

		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.reBattleBtn_, nil, function()
		if arg_5_0.params_.battleAction then
			manager.audio:StopAll()
			arg_5_0.params_.battleAction()
		end

		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.confirmBtn_, nil, function()
		if arg_5_0.params_.failAction then
			arg_5_0.params_.failAction()
		end

		manager.audio:Stop("effect")
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:UpdateView()
end

function var_0_0.OnEnterOver(arg_10_0)
	arg_10_0:StopTimer()

	arg_10_0.timer_ = FrameTimer.New(function()
		manager.audio:Pause("effect", true)
	end, 6, 1)

	arg_10_0.timer_:Start()
end

function var_0_0.UpdateView(arg_12_0)
	arg_12_0.titleText_.text = arg_12_0.params_.title or GetTips("PROMPT")
	arg_12_0.contentText_.text = arg_12_0.params_.content

	if not arg_12_0.params_.reBattleBtn_ then
		arg_12_0.reBattleBtn_.gameObject:SetActive(false)
	else
		arg_12_0.reBattleBtn_.gameObject:SetActive(true)
	end
end

function var_0_0.OnExit(arg_13_0)
	manager.audio:Pause("effect", false)
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()
	end
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
