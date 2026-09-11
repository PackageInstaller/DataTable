local CustomCenterSceneView = class("CustomCenterSceneView", ReduxView)

function CustomCenterSceneView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.randomController_ = self.controllerEx_:GetController("random")
	self.useStateController_ = self.controllerEx_:GetController("useState")
	self.sceneBGMController_ = self.controllerEx_:GetController("sceneBGM")
	self.soundEffectController_ = self.controllerEx_:GetController("soundEffect")
	self.sceneBGMToggleView_ = CustomCenterToggle.New(self.sceneBGMGo_)

	self.sceneBGMToggleView_:RegisterClickListener(function()
		SettingAction.ChangeHomeSceneSetting("home_scene_scene_bgm", 1 - SettingData:GetHomeSceneSettingData().home_scene_scene_bgm)
		self:RefreshSceneMusicPanel()
	end)

	self.soundEffectToggleView_ = CustomCenterToggle.New(self.soundEffectGo_)

	self.soundEffectToggleView_:RegisterClickListener(function()
		SettingAction.ChangeHomeSceneSetting("home_scene_sound_effect", 1 - SettingData:GetHomeSceneSettingData().home_scene_sound_effect)
		self:RefreshSoundEffectPanel()
	end)

	self.randomToggleView_ = CustomCenterToggle.New(self.randomGo_)

	self.randomToggleView_:RegisterClickListener(function()
		local var_4_0 = not CustomCenterTools.IsRandomScene()

		CustomCenterAction.SwitchSceneRandom(var_4_0, function()
			if var_4_0 == true and CustomCenterTools:GetRandomSceneCnt() <= 0 then
				if CustomCenterTools.IsDLCScene(self.sceneID_) then
					CustomCenterTools.UpdateCacheRandomSceneID(GameSetting.home_sence_default.value[2])
				else
					CustomCenterTools.UpdateCacheRandomSceneID(self.sceneID_)
				end

				CustomCenterAction.SaveRandomSceneList(function()
					manager.notify:Invoke(CUSTOM_CENTER_UPDATE_RANDOM_SCENE_LIST)
				end)
			end

			manager.notify:Invoke(CUSTOM_CENTER_SWITCH_RANDOM_SCENE)
		end)
	end)

	self.addToggleView_ = CustomCenterToggle.New(self.addGo_)

	self.addToggleView_:RegisterClickListener(function()
		if CustomCenterTools:GetRandomSceneCnt() <= 1 and CustomCenterTools.IsContentRandomSceneID(self.sceneID_) then
			ShowMessageBox({
				content = GetTips("RANDOM_SCENE_TIPS2"),
				OkCallback = function()
					CustomCenterAction.SwitchSceneRandom(false, function()
						manager.notify:Invoke(CUSTOM_CENTER_SWITCH_RANDOM_SCENE)
						CustomCenterTools.UpdateCacheRandomSceneID(self.sceneID_)
						CustomCenterAction.SaveRandomSceneList(function()
							manager.notify:Invoke(CUSTOM_CENTER_UPDATE_RANDOM_SCENE_LIST)
						end)
					end)
				end
			})

			return
		end

		CustomCenterTools.UpdateCacheRandomSceneID(self.sceneID_)
		CustomCenterAction.SaveRandomSceneList(function()
			manager.notify:Invoke(CUSTOM_CENTER_UPDATE_RANDOM_SCENE_LIST)
		end)
	end)

	self.OnChangeSceneHandler_ = handler(self, self.OnChangeScene)
	self.OnSwitchRandomModeHandler_ = handler(self, self.OnSwitchRandomMode)
end

function CustomCenterSceneView:OnEnter()
	manager.notify:RegistListener(HOME_SCENE_CHANGE, self.OnChangeSceneHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_SWITCH_RANDOM_MODE, self.OnSwitchRandomModeHandler_)
end

function CustomCenterSceneView:OnExit()
	manager.notify:RemoveListener(HOME_SCENE_CHANGE, self.OnChangeSceneHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_SWITCH_RANDOM_MODE, self.OnSwitchRandomModeHandler_)
end

function CustomCenterSceneView:Dispose()
	self.OnChangeSceneHandler_ = nil
	self.OnSwitchRandomModeHandler_ = nil

	self.sceneBGMToggleView_:Dispose()

	self.sceneBGMToggleView_ = nil

	self.soundEffectToggleView_:Dispose()

	self.soundEffectToggleView_ = nil

	self.randomToggleView_:Dispose()

	self.randomToggleView_ = nil

	self.addToggleView_:Dispose()

	self.addToggleView_ = nil

	CustomCenterSceneView.super.Dispose(self)
end

function CustomCenterSceneView:AddListeners()
	self:AddBtnListener(self.clearBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("CUSTOM_CENTER_CLEAR_SCENE"),
			OkCallback = function()
				manager.notify:Invoke(CUSTOM_CENTER_CLEAR_SCENE)
				manager.notify:Invoke(CUSTOM_CENTER_UPDATE_RANDOM_SCENE_LIST)
			end
		})
	end)
	self:AddBtnListener(self.randomBtn_, nil, function()
		JumpTools.OpenPageByJump("randomSceneModePop", {
			type = HomeSceneSettingData:GetRandomMode()
		})
	end)
	self:AddBtnListener(self.useBtn_, nil, function()
		if CustomCenterTools.IsDLCScene(self.sceneID_) then
			local var_19_0 = CustomCenterTools.GetMatchSkinByScene(self.sceneID_)
			local var_19_1 = SkinCfg[var_19_0].hero

			if PlayerData:IsRandomHero() then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("CUSTOM_CENTER_USE_DLC_SCENE_WARING"),
					OkCallback = function()
						PlayerAction.SetIsRandomHero(false, function()
							return
						end)
						HeroAction.SelectSkin(var_19_1, var_19_0)
						PlayerAction.ChangePosterGirl(var_19_1)

						if PosterGirlTools.SceneHasTimeEffect(self.sceneID_) then
							HomeSceneSettingData:SetIsTimeScene(false)
						end

						HomeSceneSettingAction.SetHomeScene(self.sceneID_, true)
					end
				})

				return
			else
				HeroAction.SelectSkin(SkinCfg[var_19_0].hero, var_19_0)
				PlayerAction.ChangePosterGirl(SkinCfg[var_19_0].hero)

				if PosterGirlTools.SceneHasTimeEffect(self.sceneID_) then
					HomeSceneSettingData:SetIsTimeScene(false)
				end

				HomeSceneSettingAction.SetHomeScene(self.sceneID_, true)

				return
			end
		end

		if PosterGirlTools.SceneHasTimeEffect(self.sceneID_) then
			HomeSceneSettingData:SetIsTimeScene(false)
		end

		HomeSceneSettingAction.SetHomeScene(self.sceneID_, true)

		if HomeSceneSettingData:GetRealScene() == self.sceneID_ then
			manager.notify:CallUpdateFunc(HOME_SCENE_CHANGE)
			manager.notify:Invoke(HOME_SCENE_CHANGE)
		end
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		self:Go("/customCenterSceneDetail", {
			sceneID = self.sceneID_
		})
	end)
	self:AddBtnListener(self.sceneDlcBtn_, nil, function()
		JumpTools.OpenPageByJump("activitySkinDrawDLCPopView", {
			sceneID = self.sceneID_
		})
	end)
end

function CustomCenterSceneView:Show(arg_24_1, arg_24_2)
	if arg_24_1 then
		self.sceneID_ = arg_24_2

		self:RefreshUI()
	end

	SetActive(self.gameObject_, arg_24_1)
end

function CustomCenterSceneView:RefreshUI()
	self:RefreshRandomPanel()
	self:RefreshNameText()
	self:RefreshInfoBtn()
	self:RefreshDlcBtn()
end

function CustomCenterSceneView:RefreshRandomPanel()
	if CustomCenterTools.IsRandomScene() then
		if HomeSceneSettingCfg[self.sceneID_].limit_display ~= 1 then
			self.randomController_:SetSelectedState("isDLC")
		else
			self.randomController_:SetSelectedState("true")
		end

		self.randomToggleView_:SetSelectedState(true)
		self:RefreshRandomText()
		self:RefreshRandomCnt()
		self:RefreshAddBtn()
	else
		if CustomCenterTools.IsRandomHero() and CustomCenterTools.IsDLCScene(self.sceneID_) then
			self.randomController_:SetSelectedState("notSelectDLC")
		else
			self.randomController_:SetSelectedState("false")
		end

		self.randomToggleView_:SetSelectedState(false)
		self:RefreshUseBtn()
	end

	self:RefreshSceneMusicPanel()
	self:RefreshSoundEffectPanel()
end

function CustomCenterSceneView:RefreshInfoBtn()
	if CustomCenterTools.IsDLCScene(self.sceneID_) then
		SetActive(self.infoBtn_.gameObject, false)
	else
		SetActive(self.infoBtn_.gameObject, true)
	end
end

function CustomCenterSceneView:RefreshDlcBtn()
	local var_28_0 = HomeSceneBundleCfg.get_id_list_by_scene_id[self.sceneID_] or {}

	if #var_28_0 > 0 then
		local var_28_1 = 0

		for iter_28_0, iter_28_1 in ipairs(var_28_0) do
			if ItemTools.getItemNum(HomeSceneBundleCfg[iter_28_1].item_id) > 0 then
				var_28_1 = var_28_1 + 1
			end
		end

		self.sceneDlcNumText_.text = string.format("%s/%s", var_28_1, #var_28_0)

		SetActive(self.sceneDlcBtn_.gameObject, true)
	else
		SetActive(self.sceneDlcBtn_.gameObject, false)
	end
end

function CustomCenterSceneView:RefreshRandomCnt()
	self.numText_.text = CustomCenterTools.GetRandomSceneCnt()
end

function CustomCenterSceneView:RefreshNameText()
	self.nameText_.text = HomeSceneSettingCfg[self.sceneID_].title
end

function CustomCenterSceneView:RefreshRandomText()
	local var_31_0 = HomeSceneSettingData:GetRandomMode()

	self.randomModeText_.text = var_31_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_DAY and GetTips("RANDOM_MODE_SETTING_PERDAY") or var_31_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_LOGIN and GetTips("RANDOM_MODE_SETTING_PERTIME") or var_31_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER and GetTips("RANDOM_MODE_SETTING_PERPLAY") or "unknown"
end

function CustomCenterSceneView:RefreshUseBtn()
	if manager.loadScene:GetTimeSceneID((HomeSceneSettingData:GetRealScene())) == self.sceneID_ then
		self.useStateController_:SetSelectedState("true")
	else
		self.useStateController_:SetSelectedState("false")
	end
end

function CustomCenterSceneView:RefreshAddBtn()
	self.addToggleView_:SetSelectedState((CustomCenterTools.IsContentRandomSceneID(self.sceneID_)))
end

function CustomCenterSceneView:RefreshSceneMusicPanel()
	if table.keyof(HomeSceneSettingCfg[self.sceneID_].scene_setting, HomeSceneSettingConst.SETTING.SCENE_BGM) then
		self.sceneBGMController_:SetSelectedState("true")
	else
		self.sceneBGMController_:SetSelectedState("false")
	end

	self.sceneBGMToggleView_:SetSelectedState(SettingData:GetHomeSceneSettingData().home_scene_scene_bgm == 1)
end

function CustomCenterSceneView:RefreshSoundEffectPanel()
	if table.keyof(HomeSceneSettingCfg[self.sceneID_].scene_setting, HomeSceneSettingConst.SETTING.SOUND_EFFECT) then
		self.soundEffectController_:SetSelectedState("true")
	else
		self.soundEffectController_:SetSelectedState("false")
	end

	self.soundEffectToggleView_:SetSelectedState(SettingData:GetHomeSceneSettingData().home_scene_sound_effect == 1)
end

function CustomCenterSceneView:OnSwitchRandomMode()
	self:RefreshRandomText()
end

function CustomCenterSceneView:OnChangeScene()
	self:RefreshUseBtn()
end

return CustomCenterSceneView
