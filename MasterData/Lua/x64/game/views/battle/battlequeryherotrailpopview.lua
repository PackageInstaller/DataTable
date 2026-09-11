local BattleQueryHeroTrailPopView = class("BattleQueryHeroTrailPopView", ReduxView)

function BattleQueryHeroTrailPopView:UIName()
	return "Widget/System/Operation/OperationTryHintPopUI"
end

function BattleQueryHeroTrailPopView:UIParent()
	return manager.ui.uiPop.transform
end

function BattleQueryHeroTrailPopView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function BattleQueryHeroTrailPopView:OnEnter()
	self.heroID_ = self.params_.heroID
	self.stageType_ = self.params_.stageType
	self.stageID_ = self.params_.stageID
	self.trailStageID_ = self.params_.trailStageID
	self.startCallback_ = self.params_.startCallback
	self.trailCallback_ = self.params_.trailCallback

	JumpTools.RefreshGaussianBg()

	self.toggle_.isOn = false

	self:RefreshUI()
end

function BattleQueryHeroTrailPopView:OnExit()
	return
end

function BattleQueryHeroTrailPopView:Dispose()
	BattleQueryHeroTrailPopView.super.Dispose(self)
end

function BattleQueryHeroTrailPopView:AddListeners()
	self:AddBtnListener(self.trailBtn_, nil, function()
		self:Back()

		if self.trailCallback_ then
			self.trailCallback_()
		end
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		self:Back()

		if self.startCallback_ then
			self.startCallback_()
		end
	end)
	self:AddToggleListener(self.toggle_, function(arg_10_0)
		_G.SkipTip.SkipBattleHeroTrialPopTip = arg_10_0
	end)
end

function BattleQueryHeroTrailPopView:RefreshUI()
	self.trailText_.text = GetTips("JUMP_TO_HERO_TRIAL_BUTTON2")
	self.startText_.text = GetTips("JUMP_TO_HERO_TRIAL_BUTTON1")
	self.text_.text = GetTipsF("JUMP_TO_HERO_TRIAL", HeroTools.GetHeroFullName(self.heroID_))
	self.toggleText_.text = GetTips("LOGIN_MUTE_TIP")
end

return BattleQueryHeroTrailPopView
