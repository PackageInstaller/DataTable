local MatrixMiniHeroView = class("MatrixMiniHeroView", ReduxView)

function MatrixMiniHeroView:UIBackCount()
	return 3
end

function MatrixMiniHeroView:UIName()
	return "UI/MatrixHero/MatrixMiniHeroUI"
end

function MatrixMiniHeroView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixMiniHeroView:OnCtor()
	self.dirty_ = true
	self.curPageIndex_ = -1
	self.pageIndexS_ = {
		weapon = 3,
		astrolabe = 5,
		skill = 2,
		property = 1,
		equip = 4
	}
	self.prefabList_ = {
		"UI/MatrixHero/MatrixHeroAttributeMiniUI",
		"UI/Hero/HeroSkillPage",
		"UI/MatrixHero/MatrixHeroWeaponUI",
		"UI/MatrixHero/MatrixHeroEquipUI",
		"UI/MatrixHero/MatrixHeroAstrolabePage"
	}
	self.ClassList_ = {
		MatrixHeroAttributePage,
		MatrixHeroSkillPage,
		MartixHeroWeaponPage,
		MatrixHeroEquipPage,
		MatrixHeroAstrolabePage
	}
end

function MatrixMiniHeroView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixMiniHeroView:InitUI()
	self:BindCfgUI()

	self.pages_ = {}
	self.heroAvatarView_ = HeroAvatarView.New(self, self.displayGo_)

	self.heroAvatarView_:SetShowInteractive(true)

	self.toggles_ = {
		self.toggle1_,
		self.toggle2_,
		self.toggle3_,
		self.toggle4_,
		self.toggle5_
	}
end

function MatrixMiniHeroView:AddUIListener()
	for iter_7_0, iter_7_1 in pairs(self.toggles_) do
		iter_7_1.onValueChanged:AddListener(function(arg_8_0)
			if arg_8_0 then
				self:SwitchPage(iter_7_0)

				if self.pages_[iter_7_0] then
					self.pages_[iter_7_0]:SetMatirxHeroInfo(self.curHeroId_)
				end
			end
		end)
	end
end

function MatrixMiniHeroView:SelectHero(arg_9_1)
	local var_9_0 = arg_9_1 ~= self.curHeroId_

	if self.curHeroId_ ~= nil and self.curHeroId_ ~= arg_9_1 and self.curPageIndex_ ~= 1 then
		self.waitToPlayInteraction_ = true
	end

	self.curHeroId_ = arg_9_1

	if self.dirty_ then
		self:SwitchPage(1)

		self.dirty_ = false
	else
		self:SwitchPage(self.curPageIndex_)
	end

	self:UpdateHeroView()

	self.toggles_[self.curPageIndex_].isOn = true
	self.params_.heroId = arg_9_1

	if var_9_0 and self.curPageIndex_ == self.pageIndexS_.astrolabe then
		manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
	end
end

function MatrixMiniHeroView:SwitchPage(arg_10_1)
	if self.curPageIndex_ == arg_10_1 and not self.dirty_ then
		return
	end

	self.heroAvatarView_:SetShowInteractive(false)

	if self.pages_[self.curPageIndex_] then
		self.pages_[self.curPageIndex_]:Hide()
	end

	local var_10_0 = self.curPageIndex_

	self.curPageIndex_ = arg_10_1

	if not self.pages_[arg_10_1] then
		if self.prefabList_[arg_10_1] and self.ClassList_[arg_10_1] then
			self.pages_[arg_10_1] = self.ClassList_[arg_10_1].New(self, (Object.Instantiate(Asset.Load(self.prefabList_[arg_10_1]), self.pageContainer_)))

			self:CheckPageEnter(arg_10_1)
		end
	else
		self.pages_[self.curPageIndex_]:Show()
	end

	if self.curPageIndex_ == self.pageIndexS_.astrolabe then
		manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
	end

	self:UpdateAvatarView()

	if not self.dirty_ and var_10_0 ~= nil and var_10_0 ~= arg_10_1 and arg_10_1 == 1 and self.waitToPlayInteraction_ then
		if self.heroAvatarView_ then
			self.heroAvatarView_:PlayChangeRoleInteraction()
		end

		self.waitToPlayInteraction_ = false
	end
end

function MatrixMiniHeroView:UpdateAvatarView()
	SetActive(self.m_weaponIcon.gameObject, false)

	if self.curPageIndex_ == self.pageIndexS_.astrolabe then
		self.heroAvatarView_:ShowHeroModel(false)

		if self.curPageIndex_ == self.pageIndexS_.astrolabe then
			self.heroAvatarView_:SetCameraToPage("heroAstrolabe")
		else
			self.heroAvatarView_:SwitchCameraToCurrentHero(false)
		end
	elseif self.curPageIndex_ == self.pageIndexS_.equip then
		self.heroAvatarView_:ShowHeroModel(false)
	elseif self.curPageIndex_ == self.pageIndexS_.weapon then
		self.heroAvatarView_:ShowHeroModel(false)

		local var_11_0 = self:GetHeroData(self.curHeroId_):GetWeaponServantEffect()

		if var_11_0 ~= 0 then
			SetActive(self.m_weaponIcon.gameObject, true)

			self.m_weaponIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponServant/Portrait/" .. var_11_0)
		end
	else
		self.heroAvatarView_:SetSkinId(self:GetHeroSkin(self.curHeroId_))
		self.heroAvatarView_:ShowHeroModel(true)
		self.heroAvatarView_:SwitchCameraToCurrentHero(false)
	end
end

function MatrixMiniHeroView:CheckPageEnter(arg_12_1)
	if not self.enteredPage_[arg_12_1] then
		self.pages_[arg_12_1]:OnEnter()

		self.enteredPage_[arg_12_1] = true
	end
end

function MatrixMiniHeroView:UpdateHeroView()
	self:UpdateAvatarView()

	for iter_13_0, iter_13_1 in pairs(self.pages_) do
		iter_13_1:SetMatirxHeroInfo(self.curHeroId_)
	end
end

function MatrixMiniHeroView:OnTop()
	if self.pages_ then
		for iter_14_0, iter_14_1 in pairs(self.pages_) do
			iter_14_1:OnTop()
		end
	end

	if self.heroAvatarView_ then
		self.heroAvatarView_:OnTop()
	end

	self:SelectHero(self.params_.heroId)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = MatrixConst.MATRIX_GAME_HELP_PAGES
		}
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare")
	end)
end

function MatrixMiniHeroView:OnBehind()
	if self.heroAvatarView_ then
		self.heroAvatarView_:OnBehind()
	end
end

function MatrixMiniHeroView:OnEnter()
	manager.ui:SetMainCamera("hero")

	self.enteredPage_ = {}

	if self.heroAvatarView_ then
		self.heroAvatarView_:OnEnter()
	end

	for iter_17_0, iter_17_1 in pairs(self.pages_) do
		self:CheckPageEnter(iter_17_0)
	end

	self:SelectHero(self.params_.heroId)
end

function MatrixMiniHeroView:ConditionOK()
	return true, ""
end

function MatrixMiniHeroView:OnMainHomeViewTop()
	self.dirty_ = true

	if self.heroAvatarView_ then
		self.heroAvatarView_:OnMainHomeViewTop()
	end
end

function MatrixMiniHeroView:OnExit()
	self:RemoveAllEventListener()

	if self.heroAvatarView_ then
		self.heroAvatarView_:OnExit()
	end

	if self.pages_ then
		for iter_20_0, iter_20_1 in pairs(self.pages_) do
			iter_20_1:OnExit()
		end
	end

	self.curHeroId_ = nil

	if self.talkTimer_ then
		self.talkTimer_:Stop()

		self.talkTimer_ = nil
	end

	HeroTools.StopTalk()
end

function MatrixMiniHeroView:Dispose()
	self:RemoveAllListeners()

	if self.heroAvatarView_ then
		self.heroAvatarView_:Dispose()

		self.heroAvatarView_ = nil
	end

	if self.pages_ then
		for iter_21_0, iter_21_1 in pairs(self.pages_) do
			iter_21_1:Dispose()
		end

		self.pages_ = nil
	end

	if self.toggles_ then
		for iter_21_2, iter_21_3 in pairs(self.toggles_) do
			iter_21_3.onValueChanged:RemoveAllListeners()
		end

		self.toggles_ = nil
	end

	MatrixMiniHeroView.super.Dispose(self)
end

function MatrixMiniHeroView:GetHeroData(arg_22_1)
	return MatrixData:GetHeroData(arg_22_1)
end

function MatrixMiniHeroView:GetHeroSkin(arg_23_1)
	return MatrixData:GetHeroSkin(arg_23_1)
end

return MatrixMiniHeroView
