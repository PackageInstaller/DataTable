local PosterGirlInteractBlankView = class("PosterGirlInteractBlankView", ReduxView)

function PosterGirlInteractBlankView:UIName()
	return "Widget/System/Main/PosterGirlBlankView"
end

function PosterGirlInteractBlankView:UIParent()
	return manager.ui.uiMain.transform
end

function PosterGirlInteractBlankView:Init()
	self:BindCfgUI()

	self.subtitleBubble = MainHomeView_SubtitleBubble.New(self.talkBubbleGo_)
end

function PosterGirlInteractBlankView:OnTop()
	manager.notify:Invoke(HOME_BTN_VISIBE, false)
	manager.posterGirl:SetStateCanChange(false)
	manager.windowBar:SwitchBar(self.params_.barSetting or {
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
			self:Back()
		end)
	end)
	self:RegistEventListener(ON_POSTERGIRL_TRANSITION_END, function(arg_7_0)
		if arg_7_0.state_key == PosterGirlConst.StateKay.init or arg_7_0.state_key == PosterGirlConst.StateKay.init_spec or arg_7_0.state_key == PosterGirlConst.StateKay.init_no_blend then
			self:Back()
		end
	end)
end

function PosterGirlInteractBlankView:OnBehind()
	manager.windowBar:HideBar()

	if self.params_.onBehindCallback then
		self.params_.onBehindCallback()
	end
end

function PosterGirlInteractBlankView:Back(arg_9_1, arg_9_2)
	manager.notify:Invoke(HOME_BTN_VISIBE, true)
	JumpTools.Back(arg_9_1, arg_9_2)
end

function PosterGirlInteractBlankView:OnEnter()
	self.subtitleBubble:OnEnter()
	self:RegistEventListener(INTERRUPT_HOME_POSTER_TALK, handler(self, self.ClearHomePosterTalk))
end

function PosterGirlInteractBlankView:OnExit()
	self:RemoveAllEventListener()
	self.subtitleBubble:OnExit()
end

function PosterGirlInteractBlankView:Dispose()
	self:RemoveAllEventListener()
	self.subtitleBubble:Dispose()
	PosterGirlInteractBlankView.super.Dispose(self)
end

function PosterGirlInteractBlankView:ClearHomePosterTalk()
	self.subtitleBubble:Clear()
end

return PosterGirlInteractBlankView
