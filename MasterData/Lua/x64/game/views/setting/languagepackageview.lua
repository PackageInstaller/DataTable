local LanguagePackageView = class("LanguagePackageView", ReduxView)

function LanguagePackageView:UIName()
	return "Widget/System/Setting/LanguagePackageUI"
end

function LanguagePackageView:UIParent()
	return manager.ui.uiPop.transform
end

function LanguagePackageView:OnCtor()
	return
end

function LanguagePackageView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.listGo_, LanguagePackageItem)
end

function LanguagePackageView:AddUIListener()
	self:AddBtnListenerScale(self.yesBtn_, nil, function()
		JumpTools.Back()
	end)
end

function LanguagePackageView:Init()
	self:InitUI()
	self:AddUIListener()
end

function LanguagePackageView:InitTextLanguageOption()
	if #AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].language_in_list < 2 then
		self.languageBtn_.enabled = false

		SetActive(self.languageIconGo_, false)
	else
		self.languageBtn_.enabled = true

		SetActive(self.languageIconGo_, true)
	end
end

function LanguagePackageView:indexItem(arg_9_1, arg_9_2)
	arg_9_2:RefreshData(VoiceLanguageCfg[AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list[arg_9_1]], self.params_.needSetParent)
end

function LanguagePackageView:RefreshUI()
	self.scrollHelper_:StartScroll(#AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list)

	local var_10_0 = 0

	for iter_10_0 = 1, #AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list do
		if VoicePackageManager.Instance:IsHavePackage(VoiceLanguageCfg[AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list[iter_10_0]].affix) then
			var_10_0 = var_10_0 + AssetPendDownLoadManager.instance:GetVoicePackageSize(VoiceLanguageCfg[AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list[iter_10_0]].affix)
		end
	end

	self.numberText_.text = string.format("%.2fMB", var_10_0)
end

function LanguagePackageView:OnDownloaded(arg_11_1)
	self:RefreshUI()
end

function LanguagePackageView:OnLanguagePackageDeleted()
	self:RefreshUI()
end

function LanguagePackageView:OnEnter()
	self:RefreshUI()
	self:SetParent()
end

function LanguagePackageView:OnExit()
	return
end

function LanguagePackageView:SetParent()
	if self.params_.needSetParent then
		self.transform_:SetParent(manager.ui.uiStory.transform)
	else
		self.transform_:SetParent(self:UIParent())
	end
end

function LanguagePackageView:Dispose()
	self.scrollHelper_:Dispose()

	self.params_ = nil

	LanguagePackageView.super.Dispose(self)
end

function LanguagePackageView:OnAssetPendDownloadEnd(arg_17_1, arg_17_2)
	if arg_17_2 then
		self:RefreshUI()
	end
end

return LanguagePackageView
