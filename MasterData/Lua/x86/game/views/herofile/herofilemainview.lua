local HeroFileMainView = class("HeroFileMainView", ReduxView)

function HeroFileMainView:UIName()
	return "Widget/System/Hero_files/HeroFileMainUI"
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
		Voice = 4,
		Gift = 3
	}
	self.subPagePrefabPath_ = {
		"Widget/System/Hero_files/HeroFileInformationPageUI",
		"Widget/System/Hero_files/HeroFileArchivePageUI",
		"Widget/System/Hero_files/HeroFileGiftPageUI",
		"Widget/System/Hero_files/HeroFileVoicePageUI"
	}
	self.subPageClass_ = {
		HeroFileInformationPage,
		HeroFileArchivePage,
		HeroFileGiftPage,
		HeroFileVoicePage
	}
	self.subPageTab_ = {
		self.informationBtn_,
		self.archiveBtn_,
		self.giftBtn_,
		self.voiceBtn_
	}
	self.subPageTabState_ = {
		"Information",
		"Archive",
		"Gift",
		"Voice"
	}
	self.formList_ = nil
	self.formState_ = 1
	self.tipsLuaUIlist_ = LuaList.New(handler(self, self.IndexTipsItem), self.tipsUIlist_, HeroFileMainTipsItem)
	self.subPageTabController_ = self.tablistControllerEx_:GetController("tabSelect")
	self.favorabilityController_ = self.FavorabilityControllerEx_:GetController("favorability")
end

function HeroFileMainView:AddUIListeners()
	for iter_5_0, iter_5_1 in ipairs(self.subPageTab_) do
		self:AddBtnListener(iter_5_1, nil, function()
			self:SwitchPage(iter_5_0)
		end)
	end

	self:AddBtnListener(self.FavorabilityBtn_, nil, function()
		self:ShowFavorabilityTips()
	end)
	self:AddBtnListener(self.tipsCloseBtn_, nil, function()
		self:HideFavorabilityTips()
	end)
end

function HeroFileMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.formState_ = 1
	self.curHeroID_ = self.params_.heroID

	self:PrepareHeroFormInfo(self.curHeroID_)

	self.curRecordID_ = HeroTools.GetHeroOntologyID(self.curHeroID_)
	self.curPageIndex_ = 0

	self:RefreshRoleTab()
	self:UpdateAvatarView()
	self:RefreshCV()
	self:SwitchPage(self.params_.pageID or 1)
	self:RefreshFavorabilityIcon()
	HeroAction.QueryHeroNewData(self.curHeroID_)
	ArchiveAction.CheckHeroTrustUpLvRedPoint(self.curHeroID_)
	self:RegistEventListener(HERO_DATA_MODIFY, handler(self, self.OnHeroModify))
	manager.redPoint:bindUIandKey(self.informationTrs_, string.format("%s_%s", RedPointConst.HERO_REALTION, self.curHeroID_))
	manager.redPoint:bindUIandKey(self.archiveTrs_, RedPointConst.HERO_HEARTLINK_ID .. self.curRecordID_)
	manager.redPoint:bindUIandKey(self.giftTrs_, string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, self.curHeroID_))
end

function HeroFileMainView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		3
	})
end

function HeroFileMainView:OnExit()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	self:HideFavorabilityTips()
	self:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(self.informationTrs_)
	manager.redPoint:unbindUIandKey(self.archiveTrs_)
	manager.redPoint:unbindUIandKey(self.giftTrs_)

	if self.subPages_[self.curPageIndex_] then
		self.subPages_[self.curPageIndex_]:Hide()
	end

	self.curPageIndex_ = 0
	self.params_.heroID = self.curHeroID_

	HeroTools.StopTalk()
end

function HeroFileMainView:IndexTipsItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_1, self.curHeroID_)
end

function HeroFileMainView:SwitchPage(arg_13_1)
	if arg_13_1 == self.subPageIndex_.Voice then
		if not HeroTools.GetHeroIsUnlock(self.curHeroID_) then
			ShowTips("ERROR_HERO_NOT_UNLOCK")

			return
		end
	else
		self.formState_ = 1
	end

	if arg_13_1 == self.curPageIndex_ then
		return
	end

	if self.subPages_[self.curPageIndex_] then
		self.subPages_[self.curPageIndex_]:Hide()
	end

	self.subPageTabController_:SetSelectedState(self.subPageTabState_[arg_13_1])

	self.subPages_[arg_13_1] = self.subPages_[arg_13_1] or self.subPageClass_[arg_13_1].New(Object.Instantiate(Asset.Load(self.subPagePrefabPath_[arg_13_1]), self.pagecontentTrs_), function(arg_14_0)
		self:RefreshFavorabilityIcon(arg_14_0)
	end)

	if self.formState_ then
		self.subPages_[arg_13_1]:Show(self.curRecordID_, self.curHeroID_, true, self:GetFormID(self.curHeroID_))
	else
		self.subPages_[arg_13_1]:Show(self.curRecordID_, self.curHeroID_)
	end

	self.curPageIndex_ = arg_13_1
	self.params_.pageID = arg_13_1

	self:UpdateRoleSwitchTab()
	self:UpdateAvatarView()
	self:RefreshCV()
end

function HeroFileMainView:RefreshFavorabilityIcon(arg_15_1)
	local var_15_0 = {
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

	if arg_15_1 then
		self.likeLvText_.text = var_15_0[arg_15_1]
	else
		local var_15_1 = ArchiveData:GetTrustLevel(self.curHeroID_)

		if var_15_1 > 0 then
			self.favorabilityController_:SetSelectedState("Trust")

			self.trustLvText_.text = ArchiveTools.GetTrustLvDes(var_15_1)
		else
			self.favorabilityController_:SetSelectedState("Like")

			self.likeLvText_.text = var_15_0[LvTools.LoveExpToLevel(ArchiveData:GetArchive(self.curRecordID_).exp)]
		end
	end
end

function HeroFileMainView:RefreshRoleTab()
	self.roleList_ = {}

	for iter_16_0, iter_16_1 in ipairs(HeroRecordCfg[self.curRecordID_].hero_id) do
		if HeroCfg[iter_16_1].private ~= 1 and not HeroTools.GetIsHide(iter_16_1) then
			table.insert(self.roleList_, iter_16_1)
		end
	end

	for iter_16_2 = 1, #self.roleTabs_ do
		self.roleTabs_[iter_16_2]:Hide()
		self.roleTabs_[iter_16_2]:SetSelectState(false)
	end

	for iter_16_3 = 1, #self.roleList_ do
		self.roleTabs_[iter_16_3] = self.roleTabs_[iter_16_3] or HeroFileRoleTabItem.New(Object.Instantiate(self.heroItemGo_, self.heroTabTrs_), function()
			self:OnClickRoleTab(iter_16_3)
		end, function()
			self:OnClickSwitchRoleTab(iter_16_3)
		end)

		self.roleTabs_[iter_16_3]:Show(self.roleList_[iter_16_3])

		if self.roleList_[iter_16_3] == self.curHeroID_ then
			self.roleTabs_[iter_16_3]:SetSelectState(true)

			self.roleIndex_ = iter_16_3
		end
	end
end

function HeroFileMainView:RefreshCV()
	local var_19_0 = GetI18NText(HeroRecordCfg[self.curRecordID_]["cv_" .. VoiceLanguageCfg[SettingData:GetSoundSettingData().voice_language].affix]) or ""

	if self.formState_ then
		local var_19_1 = {}

		for iter_19_0 in string.gmatch(var_19_0 or "", "[^\n]+") do
			table.insert(var_19_1, iter_19_0)
		end

		var_19_0 = #var_19_1 > 0 and var_19_1[math.min(self.formState_, #var_19_1)] or ""
		self.cvText_.text = "CV " .. var_19_0
	end
end

local function var_0_1(arg_20_0, arg_20_1)
	return arg_20_0 % arg_20_1 + 1
end

function HeroFileMainView:OnClickRoleTab(arg_21_1)
	if self.curPageIndex_ == self.subPageIndex_.Voice and not HeroTools.GetHeroIsUnlock(self.roleList_[arg_21_1]) then
		ShowTips("ERROR_HERO_NOT_UNLOCK")

		return
	end

	if arg_21_1 == self.roleIndex_ then
		return
	end

	self.formState_ = var_0_1(self.formState_, self:GetFormCnt())

	manager.redPoint:unbindUIandKey(self.informationTrs_, string.format("%s_%s", RedPointConst.HERO_REALTION, self.curHeroID_))
	manager.redPoint:unbindUIandKey(self.giftTrs_, string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, self.curHeroID_))

	if self.roleTabs_[self.roleIndex_] then
		self.roleTabs_[self.roleIndex_]:SetSelectState(false)
	end

	self.roleTabs_[arg_21_1]:SetSelectState(true)

	self.roleIndex_ = arg_21_1
	self.curHeroID_ = self.roleList_[arg_21_1]

	self:PrepareHeroFormInfo(self.curHeroID_)
	HeroAction.QueryHeroNewData(self.curHeroID_)

	if self.formState_ then
		self.subPages_[self.curPageIndex_]:Show(self.curRecordID_, self.curHeroID_, true, self:GetFormID(self.curHeroID_))
	else
		self.subPages_[self.curPageIndex_]:Show(self.curRecordID_, self.curHeroID_)
	end

	self:RefreshFavorabilityIcon()
	self:UpdateRoleSwitchTab()
	self:UpdateAvatarView()
	ArchiveAction.CheckHeroTrustUpLvRedPoint(self.curHeroID_)
	manager.redPoint:bindUIandKey(self.informationTrs_, string.format("%s_%s", RedPointConst.HERO_REALTION, self.curHeroID_))
	manager.redPoint:bindUIandKey(self.giftTrs_, string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, self.curHeroID_))
	OperationRecorder.Record("hero", "hero_record_switch")
end

function HeroFileMainView:OnClickSwitchRoleTab(arg_22_1)
	if arg_22_1 ~= self.roleIndex_ then
		return
	end

	self:ChangeFormState(arg_22_1, (var_0_1(self.formState_, self.formCnt_)))
end

function HeroFileMainView:ChangeFormState(arg_23_1, arg_23_2)
	self.formState_ = arg_23_2

	local var_23_0 = self:GetFormID(self.curHeroID_)

	if self.formState_ then
		self:RefreshCV()
		self.roleTabs_[arg_23_1]:ShowWithSkinID(var_23_0)
	else
		self.roleTabs_[arg_23_1]:Show(self.roleList_[arg_23_1])
	end

	self:UpdateAvatarView()

	if self.curPageIndex_ == self.subPageIndex_.Voice then
		if self.formState_ then
			self.subPages_[self.curPageIndex_]:Show(self.curRecordID_, self.curHeroID_, true, var_23_0)
		else
			self.subPages_[self.curPageIndex_]:Show(self.curRecordID_, self.curHeroID_)
		end
	end
end

function HeroFileMainView:UpdateRoleSwitchTab()
	for iter_24_0 = 1, #self.roleList_ do
		local var_24_0 = self.roleTabs_[iter_24_0]
		local var_24_1 = iter_24_0 == self.roleIndex_

		self.roleTabs_[iter_24_0]:SetCanForm(self.curPageIndex_ == self.subPageIndex_.Voice and var_24_1 and self:CheckHaveForm(self.roleList_[iter_24_0]))

		if var_24_1 then
			var_24_0:ShowWithSkinID((self:GetFormID(self.curHeroID_)))
		else
			var_24_0:Show(self.roleList_[iter_24_0])
		end
	end
end

function HeroFileMainView:UpdateAvatarView()
	local var_25_1 = self:GetFormID(nil, (self.curPageIndex_ ~= self.subPageIndex_.Voice or nil) and 1)

	if SkinCfg[var_25_1] and SkinCfg[var_25_1].modelId ~= "" then
		manager.heroRaiseTrack:SetModelState(var_25_1)
	end
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
	if self.subPages_[self.subPageIndex_.Gift] then
		self.subPages_[self.subPageIndex_.Gift]:OnHeroTrustUpdate()
	end

	self:RefreshFavorabilityIcon()
end

function HeroFileMainView:OnSendGift(arg_29_1, arg_29_2)
	if self.subPages_[self.subPageIndex_.Gift] then
		self.subPages_[self.subPageIndex_.Gift]:OnSendGift()
	end

	self:RefreshFavorabilityIcon()
end

function HeroFileMainView:OnHeroModify()
	if self.subPages_[self.subPageIndex_.Gift] then
		self.subPages_[self.subPageIndex_.Gift]:OnHeroModify()
	end
end

function HeroFileMainView:Dispose()
	for iter_31_0, iter_31_1 in pairs(self.subPages_) do
		iter_31_1:Dispose()
	end

	for iter_31_2, iter_31_3 in pairs(self.roleTabs_) do
		iter_31_3:Dispose()
	end

	self.tipsLuaUIlist_:Dispose()
	HeroFileMainView.super.Dispose(self)
end

function HeroFileMainView:CollectHeroForm(arg_32_1)
	local var_32_0 = HeroSkinExtraFormCfg.get_id_list_by_original_form[HeroTools.HeroUsingSkinInfo(arg_32_1).id]

	if var_32_0 == nil then
		return nil
	end

	local var_32_1 = {}

	for iter_32_0, iter_32_1 in pairs(var_32_0) do
		table.insert(var_32_1, HeroSkinExtraFormCfg[iter_32_1].form_id)
	end

	table.sort(var_32_1)

	return var_32_1, #var_32_1
end

function HeroFileMainView:PrepareHeroFormInfo(arg_33_1)
	self.formList_, self.formCnt_ = self:CollectHeroForm(arg_33_1)
end

function HeroFileMainView:CheckHaveForm(arg_34_1)
	return self.formList_ ~= nil and next(self.formList_) ~= nil
end

function HeroFileMainView:GetFormCnt(arg_35_1)
	return self.formCnt_ or 1
end

function HeroFileMainView:GetFormID(arg_36_1, arg_36_2)
	arg_36_2 = arg_36_2 or self.formState_

	return nullable(self.formList_, arg_36_2) or HeroTools.HeroUsingSkinInfo(self.curHeroID_).id
end

return HeroFileMainView
