local var_0_0 = class("CustomCenterView", ReduxView)

var_0_0.SELECT_HERO = 1
var_0_0.SELECT_SCENE = 2

function var_0_0.UIName(arg_1_0)
	return "Widget/System/CustomCenter/CustomCenterUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.typeController_ = arg_3_0.controllerEx_:GetController("switch")
	arg_3_0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	arg_3_0.heroUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexHeroItem), arg_3_0.heroUIListGo_, CustomCenterHeroItem)
	arg_3_0.sceneUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexSceneItem), arg_3_0.sceneUIListGo_, CustomCenterSceneItem)
	arg_3_0.filterView_ = NewHeroListFilterView.New(arg_3_0.filterGo_)

	arg_3_0.filterView_:SetListChangeHandler(handler(arg_3_0, arg_3_0.OnListChange))

	arg_3_0.customCenterHeroView_ = CustomCenterHeroView.New(arg_3_0.heroPanel_)
	arg_3_0.customCenterSceneView_ = CustomCenterSceneView.New(arg_3_0.scenePanel_)
	arg_3_0.OnSelectHeroHandler_ = handler(arg_3_0, arg_3_0.OnSelectHero)
	arg_3_0.OnSwitchHeroSkinHandler_ = handler(arg_3_0, arg_3_0.OnSwitchHeroSkin)
	arg_3_0.OnUpdateHeroSkinListHandler_ = handler(arg_3_0, arg_3_0.OnUpdateHeroSkinList)
	arg_3_0.OnSwitchRandomHeroHandler_ = handler(arg_3_0, arg_3_0.OnSwitchRandomHero)
	arg_3_0.OnChangeHeroHandler_ = handler(arg_3_0, arg_3_0.OnChangeHero)
	arg_3_0.OnClearHeroHandler_ = handler(arg_3_0, arg_3_0.OnClearHero)
	arg_3_0.OnSelectSceneHandler_ = handler(arg_3_0, arg_3_0.OnSelectScene)
	arg_3_0.OnUpdateSceneListHandler_ = handler(arg_3_0, arg_3_0.OnUpdateSceneList)
	arg_3_0.OnSwitchRandomSceneHandler_ = handler(arg_3_0, arg_3_0.OnSwitchRandomScene)
	arg_3_0.OnClearSceneHandler_ = handler(arg_3_0, arg_3_0.OnClearScene)
	arg_3_0.OnChangeSceneHandler_ = handler(arg_3_0, arg_3_0.OnChangeScene)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_4_0:ExitFunc(function()
			PlayerData:ClearSelectSkinList()
			HomeSceneSettingData:ClearSelectSceneList()
			arg_4_0:Back()
		end)
	end)
	manager.windowBar:RegistHomeCallBack(function()
		arg_4_0:ExitFunc(function()
			PlayerData:ClearSelectSkinList()
			HomeSceneSettingData:ClearSelectSceneList()
			gameContext:Go("/home", nil, nil, true)
		end)
	end)
	manager.notify:RegistListener(CUSTOM_CENTER_SELECT_HERO, arg_4_0.OnSelectHeroHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_SWITCH_HERO_SKIN, arg_4_0.OnSwitchHeroSkinHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_UPDATE_RANDOM_HERO_SKIN_LIST, arg_4_0.OnUpdateHeroSkinListHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_SWITCH_RANDOM_HERO, arg_4_0.OnSwitchRandomHeroHandler_)
	manager.notify:RegistListener(CHANGE_POSTER_GIRL, arg_4_0.OnChangeHeroHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_CLEAR_HERO, arg_4_0.OnClearHeroHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_SELECT_SCENE, arg_4_0.OnSelectSceneHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_UPDATE_RANDOM_SCENE_LIST, arg_4_0.OnUpdateSceneListHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_SWITCH_RANDOM_SCENE, arg_4_0.OnSwitchRandomSceneHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_CLEAR_SCENE, arg_4_0.OnClearSceneHandler_)
	manager.notify:RegistListener(HOME_SCENE_CHANGE, arg_4_0.OnChangeSceneHandler_)
	CustomCenterTools.SetCacheRandomHeroSkinList(clone(CustomCenterTools.GetRandomHeroList()))
	CustomCenterTools.SetCacheRandomSceneList(clone(HomeSceneSettingData:GetRandomSceneList()))

	if arg_4_0.params_.isBack then
		-- block empty
	else
		arg_4_0.selectType_ = arg_4_0.params_.selectType or var_0_0.SELECT_HERO
		arg_4_0.previewSceneName_ = nil
		arg_4_0.lastSkinID_ = nil
		arg_4_0.skinID_ = CustomCenterAction.GetValidHeroSkin()

		local var_4_0 = SkinCfg[arg_4_0.skinID_].hero

		PlayerData:SetCacheHeroSkinID(var_4_0, arg_4_0.skinID_)

		arg_4_0.selectHeroID_ = SkinCfg[arg_4_0.skinID_].hero
		arg_4_0.homeSkinID_ = arg_4_0.skinID_

		HomeSceneSettingData:SetCacheSceneID(HomeSceneSettingData:GetCurSceneID())

		arg_4_0.selectSceneID_ = arg_4_0.params_.sceneID or manager.loadScene:GetTimeSceneID(CustomCenterTools.GetMatchScene(arg_4_0.skinID_, HomeSceneSettingData:GetCurScene()))
	end

	if arg_4_0.sceneTransitionView_ then
		arg_4_0.sceneTransitionView_:OnEnter()
	end

	if arg_4_0.params_.isBack then
		-- block empty
	else
		arg_4_0:RefreshHeroList()
		arg_4_0:SwitchType()
	end

	arg_4_0.customCenterHeroView_:OnEnter()
	arg_4_0.customCenterSceneView_:OnEnter()
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
	arg_9_0.customCenterHeroView_:OnExit()
	arg_9_0.customCenterSceneView_:OnExit()

	if arg_9_0.sceneTransitionView_ then
		arg_9_0.sceneTransitionView_:OnExit()
	end

	manager.notify:RemoveListener(CUSTOM_CENTER_SELECT_HERO, arg_9_0.OnSelectHeroHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_SWITCH_HERO_SKIN, arg_9_0.OnSwitchHeroSkinHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_UPDATE_RANDOM_HERO_SKIN_LIST, arg_9_0.OnUpdateHeroSkinListHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_SWITCH_RANDOM_HERO, arg_9_0.OnSwitchRandomHeroHandler_)
	manager.notify:RemoveListener(CHANGE_POSTER_GIRL, arg_9_0.OnChangeHeroHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_CLEAR_HERO, arg_9_0.OnClearHeroHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_SELECT_SCENE, arg_9_0.OnSelectSceneHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_UPDATE_RANDOM_SCENE_LIST, arg_9_0.OnUpdateSceneListHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_SWITCH_RANDOM_SCENE, arg_9_0.OnSwitchRandomSceneHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_CLEAR_SCENE, arg_9_0.OnClearSceneHandler_)
	manager.notify:RemoveListener(HOME_SCENE_CHANGE, arg_9_0.OnChangeSceneHandler_)
	PlayerData:ClearCacheHeroSkinID()

	if arg_9_0.filterView_ and arg_9_0.filterView_.OnExit then
		arg_9_0.filterView_:OnExit()
	end

	arg_9_0.firstEnter_ = false
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.OnSelectHeroHandler_ = nil
	arg_10_0.OnSwitchHeroSkinHandler_ = nil
	arg_10_0.OnUpdateHeroSkinListHandler_ = nil
	arg_10_0.OnSwitchRandomHeroHandler_ = nil
	arg_10_0.OnChangeHeroHandler_ = nil
	arg_10_0.OnClearHeroHandler_ = nil
	arg_10_0.OnSelectSceneHandler_ = nil
	arg_10_0.OnUpdateSceneListHandler_ = nil
	arg_10_0.OnSwitchRandomSceneHandler_ = nil
	arg_10_0.OnClearSceneHandler_ = nil
	arg_10_0.OnChangeSceneHandler_ = nil

	arg_10_0.customCenterHeroView_:Dispose()

	arg_10_0.customCenterHeroView_ = nil

	arg_10_0.customCenterSceneView_:Dispose()

	arg_10_0.customCenterSceneView_ = nil

	if arg_10_0.sceneTransitionView_ then
		arg_10_0.sceneTransitionView_:Dispose()

		arg_10_0.sceneTransitionView_ = nil
	end

	arg_10_0.heroUIList_:Dispose()

	arg_10_0.heroUIList_ = nil

	arg_10_0.sceneUIList_:Dispose()

	arg_10_0.sceneUIList_ = nil

	arg_10_0.filterView_:Dispose()

	arg_10_0.filterView_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.AddListeners(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.heroTypeBtn_, nil, function()
		if arg_11_0.selectType_ == var_0_0.SELECT_HERO then
			return
		end

		arg_11_0.selectType_ = var_0_0.SELECT_HERO

		arg_11_0:SwitchType()
	end)
	arg_11_0:AddBtnListener(arg_11_0.sceneTypeBtn_, nil, function()
		if arg_11_0.selectType_ == var_0_0.SELECT_SCENE then
			return
		end

		arg_11_0.selectType_ = var_0_0.SELECT_SCENE

		if CustomCenterTools.HasDLCScene(arg_11_0.skinID_) then
			arg_11_0.selectSceneID_ = CustomCenterTools.GetDLCScene(arg_11_0.skinID_) or arg_11_0.selectSceneID_

			arg_11_0:OnSelectScene(arg_11_0.selectSceneID_)
		end

		arg_11_0:SwitchType()
	end)
end

function var_0_0.SwitchType(arg_14_0)
	if arg_14_0.selectType_ == var_0_0.SELECT_HERO then
		arg_14_0:SwitchHeroType()
		arg_14_0.customCenterHeroView_:Show(true, arg_14_0.selectHeroID_)
		arg_14_0.customCenterSceneView_:Show(false)
	else
		arg_14_0:SwitchSceneType()
		arg_14_0.customCenterHeroView_:Show(false)
		arg_14_0.customCenterSceneView_:Show(true, arg_14_0.selectSceneID_)
	end
end

function var_0_0.SwitchHeroType(arg_15_0)
	arg_15_0.typeController_:SetSelectedState("hero")
	arg_15_0.heroUIList_:StartScroll(#arg_15_0.heroIDList_, table.keyof(arg_15_0.heroIDList_, arg_15_0.selectHeroID_))

	if arg_15_0.firstEnter_ then
		arg_15_0:OnSelectHero(arg_15_0.selectHeroID_)
	end

	arg_15_0.firstEnter_ = true
end

function var_0_0.SwitchSceneType(arg_16_0)
	arg_16_0.typeController_:SetSelectedState("scene")

	arg_16_0.sceneIDList_ = CustomCenterTools.GetSceneList(arg_16_0.skinID_, arg_16_0.selectSceneID_)

	arg_16_0.sceneUIList_:StartScroll(#arg_16_0.sceneIDList_, table.keyof(arg_16_0.sceneIDList_, arg_16_0.selectSceneID_))
end

function var_0_0.OnUpdateHeroSkinList(arg_17_0)
	arg_17_0.heroUIList_:Refresh()
	arg_17_0.customCenterHeroView_:RefreshUI()
end

function var_0_0.RefreshHeroList(arg_18_0)
	local var_18_0 = HeroTools.Sort(HeroData:GetHeroList())

	arg_18_0.filterView_:OnEnter(arg_18_0.heroViewProxy_)
	arg_18_0.filterView_:SetHeroIdList(var_18_0)
end

function var_0_0.OnMainHomeViewTop(arg_19_0)
	if arg_19_0.filterView_ then
		arg_19_0.filterView_:Reset()
	end
end

function var_0_0.OnListChange(arg_20_0, arg_20_1)
	arg_20_0.heroIDList_ = arg_20_1

	if table.keyof(arg_20_0.heroIDList_, arg_20_0.selectHeroID_) == nil then
		arg_20_0.selectHeroID_ = arg_20_0.heroIDList_[1] or arg_20_0.selectHeroID_
	end

	arg_20_0.heroUIList_:StartScroll(#arg_20_0.heroIDList_, table.keyof(arg_20_0.heroIDList_, arg_20_0.selectHeroID_))
	arg_20_0:OnSelectHero(arg_20_0.selectHeroID_)
end

function var_0_0.OnHeroSort(arg_21_0, arg_21_1)
	arg_21_0.filterView_:RefreshSort(arg_21_1)
end

function var_0_0.OnSelectHero(arg_22_0, arg_22_1)
	if arg_22_1 == nil then
		return
	end

	arg_22_0.selectHeroID_ = arg_22_1
	arg_22_0.skinID_ = PlayerData:GetCacheHeroSkinID(arg_22_1)

	arg_22_0.heroUIList_:Refresh()

	local var_22_0 = CustomCenterTools.GetMatchScene(arg_22_0.skinID_, arg_22_0.selectSceneID_)
	local var_22_1 = manager.loadScene:GetTimeSceneID(var_22_0)

	if arg_22_0.lastSkinID_ ~= arg_22_0.skinID_ or arg_22_0.selectSceneID_ ~= var_22_1 then
		arg_22_0.selectSceneID_ = var_22_1

		arg_22_0:UpdateAvatarView(arg_22_0.skinID_)
	else
		arg_22_0.selectSceneID_ = var_22_1
	end

	arg_22_0.customCenterHeroView_:Show(true, arg_22_0.selectHeroID_)
end

function var_0_0.OnSwitchHeroSkin(arg_23_0)
	arg_23_0:OnSelectHero(arg_23_0.selectHeroID_)
end

function var_0_0.OnSwitchRandomHero(arg_24_0)
	arg_24_0.heroUIList_:Refresh()
	arg_24_0.customCenterHeroView_:Show(true, arg_24_0.selectHeroID_)
end

function var_0_0.OnChangeHero(arg_25_0, arg_25_1)
	arg_25_0.heroUIList_:Refresh()
end

function var_0_0.OnSelectScene(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.selectSceneID_

	arg_26_0.selectSceneID_ = arg_26_1

	arg_26_0.sceneUIList_:Refresh()

	if var_26_0 ~= arg_26_1 then
		arg_26_0:UpdateAvatarView(arg_26_0.skinID_)
	end

	arg_26_0.customCenterSceneView_:Show(true, arg_26_0.selectSceneID_)
end

function var_0_0.OnUpdateSceneList(arg_27_0)
	arg_27_0.sceneUIList_:Refresh()
	arg_27_0.customCenterSceneView_:RefreshUI()
end

function var_0_0.OnSwitchRandomScene(arg_28_0)
	arg_28_0.sceneUIList_:Refresh()
	arg_28_0.customCenterSceneView_:Show(true, arg_28_0.selectSceneID_)
end

function var_0_0.UpdateSceneView(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = HomeSceneSettingData:SetPreviewScene(arg_29_1, arg_29_0.skinID_)

	PlayerData:AddSelectSkinID(arg_29_0.skinID_)
	HomeSceneSettingData:AddSelectSceneID(arg_29_1)
	HomeSceneSettingData:SetPreviewSceneParams(var_29_0)

	local var_29_1 = manager.loadScene:GetPreviewHomeShouldLoadSceneName()

	if arg_29_0.previewSceneName_ ~= nil and arg_29_0.previewSceneName_ ~= var_29_1 then
		manager.ui:UIEventEnabled(false)

		if arg_29_0.sceneTransitionView_ == nil then
			arg_29_0.sceneTransitionView_ = CustomCenterSceneTransition.New(arg_29_0.vagueParent_)
		end

		arg_29_0.sceneTransitionView_:SnapShot()
		arg_29_0.sceneTransitionView_:PlayVagueAnimator(function()
			manager.loadScene:ForceSetShouldLoadSceneName("homePreview", function()
				manager.ui:UIEventEnabled(true)
				arg_29_0.sceneTransitionView_:PlayAlphaAnimator()

				arg_29_0.previewSceneName_ = var_29_1

				arg_29_0:SetCamera()
				arg_29_2()
			end)
		end)
	else
		manager.ui:UIEventEnabled(false)
		manager.loadScene:ForceSetShouldLoadSceneName("homePreview", function()
			manager.ui:UIEventEnabled(true)

			arg_29_0.previewSceneName_ = var_29_1

			arg_29_0:SetCamera()
			arg_29_2()
		end)
	end
end

function var_0_0.UpdateAvatarView(arg_33_0, arg_33_1)
	arg_33_0:UpdateSceneView(arg_33_0.selectSceneID_, function()
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.preview, {
			skinID = arg_33_1
		}, true)

		if arg_33_0.lastSkinID_ and arg_33_0.skinID_ ~= arg_33_0.lastSkinID_ then
			arg_33_0:PlayModelChangeEffect(manager.posterGirl:GetModel())
		end

		arg_33_0.lastSkinID_ = arg_33_0.skinID_

		manager.loadScene:SetHomeSceneSoundEffect()
		arg_33_0:PlayBGM()
	end)
end

function var_0_0.PlayModelChangeEffect(arg_35_0, arg_35_1)
	LuaForUtil.PlayEffect(arg_35_1.transform, SectionSelectHeroConst.HERO_CHANGE_FX_PATH, Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)
end

function var_0_0.SetCamera(arg_36_0)
	local var_36_0 = arg_36_0.selectSceneID_
	local var_36_1 = "home_" .. var_36_0

	if CameraCfg[var_36_1] then
		manager.ui:SetMainCamera(var_36_1, nil, false, true)
	else
		manager.ui:SetMainCamera("home", nil, false, true)
	end
end

function var_0_0.PlayBGM(arg_37_0)
	local var_37_0 = HomeSceneSettingCfg[arg_37_0.selectSceneID_]
	local var_37_1 = var_37_0.scene_setting
	local var_37_2 = var_37_0.default_music

	if var_37_2 ~= 0 and table.indexof(var_37_1, HomeSceneSettingConst.SETTING.SCENE_BGM) then
		PlayGameBGMID(var_37_2)
	else
		PlayGameSetBGM()
	end
end

function var_0_0.IndexHeroItem(arg_38_0, arg_38_1, arg_38_2)
	arg_38_2:SetHeroData(arg_38_0.heroIDList_[arg_38_1], arg_38_0.selectHeroID_)
end

function var_0_0.IndexSceneItem(arg_39_0, arg_39_1, arg_39_2)
	arg_39_2:SetSceneData(arg_39_0.sceneIDList_[arg_39_1], arg_39_0.selectSceneID_)
end

function var_0_0.OnClearHero(arg_40_0)
	CustomCenterTools.SetCacheRandomHeroSkinList({})
	PlayerData:SetClearHeroFlag(true)
end

function var_0_0.OnClearScene(arg_41_0)
	CustomCenterTools.SetCacheRandomSceneList({})
	HomeSceneSettingData:SetClearSceneFlag(true)
end

function var_0_0.OnChangeScene(arg_42_0)
	arg_42_0.sceneUIList_:Refresh()
end

function var_0_0.SetSceneThenExit(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local var_43_0

	if arg_43_1 then
		var_43_0 = arg_43_0.selectSceneID_
	elseif not CustomCenterTools.IsRandomScene() then
		if CustomCenterTools.IsDLCScene(arg_43_0.selectSceneID_) and not CustomCenterTools.IsDLCScene(arg_43_2) then
			var_43_0 = arg_43_2
		else
			var_43_0 = arg_43_0.selectSceneID_
		end
	end

	HomeSceneSettingAction.SetHomeSceneWithCallback(var_43_0, true, false, function()
		arg_43_0:ExitOverFunc(arg_43_3)
	end)
end

function var_0_0.ExitFunc(arg_45_0, arg_45_1)
	if not manager.ui:GetIsUIEventEnabled() then
		ShowTips("LOADING")

		return
	end

	local var_45_0 = HomeSceneSettingData:GetCurSceneID()
	local var_45_1 = manager.loadScene:GetTimeSceneID(var_45_0)
	local var_45_2 = not CustomCenterTools.IsRandomHero() and arg_45_0.skinID_ ~= PlayerData:GetPosterGirlHeroSkinId()
	local var_45_3 = not CustomCenterTools.IsRandomScene() and arg_45_0.selectSceneID_ ~= var_45_1 and (SkinSceneActionCfg.get_id_list_by_special_scene_id[arg_45_0.selectSceneID_] and not CustomCenterTools.IsRandomHero() or not SkinSceneActionCfg.get_id_list_by_special_scene_id[arg_45_0.selectSceneID_])

	if var_45_2 or var_45_3 then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("CUSTOM_CENTER_SWITCH_SCENE_WARING"),
			OkCallback = function()
				if var_45_2 then
					local var_46_0 = SkinCfg[arg_45_0.skinID_].hero

					HeroAction.SelectSkinWithCallback(var_46_0, arg_45_0.skinID_, function()
						PlayerAction.ChangePosterGirlWithCallback(var_46_0, function()
							arg_45_0:SetSceneThenExit(var_45_3, var_45_1, arg_45_1)
						end)
					end)
				else
					arg_45_0:SetSceneThenExit(var_45_3, var_45_1, arg_45_1)
				end
			end,
			CancelCallback = function()
				arg_45_0:ExitOverFunc(arg_45_1)
			end,
			MaskCallback = function()
				return
			end
		})

		if not CustomCenterTools.IsRandomScene() then
			HomeSceneSettingAction.SetHomeScene(var_45_1, true)
		end

		HomeSceneSettingData:SetCacheSceneID()

		return
	end

	arg_45_0:ExitOverFunc(arg_45_1)
end

function var_0_0.ExitOverFunc(arg_51_0, arg_51_1)
	local var_51_0 = 0

	HomeSceneSettingData:SetCacheSceneID()
	manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)

	local var_51_1 = CustomCenterTools.IsRandomHero()
	local var_51_2 = PlayerData:GetRandomHeroMode()
	local var_51_3 = CustomCenterTools.IsRandomScene()
	local var_51_4 = HomeSceneSettingData:GetRandomMode()

	PlayerData:SetForceRandomHeroID(nil)

	if var_51_1 then
		local var_51_5 = CustomCenterTools.GetLastPreviewHero()

		PlayerData:SetForceRandomHeroID(var_51_5)

		var_51_0 = var_51_5
	else
		local var_51_6 = PlayerData:GetPlayerInfo()

		var_51_0 = HeroTools.HeroUsingSkinInfo(var_51_6.poster_girl).id
	end

	HomeSceneSettingData:SetForceRandomSceneID(nil)

	if var_51_3 then
		HomeSceneSettingData:SetForceRandomSceneID(CustomCenterTools.GetLastPreviewScene())
	end

	if var_51_0 ~= arg_51_0.homeSkinID_ then
		local var_51_7 = SkinCfg[var_51_0].hero
		local var_51_8 = SkinCfg[arg_51_0.homeSkinID_].hero

		PlayerData:SetPlayAssistantVoice(var_51_7, var_51_8 == var_51_7)
	end

	arg_51_1()
end

return var_0_0
