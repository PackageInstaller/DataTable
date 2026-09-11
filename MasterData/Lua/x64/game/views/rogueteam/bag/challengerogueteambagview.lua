local ChallengeRogueTeamBagView = class("ChallengeRogueTeamBagView", ReduxView)

function ChallengeRogueTeamBagView:UIName()
	return "Widget/System/Activity_Roulike/RogueTeamBagUI"
end

function ChallengeRogueTeamBagView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamBagView:Init()
	self:BindCfgUI()

	self.subViewController_ = self.viewCon_:GetController("state")
	self.leftToggles_ = {
		self.buffBtn_,
		self.treasureBtn_,
		self.relicBtn_,
		self.optionalAffixBtn_
	}
	self.subView_ = {
		ChallengeRogueTeamBagBuffView.New(self.buffViewGo_),
		ChallengeRogueTeamBagTreasureView.New(self.treasureViewGo_),
		ChallengeRogueTeamBagRelicView.New(self.relicViewGo_),
		ChallengeRogueTeamBagOptionalAffixView.New(self.optionalViewGo_)
	}

	self:AddListeners()
end

function ChallengeRogueTeamBagView:OnEnter()
	self.leftTabIndex_ = self.params_.leftTabIndex or 1

	for iter_4_0 = 1, #self.leftToggles_ do
		self.subView_[iter_4_0]:OnEnter(self.params_)
	end

	self:RefreshUI()
	self:RefreshWindowBar()
end

function ChallengeRogueTeamBagView:OnTop()
	self:RefreshWindowBar()
	manager.rogueTeamWindowBar:SwitchBar({
		ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT,
		ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD
	})
end

function ChallengeRogueTeamBagView:RefreshWindowBar()
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

function ChallengeRogueTeamBagView:RefreshUI()
	self:SwichLeftTab(self.leftTabIndex_)
end

function ChallengeRogueTeamBagView:SwichLeftTab(arg_10_1)
	self.leftTabIndex_ = arg_10_1

	self.subViewController_:SetSelectedIndex(arg_10_1 - 1)

	for iter_10_0, iter_10_1 in ipairs(self.leftToggles_) do
		ControllerUtil.GetController(iter_10_1.transform.parent, "select"):SetSelectedState(tostring(iter_10_0 == arg_10_1))
	end

	self.subView_[self.leftTabIndex_]:RefreshUI()
end

function ChallengeRogueTeamBagView:OnExit()
	manager.windowBar:HideBar()
	manager.rogueTeamWindowBar:HideBar()

	for iter_11_0 = 1, #self.leftToggles_ do
		self.subView_[iter_11_0]:OnExit()
	end
end

function ChallengeRogueTeamBagView:Dispose()
	ChallengeRogueTeamBagView.super.Dispose(self)

	for iter_12_0 = 1, #self.leftToggles_ do
		self.subView_[iter_12_0]:Dispose()
	end
end

function ChallengeRogueTeamBagView:AddListeners()
	for iter_13_0, iter_13_1 in ipairs(self.leftToggles_) do
		self:AddBtnListener(iter_13_1, nil, function()
			self:SwichLeftTab(iter_13_0)
		end)
	end
end

return ChallengeRogueTeamBagView
