local var_0_0 = {}

function var_0_0.ChangePicSetting(arg_1_0, arg_1_1)
	SettingData:ModifyPicSetting(arg_1_0, arg_1_1)
	var_0_0.DeployPicSetting(arg_1_0, arg_1_1)
	manager.notify:CallUpdateFunc(PIC_SETTING_CHANGE, {}, {
		key = arg_1_0,
		data = arg_1_1
	})
end

function var_0_0.ChangeSoundSetting(arg_2_0, arg_2_1)
	SettingData:ModifySoundSetting(arg_2_0, arg_2_1)
	var_0_0.DeploySoundSetting(arg_2_0, arg_2_1)
	manager.notify:CallUpdateFunc(SOUND_SETTING_CHANGE, {}, {
		key = arg_2_0,
		data = arg_2_1
	})
end

function var_0_0.ChangePushSetting(arg_3_0, arg_3_1)
	SettingData:ModifyPushSetting(arg_3_0, arg_3_1)
	manager.notify:CallUpdateFunc(PUSH_SETTING_CHANGE, {}, {
		key = arg_3_0,
		data = arg_3_1
	})
end

function var_0_0.ChangeGameSetting(arg_4_0, arg_4_1)
	SettingData:ModifyGameSetting(arg_4_0, arg_4_1)
	var_0_0.DeployGameSetting(arg_4_0, arg_4_1)
	manager.notify:CallUpdateFunc(GAME_SETTING_CHANGE, {}, {
		key = arg_4_0,
		data = arg_4_1
	})
end

function var_0_0.ChangeRemindSetting(arg_5_0, arg_5_1)
	SettingData:ModifyRemindSetting(arg_5_0, arg_5_1)
	manager.notify:CallUpdateFunc(REMIND_SETTING_CHANGE, {}, {
		key = arg_5_0,
		data = arg_5_1
	})
end

function var_0_0.DeployPicSetting(arg_6_0, arg_6_1)
	local var_6_0 = {}

	if arg_6_0 == "picOptionId" and arg_6_1 ~= SettingConst.GRAPHIC_CUSTOM_ID then
		if GameToSDK.IsPCPlatform() then
			local var_6_1 = PictureQualitySettingPcCfg[arg_6_1]

			var_6_0.picOptionId = var_6_1.id
			var_6_0.user_effect = var_6_1.user_effect
			var_6_0.teammate_effect = var_6_1.teammate_effect
			var_6_0.frame = var_6_1.frame
			var_6_0.shadow = var_6_1.shadow
			var_6_0.post_process = var_6_1.post_process
			var_6_0.anti_aliasing = var_6_1.anti_aliasing
			var_6_0.vertical_sync = var_6_1.vertical_sync
		else
			local var_6_2 = PictureQualitySettingCfg[arg_6_1]

			var_6_0.picOptionId = var_6_2.id
			var_6_0.resolution = var_6_2.resolution
			var_6_0.frame = var_6_2.frame
			var_6_0.high_quality = var_6_2.high_quality
			var_6_0.anti_aliasing = var_6_2.anti_aliasing
			var_6_0.distortion_effect = var_6_2.distortion_effect
			var_6_0.reflection_effect = var_6_2.reflection_effect
			var_6_0.physical_simulation = var_6_2.physical_simulation
			var_6_0.teammate_effect = var_6_2.teammate_effect
			var_6_0.user_effect = var_6_2.user_effect
			var_6_0.super_resolution_enable = var_6_2.super_resolution_enable
		end
	elseif arg_6_0 == "allData" then
		var_6_0 = arg_6_1
	else
		var_6_0[arg_6_0] = arg_6_1
	end

	manager.ui.cameraExtension.hdr = true

	PlayerPrefs.SetInt("allowHDR", 1)

	if var_6_0.resolution then
		local var_6_3 = tonumber(var_6_0.resolution)
		local var_6_4, var_6_5 = SettingTools.GetSettingScreenSize(var_6_3)

		Screen.SetResolution(var_6_4, var_6_5, true)
	elseif var_6_0.pc_resolution then
		Screen.SetResolution(var_6_0.pc_resolution[1], var_6_0.pc_resolution[2], Screen.fullScreenMode)
	elseif var_6_0.anti_aliasing then
		if PlayerPrefs.GetInt("allowMSAA") == 0 then
			UnityEngine.Pipelines.SimPipeline.SimPipelineSettings.AliasingEnable = false
		else
			UnityEngine.Pipelines.SimPipeline.SimPipelineSettings.AliasingEnable = true
		end
	elseif var_6_0.frame then
		if GameToSDK.IsPCPlatform() then
			local var_6_6 = SettingConst.TARGET_FRAME_RATE[var_6_0.frame] or 60

			Application.targetFrameRate = var_6_6
		else
			Application.targetFrameRate = var_6_0.frame == 0 and 30 or var_6_0.frame == 1 and 60 or 120
		end
	elseif var_6_0.window then
		Screen.fullScreenMode = SettingTools.NumToFullScreenType(var_6_0.window)
	elseif var_6_0.vertical_sync then
		manager.IngameGraphic:ChangeVerticalSync(var_6_0.vertical_sync)
	elseif var_6_0.shadow then
		manager.IngameGraphic:ChangeShadowQuality(var_6_0.shadow)
	elseif var_6_0.post_process then
		manager.IngameGraphic:ChangePostProcessQuality(var_6_0.post_process)
	elseif var_6_0.render_scale then
		manager.IngameGraphic:ChangeRenderScale(var_6_0.render_scale)
	elseif var_6_0.depth_of_field_enable then
		manager.IngameGraphic:ChangeDof(var_6_0.depth_of_field_enable)
	end
end

function var_0_0.ChangeHomeSceneSetting(arg_7_0, arg_7_1)
	SettingData:ModifyHomeSceneSetting(arg_7_0, arg_7_1)
	manager.notify:CallUpdateFunc(HOME_SCENE_SETTING_CHANGE, {}, {
		key = arg_7_0,
		data = arg_7_1
	})

	local var_7_0 = SettingData:GetHomeSceneSettingData()
	local var_7_1 = var_7_0.home_scene_sound_effect
	local var_7_2 = var_7_0.home_scene_scene_bgm

	SDKTools.SendMessageToSDK("home_scene_setting", {
		sound_effect_setting = var_7_1,
		music_setting = var_7_2
	})
end

function var_0_0.DeploySoundSetting(arg_8_0, arg_8_1)
	if arg_8_0 == "allData" then
		for iter_8_0, iter_8_1 in pairs(arg_8_1) do
			var_0_0.ChangeSingleSoundSetting(iter_8_0, iter_8_1)
		end
	else
		var_0_0.ChangeSingleSoundSetting(arg_8_0, arg_8_1)
	end
end

function var_0_0.ChangeSingleSoundSetting(arg_9_0, arg_9_1)
	if arg_9_0 == "music" or arg_9_0 == "effect" or arg_9_0 == "voice" then
		manager.audio:SetVolume(arg_9_0, arg_9_1 / 100)
	elseif arg_9_0 == "sound_open" then
		manager.audio:SetAudioMasterMute(arg_9_1 == 0)
	elseif arg_9_0 == "voice_language" then
		local var_9_0 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]
		local var_9_1 = table.indexof(var_9_0.voice_list, arg_9_1) or 1
		local var_9_2 = VoiceLanguageCfg[var_9_0.voice_list[var_9_1]]

		if var_9_2 then
			manager.audio:SetLocalizationFlag(var_9_2.affix)
		end
	elseif arg_9_0 == "teammate_sound_open" then
		AudioManager.BattleTeammateVoiceSwitch = arg_9_1 == 1
	elseif arg_9_0 == "text_language" then
		PlayerPrefs.SetString("text_language", arg_9_1)
		I18NRuntimeManager.Instance:ChangeLanguage(arg_9_1)
		ReduxFactory.GetInstance():ClearCacheViews()
		LuaForUtil.RefreshI18NText(manager.ui.uiMain)
		LuaForUtil.RefreshI18NText(manager.ui.dontDestroyCanvas)
	end
end

function var_0_0.DeployGameSetting(arg_10_0, arg_10_1)
	if arg_10_0 == "allData" then
		for iter_10_0, iter_10_1 in pairs(arg_10_1) do
			var_0_0.ChangeSingleGameSetting(iter_10_0, iter_10_1)
		end
	else
		var_0_0.ChangeSingleGameSetting(arg_10_0, arg_10_1)
	end
end

function var_0_0.ChangeSingleGameSetting(arg_11_0, arg_11_1)
	if arg_11_0 == "adapter_value" then
		ReduxView.VIEW_ADAPT_DISTANCE = arg_11_1

		local var_11_0 = gameContext:GetAllOpenPage()

		for iter_11_0, iter_11_1 in pairs(var_11_0) do
			if iter_11_1.AdaptScreen then
				iter_11_1:AdaptScreen()
			end
		end

		if manager.managerInit and manager.windowBar:IsInited() then
			manager.windowBar:AdaptScreen()
		end
	end
end

function var_0_0.ExchangeCode(arg_12_0, arg_12_1)
	local var_12_0 = PlayerData:GetPlayerInfo()
	local var_12_1 = var_12_0.userID .. "_" .. var_12_0.signUserId

	GameToSDK.ExChangeGiftCode(var_12_1, arg_12_0)
	print("ExchangeCode:" .. var_12_1)
	SetForceShowQuanquan(true)
end

function OnExchangeCodeCallBack(arg_13_0, arg_13_1)
	if arg_13_0 then
		print("Lua OnExchangeCodeCallBack Success")
	else
		print("Lua OnExchangeCodeCallBack" .. arg_13_1)
	end

	SetForceShowQuanquan(false)
	manager.notify:CallUpdateFunc(ON_EXCHANGE_CODE, arg_13_0, arg_13_1)
end

GameToSDK.RegisterGiftCodeResultEvent(OnExchangeCodeCallBack)

return var_0_0
