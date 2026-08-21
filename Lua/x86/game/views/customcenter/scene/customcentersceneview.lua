local var_0_0 = class("CustomCenterSceneView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.randomController_ = arg_1_0.controllerEx_:GetController("random")
	arg_1_0.useStateController_ = arg_1_0.controllerEx_:GetController("useState")
	arg_1_0.sceneBGMController_ = arg_1_0.controllerEx_:GetController("sceneBGM")
	arg_1_0.soundEffectController_ = arg_1_0.controllerEx_:GetController("soundEffect")
	arg_1_0.sceneBGMToggleView_ = CustomCenterToggle.New(arg_1_0.sceneBGMGo_)

	arg_1_0.sceneBGMToggleView_:RegisterClickListener(function()
		local var_2_0 = 1 - SettingData:GetHomeSceneSettingData().home_scene_scene_bgm

		SettingAction.ChangeHomeSceneSetting("home_scene_scene_bgm", var_2_0)
		arg_1_0:RefreshSceneMusicPanel()
	end)

	arg_1_0.soundEffectToggleView_ = CustomCenterToggle.New(arg_1_0.soundEffectGo_)

	arg_1_0.soundEffectToggleView_:RegisterClickListener(function()
		local var_3_0 = 1 - SettingData:GetHomeSceneSettingData().home_scene_sound_effect

		SettingAction.ChangeHomeSceneSetting("home_scene_sound_effect", var_3_0)
		arg_1_0:RefreshSoundEffectPanel()
	end)

	arg_1_0.randomToggleView_ = CustomCenterToggle.New(arg_1_0.randomGo_)

	arg_1_0.randomToggleView_:RegisterClickListener(function()
		local var_4_0 = not CustomCenterTools.IsRandomScene()

		CustomCenterAction.SwitchSceneRandom(var_4_0, function()
			if var_4_0 == true and CustomCenterTools:GetRandomSceneCnt() <= 0 then
				if CustomCenterTools.IsDLCScene(arg_1_0.sceneID_) then
					CustomCenterTools.UpdateCacheRandomSceneID(GameSetting.home_sence_default.value[2])
				else
					CustomCenterTools.UpdateCacheRandomSceneID(arg_1_0.sceneID_)
				end

				CustomCenterAction.SaveRandomSceneList(function()
					manager.notify:Invoke(CUSTOM_CENTER_UPDATE_RANDOM_SCENE_LIST)
				end)
			end

			manager.notify:Invoke(CUSTOM_CENTER_SWITCH_RANDOM_SCENE)
		end)
	end)

	arg_1_0.addToggleView_ = CustomCenterToggle.New(arg_1_0.addGo_)

	arg_1_0.addToggleView_:RegisterClickListener(function()
		if CustomCenterTools:GetRandomSceneCnt() <= 1 and CustomCenterTools.IsContentRandomSceneID(arg_1_0.sceneID_) then
			ShowMessageBox({
				content = GetTips("RANDOM_SCENE_TIPS2"),
				OkCallback = function()
					CustomCenterAction.SwitchSceneRandom(false, function()
						manager.notify:Invoke(CUSTOM_CENTER_SWITCH_RANDOM_SCENE)
						CustomCenterTools.UpdateCacheRandomSceneID(arg_1_0.sceneID_)
						CustomCenterAction.SaveRandomSceneList(function()
							manager.notify:Invoke(CUSTOM_CENTER_UPDATE_RANDOM_SCENE_LIST)
						end)
					end)
				end
			})

			return
		end

		CustomCenterTools.UpdateCacheRandomSceneID(arg_1_0.sceneID_)
		CustomCenterAction.SaveRandomSceneList(function()
			manager.notify:Invoke(CUSTOM_CENTER_UPDATE_RANDOM_SCENE_LIST)
		end)
	end)

	arg_1_0.OnChangeSceneHandler_ = handler(arg_1_0, arg_1_0.OnChangeScene)
	arg_1_0.OnSwitchRandomModeHandler_ = handler(arg_1_0, arg_1_0.OnSwitchRandomMode)
end

function var_0_0.OnEnter(arg_12_0)
	manager.notify:RegistListener(HOME_SCENE_CHANGE, arg_12_0.OnChangeSceneHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_SWITCH_RANDOM_MODE, arg_12_0.OnSwitchRandomModeHandler_)
end

function var_0_0.OnExit(arg_13_0)
	manager.notify:RemoveListener(HOME_SCENE_CHANGE, arg_13_0.OnChangeSceneHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_SWITCH_RANDOM_MODE, arg_13_0.OnSwitchRandomModeHandler_)
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.OnChangeSceneHandler_ = nil
	arg_14_0.OnSwitchRandomModeHandler_ = nil

	arg_14_0.sceneBGMToggleView_:Dispose()

	arg_14_0.sceneBGMToggleView_ = nil

	arg_14_0.soundEffectToggleView_:Dispose()

	arg_14_0.soundEffectToggleView_ = nil

	arg_14_0.randomToggleView_:Dispose()

	arg_14_0.randomToggleView_ = nil

	arg_14_0.addToggleView_:Dispose()

	arg_14_0.addToggleView_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.AddListeners(arg_15_0)
	arg_15_0:AddBtnListener(arg_15_0.clearBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("CUSTOM_CENTER_CLEAR_SCENE"),
			OkCallback = function()
				manager.notify:Invoke(CUSTOM_CENTER_CLEAR_SCENE)
				manager.notify:Invoke(CUSTOM_CENTER_UPDATE_RANDOM_SCENE_LIST)
			end
		})
	end)
	arg_15_0:AddBtnListener(arg_15_0.randomBtn_, nil, function()
		JumpTools.OpenPageByJump("randomSceneModePop", {
			type = HomeSceneSettingData:GetRandomMode()
		})
	end)
	arg_15_0:AddBtnListener(arg_15_0.useBtn_, nil, function()
		if CustomCenterTools.IsDLCScene(arg_15_0.sceneID_) then
			local var_19_0 = CustomCenterTools.GetMatchSkinByScene(arg_15_0.sceneID_)
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

						if PosterGirlTools.SceneHasTimeEffect(arg_15_0.sceneID_) then
							HomeSceneSettingData:SetIsTimeScene(false)
						end

						HomeSceneSettingAction.SetHomeScene(arg_15_0.sceneID_, true)
					end
				})

				return
			else
				HeroAction.SelectSkin(var_19_1, var_19_0)
				PlayerAction.ChangePosterGirl(var_19_1)

				if PosterGirlTools.SceneHasTimeEffect(arg_15_0.sceneID_) then
					HomeSceneSettingData:SetIsTimeScene(false)
				end

				HomeSceneSettingAction.SetHomeScene(arg_15_0.sceneID_, true)

				return
			end
		end

		if PosterGirlTools.SceneHasTimeEffect(arg_15_0.sceneID_) then
			HomeSceneSettingData:SetIsTimeScene(false)
		end

		HomeSceneSettingAction.SetHomeScene(arg_15_0.sceneID_, true)

		if HomeSceneSettingData:GetRealScene() == arg_15_0.sceneID_ then
			manager.notify:CallUpdateFunc(HOME_SCENE_CHANGE)
			manager.notify:Invoke(HOME_SCENE_CHANGE)
		end
	end)
	arg_15_0:AddBtnListener(arg_15_0.infoBtn_, nil, function()
		arg_15_0:Go("/customCenterSceneDetail", {
			sceneID = arg_15_0.sceneID_
		})
	end)
	arg_15_0:AddBtnListener(arg_15_0.sceneDlcBtn_, nil, function()
		JumpTools.OpenPageByJump("activitySkinDrawDLCPopView", {
			sceneID = arg_15_0.sceneID_
		})
	end)
end

function var_0_0.Show(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 then
		arg_24_0.sceneID_ = arg_24_2

		arg_24_0:RefreshUI()
	end

	SetActive(arg_24_0.gameObject_, arg_24_1)
end

function var_0_0.RefreshUI(arg_25_0)
	arg_25_0:RefreshRandomPanel()
	arg_25_0:RefreshNameText()
	arg_25_0:RefreshInfoBtn()
	arg_25_0:RefreshDlcBtn()
end

function var_0_0.RefreshRandomPanel(arg_26_0)
	if CustomCenterTools.IsRandomScene() then
		if HomeSceneSettingCfg[arg_26_0.sceneID_].limit_display ~= 1 then
			arg_26_0.randomController_:SetSelectedState("isDLC")
		else
			arg_26_0.randomController_:SetSelectedState("true")
		end

		arg_26_0.randomToggleView_:SetSelectedState(true)
		arg_26_0:RefreshRandomText()
		arg_26_0:RefreshRandomCnt()
		arg_26_0:RefreshAddBtn()
	else
		if CustomCenterTools.IsRandomHero() and CustomCenterTools.IsDLCScene(arg_26_0.sceneID_) then
			arg_26_0.randomController_:SetSelectedState("notSelectDLC")
		else
			arg_26_0.randomController_:SetSelectedState("false")
		end

		arg_26_0.randomToggleView_:SetSelectedState(false)
		arg_26_0:RefreshUseBtn()
	end

	arg_26_0:RefreshSceneMusicPanel()
	arg_26_0:RefreshSoundEffectPanel()
end

function var_0_0.RefreshInfoBtn(arg_27_0)
	if CustomCenterTools.IsDLCScene(arg_27_0.sceneID_) then
		SetActive(arg_27_0.infoBtn_.gameObject, false)
	else
		SetActive(arg_27_0.infoBtn_.gameObject, true)
	end
end

function var_0_0.RefreshDlcBtn(arg_28_0)
	local var_28_0 = HomeSceneBundleCfg.get_id_list_by_scene_id[arg_28_0.sceneID_] or {}

	if #var_28_0 > 0 then
		local var_28_1 = 0

		for iter_28_0, iter_28_1 in ipairs(var_28_0) do
			if ItemTools.getItemNum(HomeSceneBundleCfg[iter_28_1].item_id) > 0 then
				var_28_1 = var_28_1 + 1
			end
		end

		arg_28_0.sceneDlcNumText_.text = string.format("%s/%s", var_28_1, #var_28_0)

		SetActive(arg_28_0.sceneDlcBtn_.gameObject, true)
	else
		SetActive(arg_28_0.sceneDlcBtn_.gameObject, false)
	end
end

function var_0_0.RefreshRandomCnt(arg_29_0)
	arg_29_0.numText_.text = CustomCenterTools.GetRandomSceneCnt()
end

function var_0_0.RefreshNameText(arg_30_0)
	arg_30_0.nameText_.text = HomeSceneSettingCfg[arg_30_0.sceneID_].title
end

function var_0_0.RefreshRandomText(arg_31_0)
	local var_31_0 = HomeSceneSettingData:GetRandomMode()

	if var_31_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_DAY then
		arg_31_0.randomModeText_.text = GetTips("RANDOM_MODE_SETTING_PERDAY")
	elseif var_31_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_LOGIN then
		arg_31_0.randomModeText_.text = GetTips("RANDOM_MODE_SETTING_PERTIME")
	elseif var_31_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER then
		arg_31_0.randomModeText_.text = GetTips("RANDOM_MODE_SETTING_PERPLAY")
	else
		arg_31_0.randomModeText_.text = "unknown"
	end
end

function var_0_0.RefreshUseBtn(arg_32_0)
	local var_32_0 = HomeSceneSettingData:GetRealScene()

	if manager.loadScene:GetTimeSceneID(var_32_0) == arg_32_0.sceneID_ then
		arg_32_0.useStateController_:SetSelectedState("true")
	else
		arg_32_0.useStateController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshAddBtn(arg_33_0)
	local var_33_0 = CustomCenterTools.IsContentRandomSceneID(arg_33_0.sceneID_)

	arg_33_0.addToggleView_:SetSelectedState(var_33_0)
end

function var_0_0.RefreshSceneMusicPanel(arg_34_0)
	local var_34_0 = HomeSceneSettingCfg[arg_34_0.sceneID_]

	if table.keyof(var_34_0.scene_setting, HomeSceneSettingConst.SETTING.SCENE_BGM) then
		arg_34_0.sceneBGMController_:SetSelectedState("true")
	else
		arg_34_0.sceneBGMController_:SetSelectedState("false")
	end

	local var_34_1 = SettingData:GetHomeSceneSettingData().home_scene_scene_bgm == 1

	arg_34_0.sceneBGMToggleView_:SetSelectedState(var_34_1)
end

function var_0_0.RefreshSoundEffectPanel(arg_35_0)
	local var_35_0 = HomeSceneSettingCfg[arg_35_0.sceneID_]

	if table.keyof(var_35_0.scene_setting, HomeSceneSettingConst.SETTING.SOUND_EFFECT) then
		arg_35_0.soundEffectController_:SetSelectedState("true")
	else
		arg_35_0.soundEffectController_:SetSelectedState("false")
	end

	local var_35_1 = SettingData:GetHomeSceneSettingData().home_scene_sound_effect == 1

	arg_35_0.soundEffectToggleView_:SetSelectedState(var_35_1)
end

function var_0_0.OnSwitchRandomMode(arg_36_0)
	arg_36_0:RefreshRandomText()
end

function var_0_0.OnChangeScene(arg_37_0)
	arg_37_0:RefreshUseBtn()
end

return var_0_0
