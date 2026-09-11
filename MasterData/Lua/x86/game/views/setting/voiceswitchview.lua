local VoiceSwitchView = class("VoiceSwitchView", ReduxView)

function VoiceSwitchView:UIName()
	return "Widget/System/Setting/GameVoiceUI"
end

function VoiceSwitchView:UIParent()
	return manager.ui.uiPop.transform
end

function VoiceSwitchView:OnCtor()
	return
end

function VoiceSwitchView:Init()
	self:InitUI()
	self:AddUIListener()
end

function VoiceSwitchView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.listGo_, VoiceSwitchItem)
end

function VoiceSwitchView:OnEnter()
	self.settingData_ = SettingData:GetSoundSettingData().voice_language

	self:RefreshUI()
end

function VoiceSwitchView:AddUIListener()
	self:AddBtnListenerScale(self.yesBtn_, nil, function()
		self:SaveData()
		JumpTools.Back()
	end)
	self:AddBtnListenerScale(self.noBtn_, nil, function()
		JumpTools.Back()
	end)
end

function VoiceSwitchView:indexItem(arg_10_1, arg_10_2)
	arg_10_2:RefreshData(VoiceLanguageCfg[AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list[arg_10_1]])
end

function VoiceSwitchView:RefreshUI()
	self.scrollHelper_:StartScroll(#AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list)

	local var_11_0 = 0

	for iter_11_0 = 1, #AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list do
		if VoicePackageManager.Instance:IsHavePackage(VoiceLanguageCfg[AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list[iter_11_0]].affix) then
			var_11_0 = var_11_0 + AssetPendDownLoadManager.instance:GetVoicePackageSize(VoiceLanguageCfg[AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list[iter_11_0]].affix)
		end
	end

	self.numberText_.text = string.format("%.2fMB", var_11_0)
end

function VoiceSwitchView:OnGameVoiceSettingChange(arg_12_1)
	self.settingData_ = arg_12_1
end

function VoiceSwitchView:SaveData()
	SettingAction.ChangeSoundSetting("voice_language", self.settingData_)
end

function VoiceSwitchView:OnDownloaded(arg_14_1)
	self:RefreshUI()
end

function VoiceSwitchView:OnLanguagePackageDeleted()
	self:RefreshUI()
end

function VoiceSwitchView:OnExit()
	return
end

function VoiceSwitchView:Dispose()
	self.scrollHelper_:Dispose()

	self.params_ = nil

	VoiceSwitchView.super.Dispose(self)
end

function VoiceSwitchView:OnAssetPendDownloadEnd(arg_18_1, arg_18_2)
	if arg_18_2 then
		self:RefreshUI()
	end
end

return VoiceSwitchView
