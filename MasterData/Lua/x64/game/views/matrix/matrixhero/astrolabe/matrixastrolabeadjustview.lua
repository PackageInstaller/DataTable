local AstrolabeAdjustView = class("AstrolabeAdjustView", ReduxView)

function AstrolabeAdjustView:UIBackCount()
	return 3
end

function AstrolabeAdjustView:UIName()
	return "UI/MatrixHero/MatrixAstrolabeAdjustUI"
end

function AstrolabeAdjustView:UIParent()
	return manager.ui.uiMain.transform
end

function AstrolabeAdjustView:OnCtor()
	return
end

function AstrolabeAdjustView:Init()
	self:InitUI()
	self:AddListeners()
end

function AstrolabeAdjustView:AddListeners()
	self:AddBtnListener(self.overviewBtn_, nil, function()
		JumpTools.OpenPageByJump("matrixOrigin/matrixMiniHero")
	end)
end

function AstrolabeAdjustView:InitUI()
	self:BindCfgUI()

	self.infoSGo_ = {}
	self.astrolabeMessageView_ = MatrixAstrolabeInfoView.New(self, self.messageGo_)
end

function AstrolabeAdjustView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("matrixOrigin/matrixMiniHero")
	end)
end

function AstrolabeAdjustView:SelectItem(arg_11_1)
	if self.lastSelectItem_ then
		self.lastSelectItem_:ShowSelect(false)
	end

	local var_11_0 = arg_11_1:GetItemInfo()

	arg_11_1:ShowSelect(true)
	self.astrolabeMessageView_:RefreshUI(var_11_0, self.heroInfo_.servantId)

	self.lastSelectItem_ = arg_11_1
end

function AstrolabeAdjustView:RefreshUI()
	local var_12_0 = self:GetHeroData(self.params_.heroId)

	self.heroInfo_ = var_12_0:GetIsOwnerHero() and GetPracticalData((var_12_0:GetEntrySnapShot())) or GetVirtualData((var_12_0:GetStandardId()))
	self.heroInfo_.using_astrolabe = var_12_0:GetAstrolabeEffectList()
	self.heroInfo_.unlocked_astrolabe = HeroAstrolabeCfg.all
	self.heroInfo_.servantId = var_12_0:GetWeaponServantEffect()

	self:RefreshAstrolabeInfo()
end

function AstrolabeAdjustView:RefreshAstrolabeInfo()
	if self.heroInfo_ then
		self.equipNum_ = #self.heroInfo_.using_astrolabe

		self:RefreshAstrolabeView()
	end
end

function AstrolabeAdjustView:RefreshAstrolabeView()
	if self.heroInfo_ then
		self.currentRace_ = self.heroInfo_.id

		if self.astrolabeInfoView_ and self.lastRace_ and self.lastRace_ ~= self.currentRace_ then
			SetActive(self.infoSGo_[self.lastRace_], false)
			self.astrolabeInfoView_:Dispose()

			self.astrolabeInfoView_ = nil
		end

		if self.astrolabeInfoView_ == nil then
			if self.infoSGo_[self.currentRace_] == nil then
				self.infoSGo_[self.currentRace_] = Object.Instantiate(Asset.Load("UI/Astrolabe/Race_" .. self.currentRace_), self.infoTrs_)
			end

			SetActive(self.infoSGo_[self.currentRace_], true)

			self.astrolabeInfoView_ = self:GetHeroAstrolabeInfoView().New(self, self.infoSGo_[self.currentRace_])

			self.astrolabeInfoView_:RegistCallBack(handler(self, self.SelectItem))

			self.lastRace_ = self.currentRace_
		end

		self.astrolabeInfoView_:RefreshUI(self.heroInfo_)
	end
end

function AstrolabeAdjustView:GetHeroAstrolabeInfoView()
	return HeroAstrolabeInfoView
end

function AstrolabeAdjustView:OnEnter()
	self:RefreshUI()

	if self.params_.selectPos and self.params_.selectPos[1] ~= 0 then
		self:SelectItem(self.astrolabeInfoView_:GetItem(self.params_.selectPos[1], self.params_.selectPos[2]))
	else
		self:SelectItem(self.astrolabeInfoView_:GetFirstSelectItem())
	end
end

function AstrolabeAdjustView:OnExit()
	if self.lastSelectItem_ then
		self.lastSelectItem_:ShowSelect(false)

		self.lastSelectItem_ = nil
	end

	if self.astrolabeInfoView_ then
		self.astrolabeInfoView_:OnExit()
	end

	manager.windowBar:HideBar()
end

function AstrolabeAdjustView:Dispose()
	AstrolabeAdjustView.super.Dispose(self)

	if self.astrolabeInfoView_ then
		self.astrolabeInfoView_:Dispose()

		self.astrolabeInfoView_ = nil
	end

	if self.astrolabeMessageView_ then
		self.astrolabeMessageView_:Dispose()

		self.astrolabeMessageView_ = nil
	end
end

function AstrolabeAdjustView:GetHeroData(arg_19_1)
	return MatrixData:GetHeroData(arg_19_1)
end

return AstrolabeAdjustView
