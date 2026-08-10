local var_0_0 = class("PureModeSettingPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Main/DesktopPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.randomModeController = arg_4_0.controllerEx_:GetController("randomMode")

	arg_4_0:InitDropdownData()

	arg_4_0.randomRangeToggleList_ = {}

	for iter_4_0 = 1, 2 do
		table.insert(arg_4_0.randomRangeToggleList_, arg_4_0["randomRangeToggle_" .. iter_4_0])
	end

	arg_4_0.randomTimeToggleList_ = {}

	for iter_4_1 = 1, 3 do
		arg_4_0["randomTimeText_" .. iter_4_1].text = manager.time:GetLostTimeStr(GameSetting.random_skin_time.value[iter_4_1] + manager.time:GetServerTime(), true)

		table.insert(arg_4_0.randomTimeToggleList_, arg_4_0["randomTimeToggle_" .. iter_4_1])
	end

	arg_4_0.pureModeTimeToggleList_ = {}

	for iter_4_2 = 1, 3 do
		arg_4_0["pureModeTimeText_" .. iter_4_2].text = manager.time:GetLostTimeStr(GameSetting.pure_mode_entry_time.value[iter_4_2] + manager.time:GetServerTime(), true)

		table.insert(arg_4_0.pureModeTimeToggleList_, arg_4_0["pureModeTimeToggle_" .. iter_4_2])
	end
end

function var_0_0.InitDropdownData(arg_5_0)
	arg_5_0.dropDown_.options:Clear()
	arg_5_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("PURE_MODE_RANDOM_MODE_NAME1"), nil))
	arg_5_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("PURE_MODE_RANDOM_MODE_NAME2"), nil))
	arg_5_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("PURE_MODE_RANDOM_MODE_NAME3"), nil))
	arg_5_0.dropDown_:RefreshShownValue()
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddToggleListener(arg_6_0.dropDown_, function(arg_7_0)
		arg_6_0:RefreshRandomMode(arg_7_0)
	end)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.randomRangeToggleList_) do
		arg_6_0:AddToggleListener(iter_6_1, function(arg_8_0)
			if arg_8_0 then
				arg_6_0.randomModeRangeIndex = iter_6_0
			end
		end)
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.randomTimeToggleList_) do
		arg_6_0:AddToggleListener(iter_6_3, function(arg_9_0)
			if arg_9_0 then
				arg_6_0.randomTimeIndex = iter_6_2
			end
		end)
	end

	for iter_6_4, iter_6_5 in ipairs(arg_6_0.pureModeTimeToggleList_) do
		arg_6_0:AddToggleListener(iter_6_5, function(arg_10_0)
			if arg_10_0 then
				arg_6_0.pureModeTimeIndex = iter_6_4
			end
		end)
	end

	arg_6_0:AddBtnListener(arg_6_0.yesBtn_, nil, function()
		SDKTools.SendMessageToSDK("activity_sys_edit", {
			sys_id = 101,
			content = "homepage_heroshow_desk",
			type = arg_6_0.randomModeIndex + 1,
			other_data = string.format("{random_type:%d,change_speed:%d}", arg_6_0.randomModeRangeIndex, GameSetting.random_skin_time.value[arg_6_0.randomTimeIndex] / 60),
			task_time = GameSetting.pure_mode_entry_time.value[arg_6_0.pureModeTimeIndex] / 60
		})

		local var_11_0 = {
			randomModeIndex = arg_6_0.randomModeIndex,
			randomModeRangeIndex = arg_6_0.randomModeRangeIndex,
			randomTimeIndex = arg_6_0.randomTimeIndex,
			pureModeTimeIndex = arg_6_0.pureModeTimeIndex
		}

		PlayerAction.SetPureModeSetting(var_11_0, function()
			JumpTools.Back()
		end)
	end)
	arg_6_0:AddBtnListener(arg_6_0.noBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.editorBtn_, nil, function()
		manager.notify:Invoke(PURE_MODE_EDITOR, true)
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.pureModeSettingData = PlayerData:GetPureModeData()

	arg_15_0:RefreshRandomMode(arg_15_0.pureModeSettingData.randomModeIndex)

	arg_15_0.randomModeRangeIndex = arg_15_0.pureModeSettingData.randomModeRangeIndex
	arg_15_0.randomRangeToggleList_[arg_15_0.randomModeRangeIndex].isOn = true
	arg_15_0.randomTimeIndex = arg_15_0.pureModeSettingData.randomTimeIndex
	arg_15_0.randomTimeToggleList_[arg_15_0.randomTimeIndex].isOn = true
	arg_15_0.pureModeTimeIndex = arg_15_0.pureModeSettingData.pureModeTimeIndex
	arg_15_0.pureModeTimeToggleList_[arg_15_0.pureModeTimeIndex].isOn = true
end

function var_0_0.RefreshRandomMode(arg_16_0, arg_16_1)
	arg_16_0.dropDown_:SetValueWithoutNotify(arg_16_1)

	arg_16_0.randomModeIndex = arg_16_1

	if arg_16_0.randomModeIndex == 0 then
		arg_16_0.randomModeController:SetSelectedState("hide")
	elseif arg_16_0.randomModeIndex == 1 then
		arg_16_0.randomModeController:SetSelectedState("show")
	elseif arg_16_0.randomModeIndex == 2 then
		arg_16_0.randomModeController:SetSelectedState("show")
	end
end

return var_0_0
