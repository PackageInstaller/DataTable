local LanguageSwitchView = class("LanguageSwitchView", ReduxView)

function LanguageSwitchView:UIName()
	return "Widget/System/Setting/GameLanguageUI"
end

function LanguageSwitchView:UIParent()
	return manager.ui.uiPop.transform
end

function LanguageSwitchView:OnCtor()
	return
end

function LanguageSwitchView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.listGo_, LanguageSwitchItem)
end

function LanguageSwitchView:AddUIListener()
	self:AddBtnListenerScale(self.yesBtn_, nil, function()
		self:SaveData()
		JumpTools.Back()
	end)
	self:AddBtnListenerScale(self.noBtn_, nil, function()
		JumpTools.Back()
	end)
end

function LanguageSwitchView:Init()
	self:InitUI()
	self:AddUIListener()
end

function LanguageSwitchView:indexItem(arg_9_1, arg_9_2)
	arg_9_2:RefreshData(arg_9_1)
end

function LanguageSwitchView:RefreshUI()
	self.scrollHelper_:StartScroll(#AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].language_in_list)

	self.languageList = {}
end

function LanguageSwitchView:OnGameLanguageSettingChange(arg_11_1)
	self.settingData_ = arg_11_1
end

function LanguageSwitchView:SaveData()
	SettingAction.ChangeSoundSetting("text_language", self.settingData_)
end

function LanguageSwitchView:OnEnter()
	self:RefreshUI()
	self:SetParent()
end

function LanguageSwitchView:OnExit()
	return
end

function LanguageSwitchView:SetParent()
	if self.params_.needSetParent then
		self.transform_:SetParent(manager.ui.uiStory.transform)
	else
		self.transform_:SetParent(self:UIParent())
	end
end

function LanguageSwitchView:Dispose()
	self.scrollHelper_:Dispose()

	self.params_ = nil

	LanguageSwitchView.super.Dispose(self)
end

return LanguageSwitchView
