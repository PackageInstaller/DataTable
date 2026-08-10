local var_0_0 = class("StoryVoiceSwitchView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Setting/GameVoiceUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiStory.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.scrollHelper_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.listGo_, StoryVoiceSwitchItem)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.settingData_ = arg_6_0.params_.voiceLanguage

	arg_6_0:RefreshUI()
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListenerScale(arg_7_0.yesBtn_, nil, function()
		arg_7_0:SaveData()
		JumpTools.Back()
	end)
	arg_7_0:AddBtnListenerScale(arg_7_0.noBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.indexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list[arg_10_1]

	arg_10_2:RefreshData(VoiceLanguageCfg[var_10_0], arg_10_0.params_.voiceLanguage)
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]
	local var_11_1 = #var_11_0.voice_list

	arg_11_0.scrollHelper_:StartScroll(var_11_1)

	local var_11_2 = 0

	for iter_11_0 = 1, var_11_1 do
		local var_11_3 = var_11_0.voice_list[iter_11_0]
		local var_11_4 = VoiceLanguageCfg[var_11_3]

		if VoicePackageManager.Instance:IsHavePackage(var_11_4.affix) then
			var_11_2 = var_11_2 + AssetPendDownLoadManager.instance:GetVoicePackageSize(var_11_4.affix)
		end
	end

	arg_11_0.numberText_.text = string.format("%.2fMB", var_11_2)
end

function var_0_0.OnGameVoiceSettingChange(arg_12_0, arg_12_1)
	arg_12_0.settingData_ = arg_12_1
end

function var_0_0.SaveData(arg_13_0)
	SettingData:SetStoryVoiceLanguageCache(arg_13_0.settingData_)
	manager.notify:Invoke(STORY_SWITCH_VOICE_LANGUAGE, arg_13_0.settingData_)
end

function var_0_0.OnDownloaded(arg_14_0, arg_14_1)
	arg_14_0:RefreshUI()
end

function var_0_0.OnLanguagePackageDeleted(arg_15_0)
	arg_15_0:RefreshUI()
end

function var_0_0.OnExit(arg_16_0)
	return
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.scrollHelper_:Dispose()

	arg_17_0.params_ = nil

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
