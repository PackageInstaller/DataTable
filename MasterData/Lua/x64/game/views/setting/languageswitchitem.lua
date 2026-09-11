local LanguageSwitchItem = class("LanguageSwitchItem", ReduxView)

function LanguageSwitchItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function LanguageSwitchItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = self.comps_:GetController("status")
end

function LanguageSwitchItem:AddUIListener()
	self:AddToggleListener(self.toggle_, function(arg_4_0)
		if arg_4_0 then
			manager.notify:CallUpdateFunc(GAME_LANGUAGE_SETTING, self.info_.language_list[self.index_])
		end
	end)
end

function LanguageSwitchItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function LanguageSwitchItem:Render()
	self:RefreshData(self.index_)
end

function LanguageSwitchItem:RefreshData(arg_7_1)
	if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER] then
		self.info_ = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]
		self.index_ = arg_7_1
		self.nameText_.text = GetI18NText(AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].language_in_list[arg_7_1])

		if SettingData:GetSoundSettingData().text_language == AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].language_list[arg_7_1] then
			self.statusController_:SetSelectedState("in_use")

			self.toggle_.isOn = true
		else
			self.statusController_:SetSelectedState("downloaded")
		end
	end
end

function LanguageSwitchItem:Dispose()
	self.params_ = nil

	LanguageSwitchItem.super.Dispose(self)
end

return LanguageSwitchItem
