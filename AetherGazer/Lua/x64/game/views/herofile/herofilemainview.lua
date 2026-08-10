local var_0_0 = class("HeroFileMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_files/HeroFileMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.curHeroID_ = 0
	arg_4_0.curRecordID_ = 0
	arg_4_0.roleIndex_ = 0
	arg_4_0.roleTabs_ = {}
	arg_4_0.roleList_ = {}
	arg_4_0.curPageIndex_ = 0
	arg_4_0.subPages_ = {}
	arg_4_0.subPageIndex_ = {
		Archive = 2,
		Information = 1,
		Voice = 4,
		Gift = 3
	}
	arg_4_0.subPagePrefabPath_ = {
		"Widget/System/Hero_files/HeroFileInformationPageUI",
		"Widget/System/Hero_files/HeroFileArchivePageUI",
		"Widget/System/Hero_files/HeroFileGiftPageUI",
		"Widget/System/Hero_files/HeroFileVoicePageUI"
	}
	arg_4_0.subPageClass_ = {
		HeroFileInformationPage,
		HeroFileArchivePage,
		HeroFileGiftPage,
		HeroFileVoicePage
	}
	arg_4_0.subPageTab_ = {
		arg_4_0.informationBtn_,
		arg_4_0.archiveBtn_,
		arg_4_0.giftBtn_,
		arg_4_0.voiceBtn_
	}
	arg_4_0.subPageTabState_ = {
		"Information",
		"Archive",
		"Gift",
		"Voice"
	}
	arg_4_0.formList_ = nil
	arg_4_0.formState_ = 1
	arg_4_0.tipsLuaUIlist_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexTipsItem), arg_4_0.tipsUIlist_, HeroFileMainTipsItem)
	arg_4_0.subPageTabController_ = arg_4_0.tablistControllerEx_:GetController("tabSelect")
	arg_4_0.favorabilityController_ = arg_4_0.FavorabilityControllerEx_:GetController("favorability")
end

function var_0_0.AddUIListeners(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.subPageTab_) do
		arg_5_0:AddBtnListener(iter_5_1, nil, function()
			arg_5_0:SwitchPage(iter_5_0)
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.FavorabilityBtn_, nil, function()
		arg_5_0:ShowFavorabilityTips()
	end)
	arg_5_0:AddBtnListener(arg_5_0.tipsCloseBtn_, nil, function()
		arg_5_0:HideFavorabilityTips()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_9_0.formState_ = 1
	arg_9_0.curHeroID_ = arg_9_0.params_.heroID

	arg_9_0:PrepareHeroFormInfo(arg_9_0.curHeroID_)

	arg_9_0.curRecordID_ = HeroTools.GetHeroOntologyID(arg_9_0.curHeroID_)
	arg_9_0.curPageIndex_ = 0

	arg_9_0:RefreshRoleTab()
	arg_9_0:UpdateAvatarView()
	arg_9_0:RefreshCV()
	arg_9_0:SwitchPage(arg_9_0.params_.pageID or 1)
	arg_9_0:RefreshFavorabilityIcon()
	HeroAction.QueryHeroNewData(arg_9_0.curHeroID_)
	ArchiveAction.CheckHeroTrustUpLvRedPoint(arg_9_0.curHeroID_)
	arg_9_0:RegistEventListener(HERO_DATA_MODIFY, handler(arg_9_0, arg_9_0.OnHeroModify))
	manager.redPoint:bindUIandKey(arg_9_0.informationTrs_, string.format("%s_%s", RedPointConst.HERO_REALTION, arg_9_0.curHeroID_))
	manager.redPoint:bindUIandKey(arg_9_0.archiveTrs_, RedPointConst.HERO_HEARTLINK_ID .. arg_9_0.curRecordID_)
	manager.redPoint:bindUIandKey(arg_9_0.giftTrs_, string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, arg_9_0.curHeroID_))
end

function var_0_0.CameraEnter(arg_10_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		3
	})
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	arg_11_0:HideFavorabilityTips()
	arg_11_0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(arg_11_0.informationTrs_)
	manager.redPoint:unbindUIandKey(arg_11_0.archiveTrs_)
	manager.redPoint:unbindUIandKey(arg_11_0.giftTrs_)

	if arg_11_0.subPages_[arg_11_0.curPageIndex_] then
		arg_11_0.subPages_[arg_11_0.curPageIndex_]:Hide()
	end

	arg_11_0.curPageIndex_ = 0
	arg_11_0.params_.heroID = arg_11_0.curHeroID_

	HeroTools.StopTalk()
end

function var_0_0.IndexTipsItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_1, arg_12_0.curHeroID_)
end

function var_0_0.SwitchPage(arg_13_0, arg_13_1)
	if arg_13_1 == arg_13_0.subPageIndex_.Voice then
		if not HeroTools.GetHeroIsUnlock(arg_13_0.curHeroID_) then
			ShowTips("ERROR_HERO_NOT_UNLOCK")

			return
		end
	else
		arg_13_0.formState_ = 1
	end

	if arg_13_1 == arg_13_0.curPageIndex_ then
		return
	end

	if arg_13_0.subPages_[arg_13_0.curPageIndex_] then
		arg_13_0.subPages_[arg_13_0.curPageIndex_]:Hide()
	end

	arg_13_0.subPageTabController_:SetSelectedState(arg_13_0.subPageTabState_[arg_13_1])

	if not arg_13_0.subPages_[arg_13_1] then
		local var_13_0 = Asset.Load(arg_13_0.subPagePrefabPath_[arg_13_1])
		local var_13_1 = Object.Instantiate(var_13_0, arg_13_0.pagecontentTrs_)

		arg_13_0.subPages_[arg_13_1] = arg_13_0.subPageClass_[arg_13_1].New(var_13_1, function(arg_14_0)
			arg_13_0:RefreshFavorabilityIcon(arg_14_0)
		end)
	end

	if arg_13_0.formState_ then
		arg_13_0.subPages_[arg_13_1]:Show(arg_13_0.curRecordID_, arg_13_0.curHeroID_, true, arg_13_0:GetFormID(arg_13_0.curHeroID_))
	else
		arg_13_0.subPages_[arg_13_1]:Show(arg_13_0.curRecordID_, arg_13_0.curHeroID_)
	end

	arg_13_0.curPageIndex_ = arg_13_1
	arg_13_0.params_.pageID = arg_13_1

	arg_13_0:UpdateRoleSwitchTab()
	arg_13_0:UpdateAvatarView()
	arg_13_0:RefreshCV()
end

function var_0_0.RefreshFavorabilityIcon(arg_15_0, arg_15_1)
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
		arg_15_0.likeLvText_.text = var_15_0[arg_15_1]
	else
		local var_15_1 = ArchiveData:GetTrustLevel(arg_15_0.curHeroID_)

		if var_15_1 > 0 then
			arg_15_0.favorabilityController_:SetSelectedState("Trust")

			arg_15_0.trustLvText_.text = ArchiveTools.GetTrustLvDes(var_15_1)
		else
			arg_15_0.favorabilityController_:SetSelectedState("Like")

			local var_15_2 = LvTools.LoveExpToLevel(ArchiveData:GetArchive(arg_15_0.curRecordID_).exp)

			arg_15_0.likeLvText_.text = var_15_0[var_15_2]
		end
	end
end

function var_0_0.RefreshRoleTab(arg_16_0)
	arg_16_0.roleList_ = {}

	for iter_16_0, iter_16_1 in ipairs(HeroRecordCfg[arg_16_0.curRecordID_].hero_id) do
		if HeroCfg[iter_16_1].private ~= 1 and not HeroTools.GetIsHide(iter_16_1) then
			table.insert(arg_16_0.roleList_, iter_16_1)
		end
	end

	for iter_16_2 = 1, #arg_16_0.roleTabs_ do
		arg_16_0.roleTabs_[iter_16_2]:Hide()
		arg_16_0.roleTabs_[iter_16_2]:SetSelectState(false)
	end

	for iter_16_3 = 1, #arg_16_0.roleList_ do
		if not arg_16_0.roleTabs_[iter_16_3] then
			local var_16_0 = Object.Instantiate(arg_16_0.heroItemGo_, arg_16_0.heroTabTrs_)

			arg_16_0.roleTabs_[iter_16_3] = HeroFileRoleTabItem.New(var_16_0, function()
				arg_16_0:OnClickRoleTab(iter_16_3)
			end, function()
				arg_16_0:OnClickSwitchRoleTab(iter_16_3)
			end)
		end

		arg_16_0.roleTabs_[iter_16_3]:Show(arg_16_0.roleList_[iter_16_3])

		if arg_16_0.roleList_[iter_16_3] == arg_16_0.curHeroID_ then
			arg_16_0.roleTabs_[iter_16_3]:SetSelectState(true)

			arg_16_0.roleIndex_ = iter_16_3
		end
	end
end

function var_0_0.RefreshCV(arg_19_0)
	local var_19_0 = SettingData:GetSoundSettingData().voice_language
	local var_19_1 = VoiceLanguageCfg[var_19_0].affix
	local var_19_2 = GetI18NText(HeroRecordCfg[arg_19_0.curRecordID_]["cv_" .. var_19_1]) or ""

	if arg_19_0.formState_ then
		local var_19_3 = {}

		for iter_19_0 in string.gmatch(var_19_2 or "", "[^\n]+") do
			table.insert(var_19_3, iter_19_0)
		end

		local var_19_4 = #var_19_3

		if var_19_4 > 0 then
			var_19_2 = var_19_3[math.min(arg_19_0.formState_, var_19_4)]
		else
			var_19_2 = ""
		end

		arg_19_0.cvText_.text = "CV " .. var_19_2
	end
end

local function var_0_1(arg_20_0, arg_20_1)
	return arg_20_0 % arg_20_1 + 1
end

function var_0_0.OnClickRoleTab(arg_21_0, arg_21_1)
	if arg_21_0.curPageIndex_ == arg_21_0.subPageIndex_.Voice and not HeroTools.GetHeroIsUnlock(arg_21_0.roleList_[arg_21_1]) then
		ShowTips("ERROR_HERO_NOT_UNLOCK")

		return
	end

	if arg_21_1 == arg_21_0.roleIndex_ then
		return
	end

	arg_21_0.formState_ = var_0_1(arg_21_0.formState_, arg_21_0:GetFormCnt())

	manager.redPoint:unbindUIandKey(arg_21_0.informationTrs_, string.format("%s_%s", RedPointConst.HERO_REALTION, arg_21_0.curHeroID_))
	manager.redPoint:unbindUIandKey(arg_21_0.giftTrs_, string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, arg_21_0.curHeroID_))

	if arg_21_0.roleTabs_[arg_21_0.roleIndex_] then
		arg_21_0.roleTabs_[arg_21_0.roleIndex_]:SetSelectState(false)
	end

	arg_21_0.roleTabs_[arg_21_1]:SetSelectState(true)

	arg_21_0.roleIndex_ = arg_21_1
	arg_21_0.curHeroID_ = arg_21_0.roleList_[arg_21_1]

	arg_21_0:PrepareHeroFormInfo(arg_21_0.curHeroID_)
	HeroAction.QueryHeroNewData(arg_21_0.curHeroID_)

	if arg_21_0.formState_ then
		arg_21_0.subPages_[arg_21_0.curPageIndex_]:Show(arg_21_0.curRecordID_, arg_21_0.curHeroID_, true, arg_21_0:GetFormID(arg_21_0.curHeroID_))
	else
		arg_21_0.subPages_[arg_21_0.curPageIndex_]:Show(arg_21_0.curRecordID_, arg_21_0.curHeroID_)
	end

	arg_21_0:RefreshFavorabilityIcon()
	arg_21_0:UpdateRoleSwitchTab()
	arg_21_0:UpdateAvatarView()
	ArchiveAction.CheckHeroTrustUpLvRedPoint(arg_21_0.curHeroID_)
	manager.redPoint:bindUIandKey(arg_21_0.informationTrs_, string.format("%s_%s", RedPointConst.HERO_REALTION, arg_21_0.curHeroID_))
	manager.redPoint:bindUIandKey(arg_21_0.giftTrs_, string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, arg_21_0.curHeroID_))
	OperationRecorder.Record("hero", "hero_record_switch")
end

function var_0_0.OnClickSwitchRoleTab(arg_22_0, arg_22_1)
	if arg_22_1 ~= arg_22_0.roleIndex_ then
		return
	end

	local var_22_0 = var_0_1(arg_22_0.formState_, arg_22_0.formCnt_)

	arg_22_0:ChangeFormState(arg_22_1, var_22_0)
end

function var_0_0.ChangeFormState(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.formState_ = arg_23_2

	local var_23_0 = arg_23_0:GetFormID(arg_23_0.curHeroID_)

	if arg_23_0.formState_ then
		arg_23_0:RefreshCV()
		arg_23_0.roleTabs_[arg_23_1]:ShowWithSkinID(var_23_0)
	else
		arg_23_0.roleTabs_[arg_23_1]:Show(arg_23_0.roleList_[arg_23_1])
	end

	arg_23_0:UpdateAvatarView()

	if arg_23_0.curPageIndex_ == arg_23_0.subPageIndex_.Voice then
		if arg_23_0.formState_ then
			arg_23_0.subPages_[arg_23_0.curPageIndex_]:Show(arg_23_0.curRecordID_, arg_23_0.curHeroID_, true, var_23_0)
		else
			arg_23_0.subPages_[arg_23_0.curPageIndex_]:Show(arg_23_0.curRecordID_, arg_23_0.curHeroID_)
		end
	end
end

function var_0_0.UpdateRoleSwitchTab(arg_24_0)
	for iter_24_0 = 1, #arg_24_0.roleList_ do
		local var_24_0 = arg_24_0.roleTabs_[iter_24_0]
		local var_24_1 = iter_24_0 == arg_24_0.roleIndex_
		local var_24_2 = arg_24_0.curPageIndex_ == arg_24_0.subPageIndex_.Voice
		local var_24_3 = arg_24_0:CheckHaveForm(arg_24_0.roleList_[iter_24_0])

		var_24_0:SetCanForm(var_24_2 and var_24_1 and var_24_3)

		if var_24_1 then
			local var_24_4 = arg_24_0:GetFormID(arg_24_0.curHeroID_)

			var_24_0:ShowWithSkinID(var_24_4)
		else
			var_24_0:Show(arg_24_0.roleList_[iter_24_0])
		end
	end
end

function var_0_0.UpdateAvatarView(arg_25_0)
	local var_25_0 = arg_25_0.formState_ or 1

	if arg_25_0.curPageIndex_ ~= arg_25_0.subPageIndex_.Voice then
		var_25_0 = 1
	end

	local var_25_1 = arg_25_0:GetFormID(nil, var_25_0)

	if SkinCfg[var_25_1] and SkinCfg[var_25_1].modelId ~= "" then
		manager.heroRaiseTrack:SetModelState(var_25_1)
	end
end

function var_0_0.ShowFavorabilityTips(arg_26_0)
	if ArchiveData:GetTrustLevel(arg_26_0.curHeroID_) > 0 then
		arg_26_0.tipsLuaUIlist_:StartScroll(HeroConst.HERO_TRUST_LV_MAX)
		SetActive(arg_26_0.FavorabilityTipsGo_, true)
	end
end

function var_0_0.HideFavorabilityTips(arg_27_0)
	SetActive(arg_27_0.FavorabilityTipsGo_, false)
end

function var_0_0.OnHeroTrustUpdate(arg_28_0)
	if arg_28_0.subPages_[arg_28_0.subPageIndex_.Gift] then
		arg_28_0.subPages_[arg_28_0.subPageIndex_.Gift]:OnHeroTrustUpdate()
	end

	arg_28_0:RefreshFavorabilityIcon()
end

function var_0_0.OnSendGift(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0.subPages_[arg_29_0.subPageIndex_.Gift] then
		arg_29_0.subPages_[arg_29_0.subPageIndex_.Gift]:OnSendGift()
	end

	arg_29_0:RefreshFavorabilityIcon()
end

function var_0_0.OnHeroModify(arg_30_0)
	if arg_30_0.subPages_[arg_30_0.subPageIndex_.Gift] then
		arg_30_0.subPages_[arg_30_0.subPageIndex_.Gift]:OnHeroModify()
	end
end

function var_0_0.Dispose(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.subPages_) do
		iter_31_1:Dispose()
	end

	for iter_31_2, iter_31_3 in pairs(arg_31_0.roleTabs_) do
		iter_31_3:Dispose()
	end

	arg_31_0.tipsLuaUIlist_:Dispose()
	var_0_0.super.Dispose(arg_31_0)
end

function var_0_0.CollectHeroForm(arg_32_0, arg_32_1)
	local var_32_0 = HeroTools.HeroUsingSkinInfo(arg_32_1).id
	local var_32_1 = HeroSkinExtraFormCfg.get_id_list_by_original_form[var_32_0]

	if var_32_1 == nil then
		return nil
	end

	local var_32_2 = {}

	for iter_32_0, iter_32_1 in pairs(var_32_1) do
		local var_32_3 = HeroSkinExtraFormCfg[iter_32_1].form_id

		table.insert(var_32_2, var_32_3)
	end

	table.sort(var_32_2)

	return var_32_2, #var_32_2
end

function var_0_0.PrepareHeroFormInfo(arg_33_0, arg_33_1)
	arg_33_0.formList_, arg_33_0.formCnt_ = arg_33_0:CollectHeroForm(arg_33_1)
end

function var_0_0.CheckHaveForm(arg_34_0, arg_34_1)
	return arg_34_0.formList_ ~= nil and next(arg_34_0.formList_) ~= nil
end

function var_0_0.GetFormCnt(arg_35_0, arg_35_1)
	return arg_35_0.formCnt_ or 1
end

function var_0_0.GetFormID(arg_36_0, arg_36_1, arg_36_2)
	arg_36_2 = arg_36_2 or arg_36_0.formState_

	local var_36_0 = HeroTools.HeroUsingSkinInfo(arg_36_0.curHeroID_).id

	return nullable(arg_36_0.formList_, arg_36_2) or var_36_0
end

return var_0_0
