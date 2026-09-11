local PureModeSettingPopView = class("PureModeSettingPopView", ReduxView)

function PureModeSettingPopView:UIName()
	return "Widget/System/Main/DesktopPopUI"
end

function PureModeSettingPopView:UIParent()
	return manager.ui.uiPop.transform
end

function PureModeSettingPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function PureModeSettingPopView:InitUI()
	self:BindCfgUI()

	self.randomModeController = self.controllerEx_:GetController("randomMode")

	self:InitDropdownData()

	self.randomRangeToggleList_ = {}

	for iter_4_0 = 1, 2 do
		table.insert(self.randomRangeToggleList_, self["randomRangeToggle_" .. iter_4_0])
	end

	self.randomTimeToggleList_ = {}

	for iter_4_1 = 1, 3 do
		self["randomTimeText_" .. iter_4_1].text = manager.time:GetLostTimeStr(GameSetting.random_skin_time.value[iter_4_1] + manager.time:GetServerTime(), true)

		table.insert(self.randomTimeToggleList_, self["randomTimeToggle_" .. iter_4_1])
	end

	self.pureModeTimeToggleList_ = {}

	for iter_4_2 = 1, 3 do
		self["pureModeTimeText_" .. iter_4_2].text = manager.time:GetLostTimeStr(GameSetting.pure_mode_entry_time.value[iter_4_2] + manager.time:GetServerTime(), true)

		table.insert(self.pureModeTimeToggleList_, self["pureModeTimeToggle_" .. iter_4_2])
	end
end

function PureModeSettingPopView:InitDropdownData()
	self.dropDown_.options:Clear()
	self.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("PURE_MODE_RANDOM_MODE_NAME1"), nil))
	self.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("PURE_MODE_RANDOM_MODE_NAME2"), nil))
	self.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("PURE_MODE_RANDOM_MODE_NAME3"), nil))
	self.dropDown_:RefreshShownValue()
end

function PureModeSettingPopView:AddUIListeners()
	self:AddToggleListener(self.dropDown_, function(arg_7_0)
		self:RefreshRandomMode(arg_7_0)
	end)

	for iter_6_0, iter_6_1 in ipairs(self.randomRangeToggleList_) do
		self:AddToggleListener(iter_6_1, function(arg_8_0)
			if arg_8_0 then
				self.randomModeRangeIndex = iter_6_0
			end
		end)
	end

	for iter_6_2, iter_6_3 in ipairs(self.randomTimeToggleList_) do
		self:AddToggleListener(iter_6_3, function(arg_9_0)
			if arg_9_0 then
				self.randomTimeIndex = iter_6_2
			end
		end)
	end

	for iter_6_4, iter_6_5 in ipairs(self.pureModeTimeToggleList_) do
		self:AddToggleListener(iter_6_5, function(arg_10_0)
			if arg_10_0 then
				self.pureModeTimeIndex = iter_6_4
			end
		end)
	end

	self:AddBtnListener(self.yesBtn_, nil, function()
		SDKTools.SendMessageToSDK("activity_sys_edit", {
			sys_id = 101,
			content = "homepage_heroshow_desk",
			type = self.randomModeIndex + 1,
			other_data = string.format("{random_type:%d,change_speed:%d}", self.randomModeRangeIndex, GameSetting.random_skin_time.value[self.randomTimeIndex] / 60),
			task_time = GameSetting.pure_mode_entry_time.value[self.pureModeTimeIndex] / 60
		})
		PlayerAction.SetPureModeSetting({
			randomModeIndex = self.randomModeIndex,
			randomModeRangeIndex = self.randomModeRangeIndex,
			randomTimeIndex = self.randomTimeIndex,
			pureModeTimeIndex = self.pureModeTimeIndex
		}, function()
			JumpTools.Back()
		end)
	end)
	self:AddBtnListener(self.noBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.editorBtn_, nil, function()
		manager.notify:Invoke(PURE_MODE_EDITOR, true)
		JumpTools.Back()
	end)
end

function PureModeSettingPopView:OnEnter()
	self.pureModeSettingData = PlayerData:GetPureModeData()

	self:RefreshRandomMode(self.pureModeSettingData.randomModeIndex)

	self.randomModeRangeIndex = self.pureModeSettingData.randomModeRangeIndex
	self.randomRangeToggleList_[self.randomModeRangeIndex].isOn = true
	self.randomTimeIndex = self.pureModeSettingData.randomTimeIndex
	self.randomTimeToggleList_[self.randomTimeIndex].isOn = true
	self.pureModeTimeIndex = self.pureModeSettingData.pureModeTimeIndex
	self.pureModeTimeToggleList_[self.pureModeTimeIndex].isOn = true
end

function PureModeSettingPopView:RefreshRandomMode(arg_16_1)
	self.dropDown_:SetValueWithoutNotify(arg_16_1)

	self.randomModeIndex = arg_16_1

	if self.randomModeIndex == 0 then
		self.randomModeController:SetSelectedState("hide")
	elseif self.randomModeIndex == 1 then
		self.randomModeController:SetSelectedState("show")
	elseif self.randomModeIndex == 2 then
		self.randomModeController:SetSelectedState("show")
	end
end

return PureModeSettingPopView
