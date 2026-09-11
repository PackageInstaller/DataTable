local GuildRequestSettingView = class("GuildRequestSettingView", ReduxView)

function GuildRequestSettingView:UIName()
	return "Widget/System/Club/ClubApplicationsettingsPopUI"
end

function GuildRequestSettingView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildRequestSettingView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function GuildRequestSettingView:OnEnter()
	local var_4_0 = GuildData:GetGuildInfo()

	self[string.format("toggle%d_", tonumber(var_4_0.reviewFlag))].isOn = true
	self.reviewFlag_ = var_4_0.reviewFlag
	self.curNum = var_4_0.limitLevel or GameSetting.club_default_level_limit.value[1]

	self:RefreshView()
end

function GuildRequestSettingView:RefreshView()
	self.inputFieldLevel_.text = self.curNum
	self.levelText.text = self.curNum
	self.reduceNumBtn_.interactable = self.curNum > GameSetting.club_default_level_limit.value[1]
	self.addNumBtn_.interactable = self.curNum < GameSetting.user_level_max.value[1]
end

function GuildRequestSettingView:OnExit()
	return
end

function GuildRequestSettingView:Dispose()
	self.inputFieldLevel_.onEndEdit:RemoveAllListeners()
	GuildRequestSettingView.super.Dispose(self)
end

function GuildRequestSettingView:AddListeners()
	self:AddBtnListener(self.buttonClose_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buttonCancel_, nil, function()
		self:Back()
	end)
	self:AddPressingByTimeListener(self.reduceNumBtn_.gameObject, 3, 0.5, 0.5, function()
		self.curNum = Mathf.Clamp(self.curNum - 1, GameSetting.club_default_level_limit.value[1], GameSetting.user_level_max.value[1])

		self:RefreshView()

		return true
	end)
	self:AddPressingByTimeListener(self.addNumBtn_.gameObject, 3, 0.5, 0.5, function()
		self.curNum = Mathf.Clamp(self.curNum + 1, GameSetting.club_default_level_limit.value[1], GameSetting.user_level_max.value[1])

		self:RefreshView()

		return true
	end)
	self:AddBtnListener(self.buttonOk_, nil, function()
		if self.inputFieldLevel_.text ~= "" then
			if self.inputFieldLevel_.text == "-" then
				self.inputFieldLevel_.text = GuildData:GetGuildInfo().limitLevel
			end
		end

		local var_13_0 = tonumber(self.inputFieldLevel_.text)

		if var_13_0 < GameSetting.club_default_level_limit.value[1] then
			var_13_0 = GameSetting.club_default_level_limit.value[1]
		end

		if var_13_0 > GameSetting.user_level_max.value[1] then
			var_13_0 = GameSetting.user_level_max.value[1]
		end

		GuildAction.GuildRequestSetting(self.reviewFlag_, var_13_0, function(arg_14_0)
			if isSuccess(arg_14_0.result) then
				ShowTips("CLUB_SAVE_SETTING")
				GuildData:SetGuildSetting(self.reviewFlag_, var_13_0)
				self:Back()
			else
				ShowTips(arg_14_0.result)
			end
		end)
	end)
	self.inputFieldLevel_.onEndEdit:AddListener(function()
		if self.inputFieldLevel_.text ~= "" then
			if self.inputFieldLevel_.text == "-" then
				self.inputFieldLevel_.text = GuildData:GetGuildInfo().limitLevel

				goto label_15_0
			end
		end

		self.inputFieldLevel_.text = Mathf.Clamp(tonumber(self.inputFieldLevel_.text), GameSetting.club_default_level_limit.value[1], GameSetting.user_level_max.value[1])

		::label_15_0::

		self.curNum = tonumber(self.inputFieldLevel_.text)
		self.levelText.text = self.curNum
	end)
	self:AddBtnListener(self.btnmaxBtn_, nil, function()
		self.curNum = GameSetting.user_level_max.value[1]

		self:RefreshView()
	end)

	for iter_8_0 = 1, 3 do
		self:AddToggleListener(self[string.format("toggle%d_", iter_8_0)], function(arg_17_0)
			if arg_17_0 then
				self.reviewFlag_ = iter_8_0
			end
		end)
	end
end

return GuildRequestSettingView
