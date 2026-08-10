local var_0_0 = require("game.tools.CustomCenterTools")
local var_0_1 = class("ScenePreviewView", ReduxView)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Main/SceneChange_new"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

local function var_0_2(arg_4_0, arg_4_1)
	return ComponentBinder.GetInstance():InjectImage(arg_4_0, arg_4_1)
end

local function var_0_3(arg_5_0, arg_5_1)
	return ComponentBinder.GetInstance():InjectText(arg_5_0)
end

local var_0_4 = var_0_0.GetMatchSkinByScene

function var_0_1.BindEffectCom(arg_6_0)
	arg_6_0.effectTgl = {}

	for iter_6_0, iter_6_1 in ipairs(HomeSceneTagCfg.all) do
		local var_6_0 = HomeSceneTagCfg[iter_6_1]
		local var_6_1 = "effectGo_" .. iter_6_1
		local var_6_2 = "effectTgl_" .. iter_6_1
		local var_6_3 = "effectIcon_" .. iter_6_1
		local var_6_4 = "effectName_" .. iter_6_1
		local var_6_5 = {
			obj = arg_6_0[var_6_1] or arg_6_0.effectItemPanel_:Find("item" .. iter_6_1).gameObject
		}

		var_6_5.toggle = arg_6_0[var_6_2] or var_6_5.obj.transform:Find("btn"):GetComponent("Toggle")
		var_6_5.icon = arg_6_0[var_6_3] or var_0_2(var_6_5.obj.transform:Find("icon"):GetComponent("Image"), arg_6_0)
		var_6_5.name = arg_6_0[var_6_4] or var_0_3(var_6_5.obj.transform:Find("text"):GetComponent("Text"), arg_6_0)
		arg_6_0[var_6_1] = var_6_5.obj
		arg_6_0[var_6_2] = var_6_5.toggle
		arg_6_0[var_6_3] = var_6_5.icon
		arg_6_0[var_6_4] = var_6_5.name
		var_6_5.name.text = GetI18NText(var_6_0.tag_desc)
		arg_6_0.effectTgl[iter_6_1] = var_6_5
	end
end

function var_0_1.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()
	arg_7_0:BindEffectCom()

	arg_7_0.bg_.immediate = true
	arg_7_0.btnController_ = arg_7_0.mainControllerEx_:GetController("btn")
	arg_7_0.recommandController_ = arg_7_0.mainControllerEx_:GetController("recommandState")
	arg_7_0.tabController_ = arg_7_0.tabControllerEx_:GetController("tab")
	arg_7_0.setting_ = {
		[HomeSceneSettingConst.SETTING.SOUND_EFFECT] = "sound_effect",
		[HomeSceneSettingConst.SETTING.CAMERA_FOLLOW] = "camera_follow",
		[HomeSceneSettingConst.SETTING.SCENE_BGM] = "scene_bgm"
	}
	arg_7_0.settingBtn_ = {}
	arg_7_0.settingCon_ = {}
	arg_7_0.settingItem_ = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.setting_) do
		arg_7_0.settingBtn_[iter_7_0] = arg_7_0["settingBtn_" .. iter_7_0]
		arg_7_0.settingItem_[iter_7_0] = arg_7_0["settingItem_" .. iter_7_0]

		if arg_7_0.settingItem_[iter_7_0] then
			arg_7_0.settingCon_[iter_7_0] = arg_7_0.settingBtn_[iter_7_0].transform:GetComponent("ControllerExCollection"):GetController("type")
		end
	end

	arg_7_0.sceneScrollHelper_ = LuaList.New(handler(arg_7_0, arg_7_0.SceneIndexItem), arg_7_0.listGo_, ScenePreviewItem)
	arg_7_0.dlcScrollHelper_ = LuaList.New(handler(arg_7_0, arg_7_0.DlcIndexItem), arg_7_0.dlcListGo_, ScenePreviewDlcItem)
end

function var_0_1.SceneIndexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.sceneList_[arg_8_1]

	arg_8_2:RefreshData(var_8_0, arg_8_0.sceneData_[var_8_0], var_8_0 == arg_8_0.curSceneID_)
	arg_8_2:RegistClickFunc(function()
		arg_8_0:ChangeCurScene(1, var_8_0)
	end)
end

function var_0_1.DlcIndexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.dlcList_[arg_10_1]

	arg_10_2:RefreshData(var_10_0, arg_10_0.dlcData_[var_10_0], var_10_0 == arg_10_0.curSceneID_)
	arg_10_2:RegistClickFunc(function()
		arg_10_0:ChangeCurScene(2, var_10_0)
	end)
end

function var_0_1.ChangeCurScene(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.curPage_ = arg_12_1
	arg_12_0.curSceneID_ = arg_12_2

	arg_12_0:RefreshRight()

	if arg_12_1 == 1 then
		arg_12_0.sceneScrollHelper_:Refresh()
	else
		arg_12_0.dlcScrollHelper_:Refresh()
	end
end

function var_0_1.SelectPage(arg_13_0, arg_13_1)
	local var_13_0 = HomeSceneSettingData:GetCurScene()
	local var_13_1 = HomeSceneSettingCfg[var_13_0]

	if arg_13_1 == 1 then
		if var_13_1 and var_13_1.limit_display == 1 then
			arg_13_0:ChangeCurScene(arg_13_1, var_13_0)
		else
			arg_13_0:ChangeCurScene(arg_13_1, arg_13_0.sceneList_[1])
		end
	else
		local var_13_2 = PlayerData:GetPosterGirlHeroSkinId()
		local var_13_3
		local var_13_4

		if var_13_2 then
			local var_13_5 = var_0_0.GetDLCScene(var_13_2)

			var_13_3 = nullable(var_13_5, "special_scene_id")
		end

		if var_13_3 then
			for iter_13_0, iter_13_1 in ipairs(arg_13_0.dlcList_) do
				if iter_13_1 == var_13_3 then
					var_13_4 = iter_13_0

					break
				end
			end
		end

		if var_13_1 and var_13_1.limit_display == 0 then
			arg_13_0:ChangeCurScene(arg_13_1, var_13_0)
		elseif var_13_3 and var_13_4 then
			arg_13_0:ChangeCurScene(arg_13_1, var_13_3)
		else
			arg_13_0:ChangeCurScene(arg_13_1, arg_13_0.dlcList_[1])
		end
	end
end

function var_0_1.AddUIListeners(arg_14_0)
	arg_14_0:AddBtnListener(arg_14_0.recommandBtn_, nil, function()
		local var_15_0 = arg_14_0.recommandController_:GetSelectedIndex()

		if var_15_0 == 2 then
			return
		end

		if var_15_0 == 1 then
			arg_14_0.recommandController_:SetSelectedIndex(0)
		else
			arg_14_0.recommandController_:SetSelectedIndex(1)
		end
	end)
	arg_14_0:AddBtnListener(arg_14_0.sceneBtn_, nil, function()
		if arg_14_0.curPage_ == 1 then
			return
		end

		arg_14_0.curPage_ = 1

		arg_14_0:SelectPage(1)
		arg_14_0:RefreshUI()
	end)
	arg_14_0:AddBtnListener(arg_14_0.dlcBtn_, nil, function()
		if arg_14_0.curPage_ == 2 then
			return
		end

		if arg_14_0.dlcList_ and #arg_14_0.dlcList_ > 0 then
			arg_14_0.curPage_ = 2

			arg_14_0:SelectPage(2)
			arg_14_0:RefreshUI()
		else
			ShowTips(GetTips("HOME_SCENE_COUNT_INVALID"))
		end
	end)
	arg_14_0:AddBtnListener(arg_14_0.useBtn_, nil, function()
		if arg_14_0.curPage_ == 1 then
			arg_14_0:UseScene(arg_14_0.curSceneID_)
		else
			local var_18_0 = var_0_4(arg_14_0.curSceneID_)
			local var_18_1 = SkinCfg[var_18_0].hero

			if var_18_1 and HeroTools.GetHeroIsUnlock(var_18_1) and var_18_0 and HeroTools.GetHasOwnedSkin(var_18_0) then
				if PlayerData:IsRandomHero() then
					ShowMessageBox({
						title = GetTips("PROMPT"),
						content = GetTips("RANDOM_ASSIST_TIPS"),
						OkCallback = function()
							PlayerAction.SetIsRandomHero(false, function()
								return
							end)
							HeroAction.SelectSkin(var_18_1, var_18_0)
							PlayerAction.ChangePosterGirl(var_18_1)
						end
					})
				else
					HeroAction.SelectSkin(var_18_1, var_18_0)
					PlayerAction.ChangePosterGirl(var_18_1)
				end
			end
		end
	end)
	arg_14_0:AddBtnListener(arg_14_0.trialBtn_, nil, function()
		if arg_14_0.curPage_ == 1 then
			arg_14_0:UseScene(arg_14_0.curSceneID_)
		else
			local var_21_0 = var_0_4(arg_14_0.curSceneID_)
			local var_21_1 = SkinCfg[var_21_0].hero

			if var_21_1 and HeroTools.GetHeroIsUnlock(var_21_1) and var_21_0 and (HeroTools.GetHasOwnedSkin(var_21_0) or HeroTools.GetIsLimitTimeSkin(var_21_0)) then
				if PlayerData:IsRandomHero() then
					ShowMessageBox({
						title = GetTips("PROMPT"),
						content = GetTips("RANDOM_ASSIST_TIPS"),
						OkCallback = function()
							PlayerAction.SetIsRandomHero(false, function()
								return
							end)
							HeroAction.SelectSkin(var_21_1, var_21_0)
							PlayerAction.ChangePosterGirl(var_21_1)
						end
					})
				else
					HeroAction.SelectSkin(var_21_1, var_21_0)
					PlayerAction.ChangePosterGirl(var_21_1)
				end
			end
		end
	end)
	arg_14_0:AddBtnListener(arg_14_0.getBtn_, nil, function()
		if arg_14_0:IsCanGet() then
			JumpTools.JumpToPage2(arg_14_0.cfg_.obtain_way)
		else
			ShowTips("HOME_NO_GET_WAY")
		end
	end)
	arg_14_0:AddBtnListener(arg_14_0.noGetBtn_, nil, function()
		if arg_14_0.curPage_ == 1 then
			if not arg_14_0:IsCanGet() then
				ShowTips("HOME_NO_GET_WAY")
			end
		else
			local var_25_0 = var_0_4(arg_14_0.curSceneID_)
			local var_25_1 = SkinCfg[var_25_0].hero

			if not var_25_1 or not HeroTools.GetHeroIsUnlock(var_25_1) then
				ShowTips(GetTipsF("HOME_SCENE_UNAVAILABLE", HeroTools.GetHeroFullName(var_25_1)))
			elseif not var_25_0 or not HeroTools.GetHasOwnedSkin(var_25_0) then
				ShowTips(GetTipsF("HOME_SCENE_UNAVAILABLE", SkinCfg[var_25_0].name))
			end
		end
	end)
	arg_14_0:AddBtnListener(arg_14_0.previewBtn_, nil, function()
		arg_14_0.params_.sceneID = arg_14_0.curSceneID_

		local var_26_0 = HomeSceneSettingData:SetPreviewScene(arg_14_0.curSceneID_)

		HomeSceneSettingData:SetPreviewSceneParams(var_26_0)
		OpenPageUntilLoaded("/homePreview", var_26_0)
	end)
	arg_14_0:AddBtnListener(arg_14_0.randomSceneBtn_, nil, function()
		JumpTools.GoToSystem("/randomScene", {})
	end)

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.setting_) do
		if arg_14_0.settingBtn_[iter_14_0] then
			arg_14_0:AddBtnListener(arg_14_0.settingBtn_[iter_14_0], nil, function()
				local var_28_0 = "home_scene_" .. iter_14_1
				local var_28_1 = 1 - arg_14_0.settingData_[var_28_0]

				SettingAction.ChangeHomeSceneSetting(var_28_0, var_28_1)

				if iter_14_0 == HomeSceneSettingConst.SETTING.SCENE_BGM then
					arg_14_0:CheckPlayBgm()
				end
			end)
		end
	end

	for iter_14_2, iter_14_3 in ipairs(HomeSceneTagCfg.all) do
		local var_14_0 = arg_14_0.effectTgl[iter_14_3].toggle

		arg_14_0:AddToggleListener(var_14_0, function(arg_29_0)
			if arg_29_0 then
				arg_14_0:AddClickTimer()

				local var_29_0 = HomeSceneTagCfg[iter_14_3]

				arg_14_0.tglTitle_.text = var_29_0.tag_desc
				arg_14_0.tglDesc_.text = var_29_0.tag_detail

				SetActive(arg_14_0.tglPanelGo_, true)
			end
		end)
	end
end

function var_0_1.OnEnter(arg_30_0)
	arg_30_0:BindRedpoint()

	if arg_30_0.params_._BackFromRandomScene then
		arg_30_0.params_._BackFromRandomScene = nil

		return
	end

	HomeSceneSettingData:DealOverdueScene()

	if arg_30_0.params_.sceneID then
		arg_30_0.curSceneID_ = arg_30_0.params_.sceneID
	else
		arg_30_0.curSceneID_ = HomeSceneSettingData:GetCurScene()
	end

	local var_30_0 = HomeSceneSettingData:GetCurScene()
	local var_30_1 = HomeSceneSettingCfg[var_30_0]

	if not var_30_0 or HomeSceneSettingData:GetUsedState(var_30_0) == SceneConst.HOME_SCENE_TYPE.LOCK then
		local var_30_2 = GameSetting.home_sence_default.value[1]
		local var_30_3 = HomeSceneSettingCfg[var_30_2]

		HomeSceneSettingAction.SetHomeScene(var_30_2)

		arg_30_0.curSceneID_ = var_30_2
	end

	arg_30_0.curPage_ = 1

	local var_30_4 = HomeSceneSettingCfg[arg_30_0.curSceneID_]

	if var_30_4 and var_30_4.limit_display == 0 then
		arg_30_0.curPage_ = 2
	end

	arg_30_0:RefreshUI()
end

function var_0_1.RefreshUI(arg_31_0)
	arg_31_0:RefreshList()
	arg_31_0:RefreshRight()
end

function var_0_1.RefreshList(arg_32_0)
	arg_32_0.sceneData_ = {}
	arg_32_0.sceneList_ = {}

	for iter_32_0, iter_32_1 in ipairs(HomeSceneSettingCfg.all) do
		if HomeSceneSettingCfg[iter_32_1].limit_display == 1 then
			table.insert(arg_32_0.sceneList_, iter_32_1)

			local var_32_0 = HomeSceneSettingData:GetUsedState(iter_32_1)

			arg_32_0.sceneData_[iter_32_1] = var_32_0
		end
	end

	table.sort(arg_32_0.sceneList_, function(arg_33_0, arg_33_1)
		if arg_32_0.sceneData_[arg_33_0] ~= arg_32_0.sceneData_[arg_33_1] then
			return arg_32_0.sceneData_[arg_33_0] > arg_32_0.sceneData_[arg_33_1]
		end

		return arg_33_0 < arg_33_1
	end)
	arg_32_0.sceneScrollHelper_:StartScroll(#arg_32_0.sceneList_, table.indexof(arg_32_0.sceneList_, arg_32_0.curSceneID_))

	arg_32_0.dlcData_ = {}
	arg_32_0.dlcList_ = {}

	for iter_32_2, iter_32_3 in pairs(SkinSceneActionCfg.get_id_list_by_special_scene_id) do
		if HomeSceneSettingCfg[iter_32_2].limit_display == 0 and (ShopTools.CheckDlcPurchasedByItemID(iter_32_2) or ShopTools.CheckDlcTrialByItemID(iter_32_2)) then
			local var_32_1 = SkinSceneActionCfg[iter_32_3].skin_id

			table.insert(arg_32_0.dlcList_, iter_32_2)

			local var_32_2 = 0
			local var_32_3 = SkinCfg[var_32_1].hero

			if var_32_3 and HeroTools.GetHeroIsUnlock(var_32_3) and var_32_1 and HeroTools.GetHasOwnedSkin(var_32_1) then
				var_32_2 = 2
			end

			if var_32_3 and HeroTools.GetHeroIsUnlock(var_32_3) and ShopTools.CheckDlcTrialByItemID(iter_32_2) then
				var_32_2 = 1
			end

			arg_32_0.dlcData_[iter_32_2] = var_32_2
		end
	end

	CommonTools.UniversalSortEx(arg_32_0.dlcList_, {
		map = function(arg_34_0)
			local var_34_0 = var_0_4(arg_34_0)
			local var_34_1 = SkinCfg[var_34_0].hero

			if var_34_1 and HeroTools.GetHeroIsUnlock(var_34_1) and var_34_0 and (HeroTools.GetHasOwnedSkin(var_34_0) or HeroTools.GetIsLimitTimeSkin(var_34_0)) then
				return 1
			end

			return 0
		end
	}, {
		map = function(arg_35_0)
			return arg_35_0
		end
	})
	arg_32_0.dlcScrollHelper_:StartScroll(#arg_32_0.dlcList_, table.indexof(arg_32_0.dlcList_, arg_32_0.curSceneID_))
end

function var_0_1.RefreshRight(arg_36_0)
	arg_36_0.tabController_:SetSelectedIndex(arg_36_0.curPage_ - 1)

	arg_36_0.cfg_ = HomeSceneSettingCfg[arg_36_0.curSceneID_]
	arg_36_0.title_.text = arg_36_0.cfg_.title
	arg_36_0.desc_.text = arg_36_0.cfg_.desc

	if arg_36_0.curPage_ == 1 then
		arg_36_0.bg_.spriteSync = "TextureConfig/SceneChangeUI/bg/" .. arg_36_0.curSceneID_

		SetActive(arg_36_0.randomSceneBtn_.transform, true)
	else
		local var_36_0 = var_0_4(arg_36_0.curSceneID_)

		arg_36_0.bg_.spriteSync = "TextureConfig/Character/PortraitDLC/" .. var_36_0

		SetActive(arg_36_0.randomSceneBtn_.transform, false)
	end

	arg_36_0:ResetTgl()
	arg_36_0:RefreshSetting()
	arg_36_0:RefreshType()
	arg_36_0:RefreshRedPoint()
end

function var_0_1.ResetTgl(arg_37_0)
	arg_37_0:HideMessage()

	local var_37_0 = arg_37_0.cfg_.scene_tag

	for iter_37_0, iter_37_1 in ipairs(HomeSceneTagCfg.all) do
		local var_37_1 = arg_37_0.effectTgl[iter_37_1]

		if not isNil(var_37_1.obj) then
			if table.indexof(var_37_0, iter_37_1) then
				SetActive(var_37_1.obj, true)
			else
				SetActive(var_37_1.obj, false)
			end

			var_37_1.toggle.isOn = false
		end
	end

	if arg_37_0.cfg_.scene_tag == "" or #arg_37_0.cfg_.scene_tag == 0 then
		arg_37_0.recommandController_:SetSelectedIndex(2)
	else
		arg_37_0.recommandController_:SetSelectedIndex(1)
	end
end

function var_0_1.HideMessage(arg_38_0)
	SetActive(arg_38_0.tglPanelGo_, false)
end

function var_0_1.RefreshSetting(arg_39_0)
	local var_39_0 = arg_39_0.cfg_.scene_setting

	for iter_39_0, iter_39_1 in ipairs(arg_39_0.setting_) do
		if table.indexof(var_39_0, iter_39_0) then
			SetActive(arg_39_0.settingItem_[iter_39_0], true)
		else
			SetActive(arg_39_0.settingItem_[iter_39_0], false)
		end
	end

	arg_39_0.settingData_ = SettingData:GetHomeSceneSettingData()

	arg_39_0:RefreshSoundEffect()
	arg_39_0:RefreshSceneBgm()
end

function var_0_1.RefreshSoundEffect(arg_40_0)
	local var_40_0 = arg_40_0.settingData_.home_scene_sound_effect == 1

	arg_40_0.settingCon_[1]:SetSelectedState(var_40_0 and "on" or "off")
end

function var_0_1.RefreshSceneBgm(arg_41_0)
	local var_41_0 = arg_41_0.settingData_.home_scene_scene_bgm == 1

	arg_41_0.settingCon_[HomeSceneSettingConst.SETTING.SCENE_BGM]:SetSelectedState(var_41_0 and "on" or "off")
end

function var_0_1.RefreshType(arg_42_0)
	arg_42_0:StopTimer()

	if arg_42_0.curPage_ == 1 then
		local var_42_0 = arg_42_0.sceneData_[arg_42_0.curSceneID_]
		local var_42_1 = HomeSceneSettingData:GetCurScene()

		if var_42_0 == 0 then
			local var_42_2 = arg_42_0:IsCanGet()

			arg_42_0.btnController_:SetSelectedState(var_42_2 and "get" or "ban")

			arg_42_0.tip_.text = arg_42_0.cfg_.unlock_description
			arg_42_0.banText_.text = arg_42_0.cfg_.unlock_description
		elseif var_42_0 == 1 then
			arg_42_0.btnController_:SetSelectedState(arg_42_0.curSceneID_ == var_42_1 and "trialing" or "trial")
			arg_42_0:RefreshTime()
		elseif var_42_0 == 2 then
			arg_42_0.btnController_:SetSelectedState(arg_42_0.curSceneID_ == var_42_1 and "using" or "use")
		end
	else
		local var_42_3 = arg_42_0.dlcData_[arg_42_0.curSceneID_]
		local var_42_4 = HomeSceneSettingData:GetCurScene()

		if var_42_3 == 0 then
			arg_42_0.btnController_:SetSelectedState("ban")

			local var_42_5 = var_0_4(arg_42_0.curSceneID_)
			local var_42_6 = SkinCfg[var_42_5].hero

			if not var_42_6 or not HeroTools.GetHeroIsUnlock(var_42_6) then
				arg_42_0.banText_.text = GetTipsF("HOME_SCENE_UNAVAILABLE", HeroTools.GetHeroFullName(var_42_6))
			elseif not var_42_5 or not HeroTools.GetHasOwnedSkin(var_42_5) then
				arg_42_0.banText_.text = GetTipsF("HOME_SCENE_UNAVAILABLE", SkinCfg[var_42_5].name)
			end
		elseif var_42_3 == 1 then
			arg_42_0.btnController_:SetSelectedState(arg_42_0.curSceneID_ == var_42_4 and "trialing" or "trial")
			arg_42_0:RefreshTime()
		elseif var_42_3 == 2 then
			arg_42_0.btnController_:SetSelectedState(arg_42_0.curSceneID_ == var_42_4 and "using" or "use")
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_0.tglContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_0.tglContent_)
end

function var_0_1.IsCanGet(arg_43_0)
	local var_43_0 = arg_43_0.cfg_.obtain_way

	return arg_43_0.cfg_.obtain_way and #arg_43_0.cfg_.obtain_way > 0 and not JumpTools.NeedHide(var_43_0, arg_43_0.curSceneID_) and not JumpTools.GetLinkIsLocked(arg_43_0.cfg_.obtain_way)
end

function var_0_1.RefreshTime(arg_44_0)
	arg_44_0:StopTimer()

	local var_44_0 = manager.time:GetServerTime()
	local var_44_1 = HomeSceneSettingData:GetSceneTimeStamp(arg_44_0.curSceneID_)

	arg_44_0.time_.text = string.format(GetTips("TIME_DISPLAY_12"), TimeMgr.GetInstance():STimeDescS(var_44_1, "!%Y/%m/%d %H:%M"))
	arg_44_0.timer_ = Timer.New(function()
		if var_44_1 and var_44_0 <= var_44_1 then
			arg_44_0.time_.text = string.format(GetTips("TIME_DISPLAY_12"), TimeMgr.GetInstance():STimeDescS(var_44_1, "!%Y/%m/%d %H:%M"))
		else
			HomeSceneSettingAction.SetHomeScene(GameSetting.home_sence_default.value[1])

			arg_44_0.curSceneID_ = HomeSceneSettingData:GetCurScene()

			local var_45_0 = HomeSceneSettingCfg[arg_44_0.curSceneID_]

			if var_45_0 and var_45_0.limit_display == 0 then
				arg_44_0.curPage_ = 2
			else
				arg_44_0.curPage_ = 1
			end

			arg_44_0:RefreshUI()
		end
	end, 1, -1)

	arg_44_0.timer_:Start()
end

function var_0_1.RefreshRedPoint(arg_46_0)
	local var_46_0 = arg_46_0.curSceneID_

	saveData("scene", tostring(var_46_0), 0)
	manager.redPoint:setTip(RedPointConst.SCENE .. "_" .. var_46_0, 0)
end

function var_0_1.StopTimer(arg_47_0)
	if arg_47_0.timer_ then
		arg_47_0.timer_:Stop()

		arg_47_0.timer_ = nil
	end
end

function var_0_1.AddClickTimer(arg_48_0)
	arg_48_0:StopClickTimer()

	arg_48_0.buttonUp_ = 0
	arg_48_0.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		if Input.GetMouseButtonUp(0) then
			arg_48_0.buttonUp_ = arg_48_0.buttonUp_ + 1

			if arg_48_0.buttonUp_ >= 2 then
				for iter_49_0, iter_49_1 in ipairs(HomeSceneTagCfg.all) do
					local var_49_0 = arg_48_0.effectTgl[iter_49_1].toggle

					if var_49_0 then
						var_49_0.isOn = false
					end
				end

				arg_48_0:HideMessage()

				if arg_48_0.clickTimer_ then
					FuncTimerManager.inst:RemoveFuncTimer(arg_48_0.clickTimer_)

					arg_48_0.clickTimer_ = nil
				end
			end
		end
	end, -1, true)
end

function var_0_1.StopClickTimer(arg_50_0)
	if arg_50_0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(arg_50_0.clickTimer_)

		arg_50_0.clickTimer_ = nil
	end
end

function var_0_1.CheckPlayBgm(arg_51_0)
	local var_51_0 = HomeSceneSettingData:GetCurScene()
	local var_51_1 = HomeSceneSettingCfg[var_51_0]
	local var_51_2 = var_51_1.scene_setting
	local var_51_3 = var_51_1.default_music

	if var_51_3 ~= 0 and arg_51_0.settingData_.home_scene_scene_bgm == 1 and table.indexof(var_51_2, HomeSceneSettingConst.SETTING.SCENE_BGM) then
		IllustratedAction.QuerySetBgm(var_51_3)
	end
end

function var_0_1.OnHomeSceneChange(arg_52_0)
	arg_52_0:RefreshUI()
end

function var_0_1.OnChangePosterGirl(arg_53_0)
	arg_53_0:RefreshUI()
end

function var_0_1.OnHomeSceneSettingChange(arg_54_0, arg_54_1, arg_54_2)
	if arg_54_2.key == "allData" then
		arg_54_0:RefreshSoundEffect()
	elseif arg_54_2.key == "home_scene_sound_effect" then
		arg_54_0:RefreshSoundEffect()
	elseif arg_54_2.key == "home_scene_camera_follow" then
		-- block empty
	elseif arg_54_2.key == "home_scene_scene_bgm" then
		arg_54_0:RefreshSceneBgm()
	end
end

function var_0_1.OnTop(arg_55_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_1.OnExit(arg_56_0)
	arg_56_0:CheckPlayBgm()
	arg_56_0:UnbindRedpoint()
	arg_56_0:StopTimer()

	for iter_56_0, iter_56_1 in ipairs(arg_56_0.sceneScrollHelper_:GetItemList()) do
		iter_56_1:OnExit()
	end

	for iter_56_2, iter_56_3 in ipairs(arg_56_0.dlcScrollHelper_:GetItemList()) do
		iter_56_3:OnExit()
	end

	manager.windowBar:HideBar()
end

function var_0_1.UseScene(arg_57_0, arg_57_1)
	if HomeSceneSettingData:IsRandomScene() then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("RANDOM_SCENE_TIPS"),
			OkCallback = function()
				HomeSceneSettingAction.SetIsRandomScene(false, function()
					return
				end)
				HomeSceneSettingAction.SetHomeScene(arg_57_1)
			end
		})
	else
		local var_57_0 = HomeSceneSettingCfg[arg_57_1]

		if var_57_0 and var_57_0.limit_display == 1 and PlayerData:IsRandomHero() and PlayerData:IsRandomHeroUseDlcScene() then
			HomeSceneSettingData:SetIsUseDlcScene(false)
		end

		if HomeSceneSettingData:GetCurScene() == arg_57_1 then
			arg_57_0:RefreshUI()
		end

		HomeSceneSettingAction.SetHomeScene(arg_57_1)
	end

	if PosterGirlTools.SceneHasTimeEffect(arg_57_1) then
		HomeSceneSettingData:SetIsTimeScene(false)
	end
end

function var_0_1.BindRedpoint(arg_60_0)
	manager.redPoint:bindUIandKey(arg_60_0.sceneBtn_.transform, RedPointConst.SCENE_NORMAL)
	manager.redPoint:bindUIandKey(arg_60_0.dlcBtn_.transform, RedPointConst.SCENE_DLC)
end

function var_0_1.UnbindRedpoint(arg_61_0)
	manager.redPoint:unbindUIandKey(arg_61_0.sceneBtn_.transform)
	manager.redPoint:unbindUIandKey(arg_61_0.dlcBtn_.transform)
end

function var_0_1.Dispose(arg_62_0)
	arg_62_0:RemoveAllListeners()

	if arg_62_0.sceneScrollHelper_ then
		arg_62_0.sceneScrollHelper_:Dispose()

		arg_62_0.sceneScrollHelper_ = nil
	end

	if arg_62_0.dlcScrollHelper_ then
		arg_62_0.dlcScrollHelper_:Dispose()

		arg_62_0.dlcScrollHelper_ = nil
	end

	var_0_1.super.Dispose(arg_62_0)
end

return var_0_1
