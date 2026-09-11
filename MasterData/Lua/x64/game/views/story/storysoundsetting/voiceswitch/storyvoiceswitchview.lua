local StoryVoiceSwitchView = class("StoryVoiceSwitchView", ReduxView)

function StoryVoiceSwitchView:UIName()
	return "Widget/System/Setting/GameVoiceUI"
end

function StoryVoiceSwitchView:UIParent()
	return manager.ui.uiStory.transform
end

function StoryVoiceSwitchView:OnCtor()
	return
end

function StoryVoiceSwitchView:Init()
	self:InitUI()
	self:AddUIListener()
end

function StoryVoiceSwitchView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.listGo_, StoryVoiceSwitchItem)
end

function StoryVoiceSwitchView:OnEnter()
	self.settingData_ = self.params_.voiceLanguage

	self:RefreshUI()
end

function StoryVoiceSwitchView:AddUIListener()
	self:AddBtnListenerScale(self.yesBtn_, nil, function()
		self:SaveData()
		JumpTools.Back()
	end)
	self:AddBtnListenerScale(self.noBtn_, nil, function()
		JumpTools.Back()
	end)
end

function StoryVoiceSwitchView:indexItem(arg_10_1, arg_10_2)
	arg_10_2:RefreshData(VoiceLanguageCfg[AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list[arg_10_1]], self.params_.voiceLanguage)
end

function StoryVoiceSwitchView:RefreshUI()
	self.scrollHelper_:StartScroll(#AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list)

	local var_11_0 = 0

	for iter_11_0 = 1, #AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list do
		if VoicePackageManager.Instance:IsHavePackage(VoiceLanguageCfg[AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list[iter_11_0]].affix) then
			var_11_0 = var_11_0 + AssetPendDownLoadManager.instance:GetVoicePackageSize(VoiceLanguageCfg[AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list[iter_11_0]].affix)
		end
	end

	self.numberText_.text = string.format("%.2fMB", var_11_0)
end

function StoryVoiceSwitchView:OnGameVoiceSettingChange(arg_12_1)
	self.settingData_ = arg_12_1
end

function StoryVoiceSwitchView:SaveData()
	SettingData:SetStoryVoiceLanguageCache(self.settingData_)
	manager.notify:Invoke(STORY_SWITCH_VOICE_LANGUAGE, self.settingData_)
end

function StoryVoiceSwitchView:OnDownloaded(arg_14_1)
	self:RefreshUI()
end

function StoryVoiceSwitchView:OnLanguagePackageDeleted()
	self:RefreshUI()
end

function StoryVoiceSwitchView:OnExit()
	return
end

function StoryVoiceSwitchView:Dispose()
	self.scrollHelper_:Dispose()

	self.params_ = nil

	StoryVoiceSwitchView.super.Dispose(self)
end

return StoryVoiceSwitchView
