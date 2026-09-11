local HeroFileMainView = class("HeroFileMainView", ReduxView)

function HeroFileMainView:UIName()
	return "Widget/System/CharacterGuideUI/CharacterFileMainUI"
end

function HeroFileMainView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroFileMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function HeroFileMainView:InitUI()
	self:BindCfgUI()

	self.curHeroID_ = 0
	self.curRecordID_ = 0
	self.roleIndex_ = 0
	self.roleTabs_ = {}
	self.roleList_ = {}
	self.curPageIndex_ = 0
	self.subPages_ = {}
	self.subPageIndex_ = {
		Archive = 2,
		Information = 1,
		Voice = 3
	}
	self.subPagePrefabPath_ = {
		"Widget/System/CharacterGuideUI/CharacterFileInformationPageUI",
		"Widget/System/CharacterGuideUI/CharacterArchivePageUI",
		"Widget/System/CharacterGuideUI/CharacterVoicePageUI",
		"Widget/System/Hero_skill/HeroSkillPageUI",
		"Widget/System/Hero_key/HeroKeyUI",
		"Widget/System/Hero_god/HeroGodUI"
	}
	self.subPageClass_ = {
		HeroPreviewFileInformationPage,
		HeroPreviewFileArchivePage,
		HeroPreviewFileVoicePage,
		HeroSkillPage,
		HeroWeaponPage,
		NewHeroAstrolabePage
	}
	self.subPageTab_ = {
		self.informationBtn_,
		self.archiveBtn_,
		self.voiceBtn_,
		self.skillBtn_,
		self.weaponBtn_,
		self.astrolabeBtn_
	}
	self.tipsLuaUIlist_ = LuaList.New(handler(self, self.IndexTipsItem), self.tipsUIlist_, HeroFileMainTipsItem)
	self.favorabilityController_ = self.FavorabilityControllerEx_:GetController("favorability")
	self.astrolabeController_ = ControllerUtil.GetController(self.astrolabeBtn_.transform, "lock")
end

function HeroFileMainView:AddUIListeners()
	for iter_5_0, iter_5_1 in pairs(self.subPageTab_) do
		iter_5_1.onValueChanged:AddListener(function(arg_6_0)
			if arg_6_0 then
				self:SwitchPage(iter_5_0)
			end
		end)
	end

	self:AddBtnListener(self.FavorabilityBtn_, nil, function()
		self:ShowFavorabilityTips()
	end)
	self:AddBtnListener(self.tipsCloseBtn_, nil, function()
		self:HideFavorabilityTips()
	end)
end

function HeroFileMainView:OnTop()
	if self.subPages_ then
		for iter_9_0, iter_9_1 in pairs(self.subPages_) do
			iter_9_1:OnTop()
		end
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function HeroFileMainView:CameraEnter()
	return
end

function HeroFileMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.PREVIEW)
	self.changeHero_ = self.curHeroID_ ~= self.params_.hid
	self.curHeroID_ = self.params_.hid
	self.curRecordID_ = HeroTools.GetHeroOntologyID(self.curHeroID_)
	self.heroInfo_ = self.heroViewProxy_:GetHeroData(self.curHeroID_)
	self.isEnter = self.params_.isEnter
	self.isDraw = self.params_.isDraw or false
	self.enteredPage_ = {}

	for iter_11_0, iter_11_1 in pairs(self.subPages_) do
		self:CheckPageEnter(iter_11_0)
	end

	self:SwitchPage(self.params_.pageID or 1, self.changeHero_)
	self:RefreshRoleTab()
	self:RefreshCV()
	self:CheckLocked()

	self.subPageTab_[self.params_.pageID or 1].isOn = true

	self:RefreshFavorabilityIcon()
	ArchiveAction.CheckHeroTrustUpLvRedPoint(self.curHeroID_)
	self:ChangeAstrolabeIcon()
	self.animator_:Play("HeroFileMainUI", 0)
	self.animator_:Update(0)
end

function HeroFileMainView:CheckLocked()
	SetActive(self.archiveBtn_.gameObject, self.heroInfo_.unlock == 1)
	SetActive(self.voiceBtn_.gameObject, self.heroInfo_.unlock == 1)
end

function HeroFileMainView:ChangeAstrolabeIcon()
	self.astrolabeController_:SetSelectedState((HeroTools.IsSpHero(self.curHeroID_) and "sp" or "") .. "false")
end

function HeroFileMainView:OnExit()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	self:HideFavorabilityTips()
	self:RemoveAllEventListener()

	if self.subPages_ then
		for iter_14_0, iter_14_1 in pairs(self.subPages_) do
			iter_14_1:Hide()
		end
	end

	self.curPageIndex_ = nil

	HeroTools.StopTalk()
	manager.heroRaiseTrack:CancelAllAsyncLoadModelOp()
end

function HeroFileMainView:IndexTipsItem(arg_15_1, arg_15_2)
	arg_15_2:SetData(arg_15_1, self.curHeroID_)
end

function HeroFileMainView:CheckPageEnter(arg_16_1)
	if not self.enteredPage_[arg_16_1] then
		self.subPages_[arg_16_1]:OnEnter(self.heroViewProxy_, self.params_)

		self.enteredPage_[arg_16_1] = true
	end
end

function HeroFileMainView:SwitchPage(arg_17_1, arg_17_2)
	self:HideWeakGuide()

	if arg_17_1 == self.curPageIndex_ and not arg_17_2 then
		if self.subPages_[self.curPageIndex_].UpdateView then
			self.subPages_[self.curPageIndex_]:UpdateView(self.curRecordID_, self.curHeroID_, self.isDraw)
		end

		self.subPages_[self.curPageIndex_]:CameraEnter()

		return
	end

	if self.subPages_[self.curPageIndex_] then
		self.subPages_[self.curPageIndex_]:Hide()
	end

	if not self.subPages_[arg_17_1] then
		local var_17_0 = Object.Instantiate(Asset.Load(self.subPagePrefabPath_[arg_17_1]), self.pagecontentTrs_)

		self.subPages_[arg_17_1] = arg_17_1 < 4 and self.subPageClass_[arg_17_1].New(var_17_0, function(arg_18_0)
			self:RefreshFavorabilityIcon(arg_18_0)
		end) or self.subPageClass_[arg_17_1].New(self, var_17_0, function(arg_19_0)
			self:RefreshFavorabilityIcon(arg_19_0)
		end)
	end

	if self.isEnter then
		self:CheckPageEnter(arg_17_1)
	end

	if self.subPages_[arg_17_1].SetHeroInfo then
		self.subPages_[arg_17_1]:SetHeroInfo(self.heroInfo_)
	end

	if self.subPages_[arg_17_1].HideMaskMessage then
		self.subPages_[arg_17_1]:HideMaskMessage()
	end

	self.subPages_[arg_17_1]:Show(self.curRecordID_, self.curHeroID_, self.isDraw)
	self.subPages_[arg_17_1]:CameraEnter()

	self.curPageIndex_ = arg_17_1
	self.params_.pageID = arg_17_1

	if (arg_17_2 or self.isEnter) and self.curPageIndex_ == 1 then
		HeroTools.StopTalk()
		manager.heroRaiseTrack:PlayTalk()
	end
end

function HeroFileMainView:RefreshFavorabilityIcon(arg_20_1)
	local var_20_0 = {
		"Ⅰ",
		"Ⅱ",
		"Ⅲ",
		"Ⅳ",
		"Ⅴ",
		"Ⅵ",
		"Ⅶ",
		"Ⅷ",
		"Ⅸ"
	}

	if arg_20_1 then
		self.likeLvText_.text = var_20_0[arg_20_1]
	else
		local var_20_1 = ArchiveData:GetTrustLevel(self.curHeroID_)

		if var_20_1 > 0 then
			self.favorabilityController_:SetSelectedState("Trust")

			self.trustLvText_.text = ArchiveTools.GetTrustLvDes(var_20_1)
		else
			self.favorabilityController_:SetSelectedState("Like")

			self.likeLvText_.text = var_20_0[LvTools.LoveExpToLevel(ArchiveData:GetArchive(self.curRecordID_).exp)]
		end
	end
end

function HeroFileMainView:RefreshRoleTab()
	self.roleList_ = {}

	for iter_21_0, iter_21_1 in ipairs(HeroRecordCfg[self.curRecordID_].hero_id) do
		if HeroCfg[iter_21_1].private ~= 1 and not HeroTools.GetIsHide(iter_21_1) then
			table.insert(self.roleList_, iter_21_1)
		end
	end

	for iter_21_2 = 1, #self.roleTabs_ do
		self.roleTabs_[iter_21_2]:Hide()
		self.roleTabs_[iter_21_2]:SetSelectState(false)
	end

	for iter_21_3 = 1, #self.roleList_ do
		self.roleTabs_[iter_21_3] = self.roleTabs_[iter_21_3] or HeroFileRoleTabItem.New(Object.Instantiate(self.heroItemGo_, self.heroTabTrs_), function()
			self:OnClickRoleTab(iter_21_3)
		end)

		self.roleTabs_[iter_21_3]:Show(self.roleList_[iter_21_3])
		self.roleTabs_[iter_21_3].animator_:Play("HeroFileMainUI_item02", 0)
		self.roleTabs_[iter_21_3].animator_:Update(0)
		self:UpdateAvatarView()

		if self.roleList_[iter_21_3] == self.curHeroID_ then
			self.roleTabs_[iter_21_3]:SetSelectState(true)

			self.roleIndex_ = iter_21_3
		end
	end
end

function HeroFileMainView:RefreshCV()
	self.cvText_.text = "CV " .. (GetI18NText(HeroRecordCfg[self.curRecordID_]["cv_" .. VoiceLanguageCfg[SettingData:GetSoundSettingData().voice_language].affix]) or "")
end

function HeroFileMainView:OnClickRoleTab(arg_24_1)
	if arg_24_1 == self.roleIndex_ then
		return
	end

	if self.roleTabs_[self.roleIndex_] then
		self.roleTabs_[self.roleIndex_]:SetSelectState(false)
	end

	self.roleTabs_[arg_24_1]:SetSelectState(true)

	self.roleIndex_ = arg_24_1
	self.curHeroID_ = self.roleList_[arg_24_1]
	self.params_.hid = self.roleList_[arg_24_1]
	self.curRecordID_ = HeroTools.GetHeroOntologyID(self.curHeroID_)
	self.heroInfo_ = self.heroViewProxy_:GetHeroData(self.curHeroID_)

	local var_24_0 = self.curPageIndex_

	if self.heroInfo_.unlock == 0 and (self.curPageIndex_ == 2 or self.curPageIndex_ == 3) then
		var_24_0 = 1
	end

	self:RefreshFavorabilityIcon()
	self:CheckLocked()
	self:UpdateAvatarView()

	if self.subPageTab_[var_24_0].isOn then
		self:SwitchPage(var_24_0, true)
	end

	self.subPageTab_[var_24_0].isOn = true

	ArchiveAction.CheckHeroTrustUpLvRedPoint(self.curHeroID_)
	OperationRecorder.Record("hero", "hero_record_switch")
end

function HeroFileMainView:UpdateAvatarView()
	manager.heroRaiseTrack:SetModelState(HeroTools.HeroUsingSkinInfo(self.curHeroID_).id)
end

function HeroFileMainView:ShowFavorabilityTips()
	if ArchiveData:GetTrustLevel(self.curHeroID_) > 0 then
		self.tipsLuaUIlist_:StartScroll(HeroConst.HERO_TRUST_LV_MAX)
		SetActive(self.FavorabilityTipsGo_, true)
	end
end

function HeroFileMainView:HideFavorabilityTips()
	SetActive(self.FavorabilityTipsGo_, false)
end

function HeroFileMainView:OnHeroTrustUpdate()
	self:RefreshFavorabilityIcon()
end

function HeroFileMainView:OnSendGift(arg_29_1, arg_29_2)
	self:RefreshFavorabilityIcon()
end

function HeroFileMainView:Dispose()
	for iter_30_0, iter_30_1 in pairs(self.subPages_) do
		iter_30_1:Dispose()
	end

	for iter_30_2, iter_30_3 in pairs(self.roleTabs_) do
		iter_30_3:Dispose()
	end

	self.tipsLuaUIlist_:Dispose()
	HeroFileMainView.super.Dispose(self)
end

function HeroFileMainView:GetCurHeroID()
	return self.curHeroID_
end

return HeroFileMainView
