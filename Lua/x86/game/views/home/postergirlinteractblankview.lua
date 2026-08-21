local var_0_0 = class("PosterGirlInteractBlankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Main/PosterGirlBlankView"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.subtitleBubble = MainHomeView_SubtitleBubble.New(arg_3_0.talkBubbleGo_)
end

function var_0_0.OnTop(arg_4_0)
	manager.notify:Invoke(HOME_BTN_VISIBE, false)
	manager.posterGirl:SetStateCanChange(false)
	manager.windowBar:SwitchBar(arg_4_0.params_.barSetting or {
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		manager.windowBar:HideBar()
		manager.transition:OnlyShowEffect(true, function()
			HeroTools.StopTalk()
			manager.notify:Invoke(INTERRUPT_HOME_POSTER_TALK)
			manager.posterGirl.actor:ChangeState(PosterGirlConst.StateKay.init_no_blend)
			manager.transition:OnlyShowEffect(false)
			manager.posterGirl:SetStateCanChange(true)
			arg_4_0:Back()
		end)
	end)
	arg_4_0:RegistEventListener(ON_POSTERGIRL_TRANSITION_END, function(arg_7_0)
		if arg_7_0.state_key == PosterGirlConst.StateKay.init or arg_7_0.state_key == PosterGirlConst.StateKay.init_spec or arg_7_0.state_key == PosterGirlConst.StateKay.init_no_blend then
			arg_4_0:Back()
		end
	end)
end

function var_0_0.OnBehind(arg_8_0)
	manager.windowBar:HideBar()

	if arg_8_0.params_.onBehindCallback then
		arg_8_0.params_.onBehindCallback()
	end
end

function var_0_0.Back(arg_9_0, arg_9_1, arg_9_2)
	manager.notify:Invoke(HOME_BTN_VISIBE, true)
	JumpTools.Back(arg_9_1, arg_9_2)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.subtitleBubble:OnEnter()
	arg_10_0:RegistEventListener(INTERRUPT_HOME_POSTER_TALK, handler(arg_10_0, arg_10_0.ClearHomePosterTalk))
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:RemoveAllEventListener()
	arg_11_0.subtitleBubble:OnExit()
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllEventListener()
	arg_12_0.subtitleBubble:Dispose()
	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.ClearHomePosterTalk(arg_13_0)
	arg_13_0.subtitleBubble:Clear()
end

return var_0_0
