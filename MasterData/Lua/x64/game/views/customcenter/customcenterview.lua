local CustomCenterView = class("CustomCenterView", ReduxView)

CustomCenterView.SELECT_HERO = 1
CustomCenterView.SELECT_SCENE = 2

function CustomCenterView:UIName()
	return "Widget/System/CustomCenter/CustomCenterUI"
end

function CustomCenterView:UIParent()
	return manager.ui.uiMain.transform
end

function CustomCenterView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.typeController_ = self.controllerEx_:GetController("switch")
	self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	self.heroUIList_ = LuaList.New(handler(self, self.IndexHeroItem), self.heroUIListGo_, CustomCenterHeroItem)
	self.sceneUIList_ = LuaList.New(handler(self, self.IndexSceneItem), self.sceneUIListGo_, CustomCenterSceneItem)
	self.filterView_ = NewHeroListFilterView.New(self.filterGo_)

	self.filterView_:SetListChangeHandler(handler(self, self.OnListChange))

	self.customCenterHeroView_ = CustomCenterHeroView.New(self.heroPanel_)
	self.customCenterSceneView_ = CustomCenterSceneView.New(self.scenePanel_)
	self.OnSelectHeroHandler_ = handler(self, self.OnSelectHero)
	self.OnSwitchHeroSkinHandler_ = handler(self, self.OnSwitchHeroSkin)
	self.OnUpdateHeroSkinListHandler_ = handler(self, self.OnUpdateHeroSkinList)
	self.OnSwitchRandomHeroHandler_ = handler(self, self.OnSwitchRandomHero)
	self.OnChangeHeroHandler_ = handler(self, self.OnChangeHero)
	self.OnClearHeroHandler_ = handler(self, self.OnClearHero)
	self.OnSelectSceneHandler_ = handler(self, self.OnSelectScene)
	self.OnUpdateSceneListHandler_ = handler(self, self.OnUpdateSceneList)
	self.OnSwitchRandomSceneHandler_ = handler(self, self.OnSwitchRandomScene)
	self.OnClearSceneHandler_ = handler(self, self.OnClearScene)
	self.OnChangeSceneHandler_ = handler(self, self.OnChangeScene)
end

function CustomCenterView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:ExitFunc(function()
			PlayerData:ClearSelectSkinList()
			HomeSceneSettingData:ClearSelectSceneList()
			self:Back()
		end)
	end)
	manager.windowBar:RegistHomeCallBack(function()
		self:ExitFunc(function()
			PlayerData:ClearSelectSkinList()
			HomeSceneSettingData:ClearSelectSceneList()
			gameContext:Go("/home", nil, nil, true)
		end)
	end)
	manager.notify:RegistListener(CUSTOM_CENTER_SELECT_HERO, self.OnSelectHeroHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_SWITCH_HERO_SKIN, self.OnSwitchHeroSkinHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_UPDATE_RANDOM_HERO_SKIN_LIST, self.OnUpdateHeroSkinListHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_SWITCH_RANDOM_HERO, self.OnSwitchRandomHeroHandler_)
	manager.notify:RegistListener(CHANGE_POSTER_GIRL, self.OnChangeHeroHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_CLEAR_HERO, self.OnClearHeroHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_SELECT_SCENE, self.OnSelectSceneHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_UPDATE_RANDOM_SCENE_LIST, self.OnUpdateSceneListHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_SWITCH_RANDOM_SCENE, self.OnSwitchRandomSceneHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_CLEAR_SCENE, self.OnClearSceneHandler_)
	manager.notify:RegistListener(HOME_SCENE_CHANGE, self.OnChangeSceneHandler_)
	CustomCenterTools.SetCacheRandomHeroSkinList(clone(CustomCenterTools.GetRandomHeroList()))
	CustomCenterTools.SetCacheRandomSceneList(clone(HomeSceneSettingData:GetRandomSceneList()))

	if self.params_.isBack then
		-- block empty
	else
		self.selectType_ = self.params_.selectType or CustomCenterView.SELECT_HERO
		self.previewSceneName_ = nil
		self.lastSkinID_ = nil
		self.skinID_ = CustomCenterAction.GetValidHeroSkin()

		PlayerData:SetCacheHeroSkinID(SkinCfg[self.skinID_].hero, self.skinID_)

		self.selectHeroID_ = SkinCfg[self.skinID_].hero
		self.homeSkinID_ = self.skinID_

		HomeSceneSettingData:SetCacheSceneID(HomeSceneSettingData:GetCurSceneID())

		self.selectSceneID_ = self.params_.sceneID or manager.loadScene:GetTimeSceneID(CustomCenterTools.GetMatchScene(self.skinID_, HomeSceneSettingData:GetCurScene()))
	end

	if self.sceneTransitionView_ then
		self.sceneTransitionView_:OnEnter()
	end

	if self.params_.isBack then
		-- block empty
	else
		self:RefreshHeroList()
		self:SwitchType()
	end

	self.customCenterHeroView_:OnEnter()
	self.customCenterSceneView_:OnEnter()
end

function CustomCenterView:OnExit()
	manager.windowBar:HideBar()
	self.customCenterHeroView_:OnExit()
	self.customCenterSceneView_:OnExit()

	if self.sceneTransitionView_ then
		self.sceneTransitionView_:OnExit()
	end

	manager.notify:RemoveListener(CUSTOM_CENTER_SELECT_HERO, self.OnSelectHeroHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_SWITCH_HERO_SKIN, self.OnSwitchHeroSkinHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_UPDATE_RANDOM_HERO_SKIN_LIST, self.OnUpdateHeroSkinListHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_SWITCH_RANDOM_HERO, self.OnSwitchRandomHeroHandler_)
	manager.notify:RemoveListener(CHANGE_POSTER_GIRL, self.OnChangeHeroHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_CLEAR_HERO, self.OnClearHeroHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_SELECT_SCENE, self.OnSelectSceneHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_UPDATE_RANDOM_SCENE_LIST, self.OnUpdateSceneListHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_SWITCH_RANDOM_SCENE, self.OnSwitchRandomSceneHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_CLEAR_SCENE, self.OnClearSceneHandler_)
	manager.notify:RemoveListener(HOME_SCENE_CHANGE, self.OnChangeSceneHandler_)
	PlayerData:ClearCacheHeroSkinID()

	if self.filterView_ and self.filterView_.OnExit then
		self.filterView_:OnExit()
	end

	self.firstEnter_ = false
end

function CustomCenterView:Dispose()
	self.OnSelectHeroHandler_ = nil
	self.OnSwitchHeroSkinHandler_ = nil
	self.OnUpdateHeroSkinListHandler_ = nil
	self.OnSwitchRandomHeroHandler_ = nil
	self.OnChangeHeroHandler_ = nil
	self.OnClearHeroHandler_ = nil
	self.OnSelectSceneHandler_ = nil
	self.OnUpdateSceneListHandler_ = nil
	self.OnSwitchRandomSceneHandler_ = nil
	self.OnClearSceneHandler_ = nil
	self.OnChangeSceneHandler_ = nil

	self.customCenterHeroView_:Dispose()

	self.customCenterHeroView_ = nil

	self.customCenterSceneView_:Dispose()

	self.customCenterSceneView_ = nil

	if self.sceneTransitionView_ then
		self.sceneTransitionView_:Dispose()

		self.sceneTransitionView_ = nil
	end

	self.heroUIList_:Dispose()

	self.heroUIList_ = nil

	self.sceneUIList_:Dispose()

	self.sceneUIList_ = nil

	self.filterView_:Dispose()

	self.filterView_ = nil

	CustomCenterView.super.Dispose(self)
end

function CustomCenterView:AddListeners()
	self:AddBtnListener(self.heroTypeBtn_, nil, function()
		if self.selectType_ == CustomCenterView.SELECT_HERO then
			return
		end

		self.selectType_ = CustomCenterView.SELECT_HERO

		self:SwitchType()
	end)
	self:AddBtnListener(self.sceneTypeBtn_, nil, function()
		if self.selectType_ == CustomCenterView.SELECT_SCENE then
			return
		end

		self.selectType_ = CustomCenterView.SELECT_SCENE

		if CustomCenterTools.HasDLCScene(self.skinID_) then
			self.selectSceneID_ = CustomCenterTools.GetDLCScene(self.skinID_) or self.selectSceneID_

			self:OnSelectScene(self.selectSceneID_)
		end

		self:SwitchType()
	end)
end

function CustomCenterView:SwitchType()
	if self.selectType_ == CustomCenterView.SELECT_HERO then
		self:SwitchHeroType()
		self.customCenterHeroView_:Show(true, self.selectHeroID_)
		self.customCenterSceneView_:Show(false)
	else
		self:SwitchSceneType()
		self.customCenterHeroView_:Show(false)
		self.customCenterSceneView_:Show(true, self.selectSceneID_)
	end
end

function CustomCenterView:SwitchHeroType()
	self.typeController_:SetSelectedState("hero")
	self.heroUIList_:StartScroll(#self.heroIDList_, table.keyof(self.heroIDList_, self.selectHeroID_))

	if self.firstEnter_ then
		self:OnSelectHero(self.selectHeroID_)
	end

	self.firstEnter_ = true
end

function CustomCenterView:SwitchSceneType()
	self.typeController_:SetSelectedState("scene")

	self.sceneIDList_ = CustomCenterTools.GetSceneList(self.skinID_, self.selectSceneID_)

	self.sceneUIList_:StartScroll(#self.sceneIDList_, table.keyof(self.sceneIDList_, self.selectSceneID_))
end

function CustomCenterView:OnUpdateHeroSkinList()
	self.heroUIList_:Refresh()
	self.customCenterHeroView_:RefreshUI()
end

function CustomCenterView:RefreshHeroList()
	self.filterView_:OnEnter(self.heroViewProxy_)
	self.filterView_:SetHeroIdList((HeroTools.Sort(HeroData:GetHeroList())))
end

function CustomCenterView:OnMainHomeViewTop()
	if self.filterView_ then
		self.filterView_:Reset()
	end
end

function CustomCenterView:OnListChange(arg_20_1)
	self.heroIDList_ = arg_20_1

	if table.keyof(self.heroIDList_, self.selectHeroID_) == nil then
		self.selectHeroID_ = self.heroIDList_[1] or self.selectHeroID_
	end

	self.heroUIList_:StartScroll(#self.heroIDList_, table.keyof(self.heroIDList_, self.selectHeroID_))
	self:OnSelectHero(self.selectHeroID_)
end

function CustomCenterView:OnHeroSort(arg_21_1)
	self.filterView_:RefreshSort(arg_21_1)
end

function CustomCenterView:OnSelectHero(arg_22_1)
	if arg_22_1 == nil then
		return
	end

	self.selectHeroID_ = arg_22_1
	self.skinID_ = PlayerData:GetCacheHeroSkinID(arg_22_1)

	self.heroUIList_:Refresh()

	local var_22_0 = manager.loadScene:GetTimeSceneID((CustomCenterTools.GetMatchScene(self.skinID_, self.selectSceneID_)))

	if self.lastSkinID_ ~= self.skinID_ or self.selectSceneID_ ~= var_22_0 then
		self.selectSceneID_ = var_22_0

		self:UpdateAvatarView(self.skinID_)
	else
		self.selectSceneID_ = var_22_0
	end

	self.customCenterHeroView_:Show(true, self.selectHeroID_)
end

function CustomCenterView:OnSwitchHeroSkin()
	self:OnSelectHero(self.selectHeroID_)
end

function CustomCenterView:OnSwitchRandomHero()
	self.heroUIList_:Refresh()
	self.customCenterHeroView_:Show(true, self.selectHeroID_)
end

function CustomCenterView:OnChangeHero(arg_25_1)
	self.heroUIList_:Refresh()
end

function CustomCenterView:OnSelectScene(arg_26_1)
	self.selectSceneID_ = arg_26_1

	self.sceneUIList_:Refresh()

	if self.selectSceneID_ ~= arg_26_1 then
		self:UpdateAvatarView(self.skinID_)
	end

	self.customCenterSceneView_:Show(true, self.selectSceneID_)
end

function CustomCenterView:OnUpdateSceneList()
	self.sceneUIList_:Refresh()
	self.customCenterSceneView_:RefreshUI()
end

function CustomCenterView:OnSwitchRandomScene()
	self.sceneUIList_:Refresh()
	self.customCenterSceneView_:Show(true, self.selectSceneID_)
end

function CustomCenterView:UpdateSceneView(arg_29_1, arg_29_2)
	PlayerData:AddSelectSkinID(self.skinID_)
	HomeSceneSettingData:AddSelectSceneID(arg_29_1)
	HomeSceneSettingData:SetPreviewSceneParams((HomeSceneSettingData:SetPreviewScene(arg_29_1, self.skinID_)))

	local var_29_0 = manager.loadScene:GetPreviewHomeShouldLoadSceneName()

	if self.previewSceneName_ ~= nil and self.previewSceneName_ ~= var_29_0 then
		manager.ui:UIEventEnabled(false)

		if self.sceneTransitionView_ == nil then
			self.sceneTransitionView_ = CustomCenterSceneTransition.New(self.vagueParent_)
		end

		self.sceneTransitionView_:SnapShot()
		self.sceneTransitionView_:PlayVagueAnimator(function()
			manager.loadScene:ForceSetShouldLoadSceneName("homePreview", function()
				manager.ui:UIEventEnabled(true)
				self.sceneTransitionView_:PlayAlphaAnimator()

				self.previewSceneName_ = var_29_0

				self:SetCamera()
				arg_29_2()
			end)
		end)
	else
		manager.ui:UIEventEnabled(false)
		manager.loadScene:ForceSetShouldLoadSceneName("homePreview", function()
			manager.ui:UIEventEnabled(true)

			self.previewSceneName_ = var_29_0

			self:SetCamera()
			arg_29_2()
		end)
	end
end

function CustomCenterView:UpdateAvatarView(arg_33_1)
	self:UpdateSceneView(self.selectSceneID_, function()
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.preview, {
			skinID = arg_33_1
		}, true)

		if self.lastSkinID_ and self.skinID_ ~= self.lastSkinID_ then
			self:PlayModelChangeEffect(manager.posterGirl:GetModel())
		end

		self.lastSkinID_ = self.skinID_

		manager.loadScene:SetHomeSceneSoundEffect()
		self:PlayBGM()
	end)
end

function CustomCenterView:PlayModelChangeEffect(arg_35_1)
	LuaForUtil.PlayEffect(arg_35_1.transform, SectionSelectHeroConst.HERO_CHANGE_FX_PATH, Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)
end

function CustomCenterView:SetCamera()
	if CameraCfg["home_" .. self.selectSceneID_] then
		manager.ui:SetMainCamera("home_" .. self.selectSceneID_, nil, false, true)
	else
		manager.ui:SetMainCamera("home", nil, false, true)
	end
end

function CustomCenterView:PlayBGM()
	if HomeSceneSettingCfg[self.selectSceneID_].default_music ~= 0 and table.indexof(HomeSceneSettingCfg[self.selectSceneID_].scene_setting, HomeSceneSettingConst.SETTING.SCENE_BGM) then
		PlayGameBGMID(HomeSceneSettingCfg[self.selectSceneID_].default_music)
	else
		PlayGameSetBGM()
	end
end

function CustomCenterView:IndexHeroItem(arg_38_1, arg_38_2)
	arg_38_2:SetHeroData(self.heroIDList_[arg_38_1], self.selectHeroID_)
end

function CustomCenterView:IndexSceneItem(arg_39_1, arg_39_2)
	arg_39_2:SetSceneData(self.sceneIDList_[arg_39_1], self.selectSceneID_)
end

function CustomCenterView:OnClearHero()
	CustomCenterTools.SetCacheRandomHeroSkinList({})
	PlayerData:SetClearHeroFlag(true)
end

function CustomCenterView:OnClearScene()
	CustomCenterTools.SetCacheRandomSceneList({})
	HomeSceneSettingData:SetClearSceneFlag(true)
end

function CustomCenterView:OnChangeScene()
	self.sceneUIList_:Refresh()
end

function CustomCenterView:SetSceneThenExit(arg_43_1, arg_43_2, arg_43_3)
	local var_43_0

	if arg_43_1 then
		var_43_0 = self.selectSceneID_
	elseif not CustomCenterTools.IsRandomScene() then
		var_43_0 = CustomCenterTools.IsDLCScene(self.selectSceneID_) and not CustomCenterTools.IsDLCScene(arg_43_2) and arg_43_2 or self.selectSceneID_
	end

	HomeSceneSettingAction.SetHomeSceneWithCallback(var_43_0, true, false, function()
		self:ExitOverFunc(arg_43_3)
	end)
end

function CustomCenterView:ExitFunc(arg_45_1)
	if not manager.ui:GetIsUIEventEnabled() then
		ShowTips("LOADING")

		return
	end

	local var_45_0 = manager.loadScene:GetTimeSceneID((HomeSceneSettingData:GetCurSceneID()))
	local var_45_1 = not CustomCenterTools.IsRandomHero() and self.skinID_ ~= PlayerData:GetPosterGirlHeroSkinId()
	local var_45_2 = not CustomCenterTools.IsRandomScene() and self.selectSceneID_ ~= var_45_0 and (SkinSceneActionCfg.get_id_list_by_special_scene_id[self.selectSceneID_] and not CustomCenterTools.IsRandomHero() or not SkinSceneActionCfg.get_id_list_by_special_scene_id[self.selectSceneID_])

	if var_45_1 or var_45_2 then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("CUSTOM_CENTER_SWITCH_SCENE_WARING"),
			OkCallback = function()
				if var_45_1 then
					local var_46_0 = SkinCfg[self.skinID_].hero

					HeroAction.SelectSkinWithCallback(SkinCfg[self.skinID_].hero, self.skinID_, function()
						PlayerAction.ChangePosterGirlWithCallback(var_46_0, function()
							self:SetSceneThenExit(var_45_2, var_45_0, arg_45_1)
						end)
					end)
				else
					self:SetSceneThenExit(var_45_2, var_45_0, arg_45_1)
				end
			end,
			CancelCallback = function()
				self:ExitOverFunc(arg_45_1)
			end,
			MaskCallback = function()
				return
			end
		})

		if not CustomCenterTools.IsRandomScene() then
			HomeSceneSettingAction.SetHomeScene(var_45_0, true)
		end

		HomeSceneSettingData:SetCacheSceneID()

		return
	end

	self:ExitOverFunc(arg_45_1)
end

function CustomCenterView:ExitOverFunc(arg_51_1)
	local var_51_0 = 0

	HomeSceneSettingData:SetCacheSceneID()
	manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)

	local var_51_1 = PlayerData:GetRandomHeroMode()
	local var_51_2 = CustomCenterTools.IsRandomScene()
	local var_51_3 = HomeSceneSettingData:GetRandomMode()

	PlayerData:SetForceRandomHeroID(nil)

	if CustomCenterTools.IsRandomHero() then
		local var_51_4 = CustomCenterTools.GetLastPreviewHero()

		PlayerData:SetForceRandomHeroID(var_51_4)

		var_51_0 = var_51_4
	else
		var_51_0 = HeroTools.HeroUsingSkinInfo(PlayerData:GetPlayerInfo().poster_girl).id
	end

	HomeSceneSettingData:SetForceRandomSceneID(nil)

	if var_51_2 then
		HomeSceneSettingData:SetForceRandomSceneID(CustomCenterTools.GetLastPreviewScene())
	end

	if var_51_0 ~= self.homeSkinID_ then
		PlayerData:SetPlayAssistantVoice(SkinCfg[var_51_0].hero, SkinCfg[self.homeSkinID_].hero == SkinCfg[var_51_0].hero)
	end

	arg_51_1()
end

return CustomCenterView
