local StrategyMatrixHeroView = class("StrategyMatrixHeroView", MatrixMiniHeroView)

function StrategyMatrixHeroView:UIBackCount()
	return 1
end

function StrategyMatrixHeroView:UIName()
	return "UI/StrategyMatrix/StrategyMatrixMiniHeroUI"
end

function StrategyMatrixHeroView:OnCtor()
	self.dirty_ = true
	self.curPageIndex_ = -1
	self.pageIndexS_ = {
		weapon = 3,
		astrolabe = 5,
		skill = 2,
		treasure = 6,
		property = 1,
		equip = 4
	}
	self.prefabList_ = {
		"UI/StrategyMatrix/StrategyMatrixHeroAttributeMiniUI",
		"UI/Hero/HeroSkillPage",
		"UI/StrategyMatrix/StrategyMatrixHeroWeaponUI",
		"UI/StrategyMatrix/StrategyMatrixHeroEquipUI",
		"UI/StrategyMatrix/StrategyMatrixHeroAstrolabePage",
		"UI/StrategyMatrix/StrategyMatrixTreasureMiniUI"
	}
	self.ClassList_ = {
		StrategyMatrixHeroAttributePage,
		StrategyMatrixHeroSkillPage,
		StrategyMartixHeroWeaponPage,
		StrategyMatrixHeroEquipPage,
		StrategyMatrixHeroAstrolabePage,
		StrategyMatrixTreasurePage
	}
end

function StrategyMatrixHeroView:InitUI()
	self:BindCfgUI()

	self.pages_ = {}
	self.heroAvatarView_ = HeroAvatarView.New(self, self.displayGo_)

	self.heroAvatarView_:SetShowInteractive(true)

	self.toggles_ = {
		self.toggle1_,
		self.toggle2_,
		self.toggle3_,
		self.toggle4_,
		self.toggle5_,
		self.toggle6_
	}
end

function StrategyMatrixHeroView:AddUIListener()
	for iter_5_0, iter_5_1 in pairs(self.toggles_) do
		iter_5_1.onValueChanged:AddListener(function(arg_6_0)
			if arg_6_0 then
				self:SwitchPage(iter_5_0)

				if self.pages_[iter_5_0] then
					self.pages_[iter_5_0]:SetMatirxHeroInfo(self.matrix_activity_id, self.curHeroId_)
				end
			end
		end)
	end

	self:AddBtnListener(self.m_rewardBtn, nil, function()
		self:Back()
	end)
end

function StrategyMatrixHeroView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(self.matrix_activity_id))
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, self.matrix_activity_id)
end

function StrategyMatrixHeroView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	StrategyMatrixHeroView.super.OnEnter(self)

	if self:GetMatrixPhaseData():GetPhase() == 3 then
		SetActive(self.m_rewardBtn.gameObject, true)
	else
		SetActive(self.m_rewardBtn.gameObject, false)
	end
end

function StrategyMatrixHeroView:UpdateHeroView()
	self:UpdateAvatarView()

	for iter_10_0, iter_10_1 in pairs(self.pages_) do
		iter_10_1:SetMatirxHeroInfo(self.matrix_activity_id, self.curHeroId_)
	end
end

function StrategyMatrixHeroView:UpdateAvatarView()
	if self.curPageIndex_ == self.pageIndexS_.astrolabe then
		self.heroAvatarView_:ShowHeroModel(false)
		self.heroAvatarView_:SetCameraToPage("heroAstrolabe")
	elseif self.curPageIndex_ == self.pageIndexS_.equip or self.curPageIndex_ == self.pageIndexS_.treasure then
		self.heroAvatarView_:ShowHeroModel(false)
		self.heroAvatarView_:SetCameraToPage("heroEquip")
	elseif self.curPageIndex_ == self.pageIndexS_.weapon then
		self.heroAvatarView_:ShowHeroModel(false)
		self.heroAvatarView_:SetCameraToPage("heroWeapon")

		if self:GetHeroData(self.curHeroId_):GetWeaponServantEffect() ~= 0 then
			-- block empty
		end
	else
		self.heroAvatarView_:SetSkinId(self:GetHeroSkin(self.curHeroId_))
		self.heroAvatarView_:ShowHeroModel(true)
		self.heroAvatarView_:SwitchCameraToCurrentHero(false)
	end
end

function StrategyMatrixHeroView:GetHeroData(arg_12_1)
	return StrategyMatrixData:GetHeroData(arg_12_1)
end

function StrategyMatrixHeroView:GetHeroSkin(arg_13_1)
	return StrategyMatrixData:GetHeroSkin(self.matrix_activity_id, arg_13_1)
end

function StrategyMatrixHeroView:GetMatrixPhaseData()
	return StrategyMatrixData:GetMatrixPhaseData(self.matrix_activity_id)
end

return StrategyMatrixHeroView
