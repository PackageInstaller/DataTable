local MatrixHeroView = class("MatrixHeroView", ReduxView)

function MatrixHeroView:UIName()
	return "UI/MatrixHero/MatrixHeroUI"
end

function MatrixHeroView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixHeroView:OnCtor()
	self.dirty_ = true
	self.curPageIndex_ = 1
	self.pageIndexS_ = {
		skill = 2,
		property = 1
	}
	self.prefabList_ = {
		[1] = "UI/MatrixHero/MatrixHeroAttributeUI",
		[2] = "UI/Hero/HeroSkillPage"
	}
	self.ClassList_ = {
		MatrixHeroAttributePageCom,
		MatrixHeroSkillPageCom
	}
	self.pageConditionList_ = {
		handler(self, self.ConditionOK),
		(handler(self, self.ConditionOK))
	}
end

function MatrixHeroView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixHeroView:InitUI()
	self:BindCfgUI()

	self.mainPageController_ = ControllerUtil.GetController(self.gameObject_.transform, "mainPage")
	self.pages_ = {}
	self.shortScrollHelper_ = LuaList.New(handler(self, self.ShortHeadRenderer), self.heroShortListGo_, MatrixHeroHead)
	self.completeScrollHelper_ = LuaList.New(handler(self, self.LongHeadRenderer), self.heroCompleteListGo_, MatrixHeroHead)
	self.curScrollHelper_ = self.shortScrollHelper_
	self.heroAvatarView_ = HeroAvatarView.New(self, self.displayGo_)

	self.heroAvatarView_:SetShowInteractive(true)

	self.toggles_ = {
		self.toggle1_,
		self.toggle2_
	}
	self.infoView = MatrixHeroAttributePageCom.New(self, self.infoViewGo_)
end

function MatrixHeroView:ShortHeadRenderer(arg_6_1, arg_6_2)
	local var_6_0 = self.heroList_[arg_6_1]

	arg_6_2.gameObject_.name = tostring(self.heroList_[arg_6_1])

	arg_6_2:SetSize("short")
	arg_6_2:SetHeroId(var_6_0)
	arg_6_2:SetSelected(var_6_0 == self.curHeroId_)
	arg_6_2:RegisterClickListener(function()
		self:SelectHero(var_6_0)
	end)
end

function MatrixHeroView:LongHeadRenderer(arg_8_1, arg_8_2)
	local var_8_0 = self.heroList_[arg_8_1]

	arg_8_2.gameObject_.name = tostring(self.heroList_[arg_8_1])

	arg_8_2:SetSize("long")
	arg_8_2:SetHeroId(var_8_0)
	arg_8_2:SetSelected(var_8_0 == self.curHeroId_)
	arg_8_2:RegisterClickListener(function()
		self:SelectHero(var_8_0)
	end)
end

function MatrixHeroView:SelectHero(arg_10_1)
	local var_10_0 = arg_10_1 ~= self.curHeroId_

	if self.curHeroId_ ~= nil and self.curHeroId_ ~= arg_10_1 and self.curPageIndex_ ~= 1 then
		self.waitToPlayInteraction_ = true
	end

	self.curHeroId_ = arg_10_1

	for iter_10_0, iter_10_1 in pairs(self.curScrollHelper_:GetItemList()) do
		iter_10_1:SetSelected(iter_10_1:GetHeroStandardId() == arg_10_1)
	end

	if self.dirty_ then
		self:SwitchPage(1)

		self.dirty_ = false
	else
		self:SwitchPage(self.curPageIndex_)
	end

	self:UpdateHeroView()

	self.toggles_[self.curPageIndex_].isOn = true
	self.params_.hid = arg_10_1

	if var_10_0 then
		if self.pages_[self.curPageIndex_] then
			self.pages_[self.curPageIndex_]:PlayEnterAni()
		end

		if self.curPageIndex_ == self.pageIndexS_.astrolabe then
			manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
		end
	end
end

function MatrixHeroView:SwitchToDetail()
	self.mainPageController_:SetSelectedState("detail")

	local var_11_0 = table.indexof(self.heroList_, self.curHeroId_)

	if var_11_0 then
		self.shortScrollHelper_:StartScroll(#self.heroList_, var_11_0)
	end

	self.playableDirector_.time = 0

	self.playableDirector_:Play()
end

function MatrixHeroView:AddUIListener()
	self:AddBtnListener(self.detailBtn_, nil, function()
		self:SwitchToDetail()
	end)
	self:AddBtnListener(self.allHeroBtn_, nil, function()
		self.mainPageController_:SetSelectedState("list")

		local var_14_0 = table.indexof(self.heroList_, self.curHeroId_)

		if var_14_0 then
			self.completeScrollHelper_:StartScroll(#self.heroList_, var_14_0)
		end
	end)
	self.mainPageController_:AddSelectChangeListener(function(arg_15_0)
		self.curScrollHelper_ = self.mainPageController_:GetSelectedState() == "detail" and self.shortScrollHelper_ or self.completeScrollHelper_

		self:SelectHero(self.curHeroId_)
	end)

	for iter_12_0, iter_12_1 in pairs(self.toggles_) do
		iter_12_1.onValueChanged:AddListener(function(arg_16_0)
			if arg_16_0 then
				self:SwitchPage(iter_12_0)

				if self.pages_[iter_12_0] then
					self.pages_[iter_12_0]:SetMatirxHeroInfo(self.curHeroId_)
				end

				print(iter_12_0)
			end
		end)
	end
end

function MatrixHeroView:SwitchPage(arg_17_1)
	local var_17_0 = true
	local var_17_1 = ""

	if self.pageConditionList_[arg_17_1] then
		var_17_0, var_17_1 = self.pageConditionList_[arg_17_1]()
	end

	if not var_17_0 then
		ShowTips(var_17_1)

		self.toggles_[self.curPageIndex_].isOn = true

		return
	end

	if self.curPageIndex_ == arg_17_1 and not self.dirty_ then
		return
	end

	self.heroAvatarView_:SetShowInteractive(false)

	if self.pages_[self.curPageIndex_] then
		self.pages_[self.curPageIndex_]:Hide()
	end

	local var_17_2 = self.curPageIndex_

	self.curPageIndex_ = arg_17_1

	if not self.pages_[arg_17_1] then
		if self.prefabList_[arg_17_1] and self.ClassList_[arg_17_1] then
			self.pages_[arg_17_1] = self.ClassList_[arg_17_1].New(self, (Object.Instantiate(Asset.Load(self.prefabList_[arg_17_1]), self.pageContainer_)))

			self:CheckPageEnter(arg_17_1)
		end
	else
		self.pages_[self.curPageIndex_]:Show()
	end

	if self.curPageIndex_ == self.pageIndexS_.astrolabe then
		manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
	end

	self:UpdateAvatarView()

	if not self.dirty_ and var_17_2 ~= nil and var_17_2 ~= arg_17_1 and arg_17_1 == 1 and self.waitToPlayInteraction_ then
		if self.heroAvatarView_ then
			self.heroAvatarView_:PlayChangeRoleInteraction()
		end

		self.waitToPlayInteraction_ = false
	end

	self:RecordStay(var_17_2)
end

function MatrixHeroView:UpdateAvatarView()
	if self.mainPageController_:GetSelectedState() == "detail" and self.curPageIndex_ == self.pageIndexS_.astrolabe then
		self.heroAvatarView_:ShowHeroModel(false)

		if self.curPageIndex_ == self.pageIndexS_.astrolabe then
			self.heroAvatarView_:SetCameraToPage("heroAstrolabe")
		else
			self.heroAvatarView_:SwitchCameraToCurrentHero(false)
		end
	else
		self.heroAvatarView_:SetSkinId(MatrixData:GetHeroSkin(HeroStandardSystemCfg[self.curHeroId_].hero_id))
		self.heroAvatarView_:ShowHeroModel(true)
		self.heroAvatarView_:SwitchCameraToCurrentHero(false)
	end
end

function MatrixHeroView:CheckPageEnter(arg_19_1)
	if not self.enteredPage_[arg_19_1] then
		self.pages_[arg_19_1]:OnEnter()

		self.enteredPage_[arg_19_1] = true
	end
end

function MatrixHeroView:UpdateHeroView()
	self:UpdateAvatarView()

	for iter_20_0, iter_20_1 in pairs(self.pages_) do
		iter_20_1:SetMatirxHeroInfo(self.curHeroId_)
	end

	if self.mainPageController_:GetSelectedState() == "list" then
		self.infoView:SetMatirxHeroInfo(self.curHeroId_)
	end
end

function MatrixHeroView:OnTop()
	if self.pages_ then
		for iter_21_0, iter_21_1 in pairs(self.pages_) do
			iter_21_1:OnTop()
		end
	end

	if self.heroAvatarView_ then
		self.heroAvatarView_:OnTop()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
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
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
end

function MatrixHeroView:OnBehind()
	if self.heroAvatarView_ then
		self.heroAvatarView_:OnBehind()
	end
end

function MatrixHeroView:OnEnter()
	self.heroList_ = MatrixData:GetReadyHeroList()

	manager.windowBar:RegistBackCallBack(function()
		if self.mainPageController_:GetSelectedState() == "list" then
			self:SwitchToDetail()
		else
			JumpTools:Back()
		end
	end)
	manager.ui:SetMainCamera("hero")

	self.enteredPage_ = {}

	local var_23_0 = 1

	if self.heroAvatarView_ then
		if self.params_.isEnter then
			self:OnMainHomeViewTop()

			self.params_.isEnter = nil
		end

		self.heroAvatarView_:OnEnter()
	end

	for iter_23_0, iter_23_1 in pairs(self.pages_) do
		self:CheckPageEnter(iter_23_0)
	end

	local var_23_1 = #self.heroList_

	if self.params_.hid then
		self:SelectHero(self.params_.hid)
	else
		self:SelectHero(self.heroList_[1])
	end

	for iter_23_2 = 1, #self.heroList_ do
		if self.curHeroId_ == self.heroList_[iter_23_2] then
			var_23_0 = iter_23_2

			break
		end
	end

	local var_23_2 = "detail"

	self.mainPageController_:SetSelectedState("detail")

	if self.mainPageController_:GetSelectedState() == var_23_2 then
		self.shortScrollHelper_:StartScroll(var_23_1, var_23_0)
	else
		self.completeScrollHelper_:StartScroll(var_23_1, var_23_0)
	end
end

function MatrixHeroView:ConditionOK()
	return true, ""
end

function MatrixHeroView:OnMainHomeViewTop()
	self.dirty_ = true

	if self.heroAvatarView_ then
		self.heroAvatarView_:OnMainHomeViewTop()
	end
end

function MatrixHeroView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()

	if self.heroAvatarView_ then
		self.heroAvatarView_:OnExit()
	end

	if self.pages_ then
		for iter_27_0, iter_27_1 in pairs(self.pages_) do
			iter_27_1:OnExit()
		end
	end

	self.curHeroId_ = nil

	if self.talkTimer_ then
		self.talkTimer_:Stop()

		self.talkTimer_ = nil
	end

	HeroTools.StopTalk()
	self:RecordStay(self.curPageIndex_)
end

function MatrixHeroView:Dispose()
	self.mainPageController_:RemoveAllListeners()
	self:RemoveAllListeners()

	if self.shortScrollHelper_ then
		self.shortScrollHelper_:Dispose()

		self.shortScrollHelper_ = nil
	end

	if self.completeScrollHelper_ then
		self.completeScrollHelper_:Dispose()

		self.completeScrollHelper_ = nil
	end

	if self.heroAvatarView_ then
		self.heroAvatarView_:Dispose()

		self.heroAvatarView_ = nil
	end

	if self.pages_ then
		for iter_28_0, iter_28_1 in pairs(self.pages_) do
			iter_28_1:Dispose()
		end

		self.pages_ = nil
	end

	if self.toggles_ then
		for iter_28_2, iter_28_3 in pairs(self.toggles_) do
			iter_28_3.onValueChanged:RemoveAllListeners()
		end

		self.toggles_ = nil
	end

	MatrixHeroView.super.Dispose(self)
end

function MatrixHeroView:RecordStay(arg_29_1)
	local var_29_0 = self:GetStayTime()

	if var_29_0 == 0 then
		return
	end

	local var_29_1 = 0

	if arg_29_1 == self.pageIndexS_.skill then
		var_29_1 = 30106
	elseif arg_29_1 == self.pageIndexS_.astrolabe then
		var_29_1 = 30107
	end

	OperationRecorder.RecordStayView("STAY_VIEW_MATRIX_HERO", var_29_0, var_29_1)
	self:UpdateLastOpenTime()
end

return MatrixHeroView
