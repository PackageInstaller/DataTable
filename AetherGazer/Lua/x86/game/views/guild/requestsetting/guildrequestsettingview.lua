local var_0_0 = class("GuildRequestSettingView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club/ClubApplicationsettingsPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	local var_4_0 = GuildData:GetGuildInfo()

	arg_4_0[string.format("toggle%d_", tonumber(var_4_0.reviewFlag))].isOn = true
	arg_4_0.reviewFlag_ = var_4_0.reviewFlag

	local var_4_1 = GameSetting.club_default_level_limit.value[1]
	local var_4_2 = GameSetting.user_level_max.value[1]

	arg_4_0.curNum = var_4_0.limitLevel or var_4_1

	arg_4_0:RefreshView()
end

function var_0_0.RefreshView(arg_5_0)
	arg_5_0.inputFieldLevel_.text = arg_5_0.curNum
	arg_5_0.levelText.text = arg_5_0.curNum
	arg_5_0.reduceNumBtn_.interactable = arg_5_0.curNum > GameSetting.club_default_level_limit.value[1]
	arg_5_0.addNumBtn_.interactable = arg_5_0.curNum < GameSetting.user_level_max.value[1]
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.inputFieldLevel_.onEndEdit:RemoveAllListeners()
	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.buttonClose_, nil, function()
		arg_8_0:Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonCancel_, nil, function()
		arg_8_0:Back()
	end)
	arg_8_0:AddPressingByTimeListener(arg_8_0.reduceNumBtn_.gameObject, 3, 0.5, 0.5, function()
		arg_8_0.curNum = Mathf.Clamp(arg_8_0.curNum - 1, GameSetting.club_default_level_limit.value[1], GameSetting.user_level_max.value[1])

		arg_8_0:RefreshView()

		return true
	end)
	arg_8_0:AddPressingByTimeListener(arg_8_0.addNumBtn_.gameObject, 3, 0.5, 0.5, function()
		arg_8_0.curNum = Mathf.Clamp(arg_8_0.curNum + 1, GameSetting.club_default_level_limit.value[1], GameSetting.user_level_max.value[1])

		arg_8_0:RefreshView()

		return true
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonOk_, nil, function()
		if arg_8_0.inputFieldLevel_.text == "" or arg_8_0.inputFieldLevel_.text == "-" then
			local var_13_0 = GuildData:GetGuildInfo()

			arg_8_0.inputFieldLevel_.text = var_13_0.limitLevel
		end

		local var_13_1 = tonumber(arg_8_0.inputFieldLevel_.text)
		local var_13_2 = GameSetting.club_default_level_limit.value[1]

		if var_13_1 < var_13_2 then
			var_13_1 = var_13_2
		end

		if var_13_1 > GameSetting.user_level_max.value[1] then
			var_13_1 = GameSetting.user_level_max.value[1]
		end

		GuildAction.GuildRequestSetting(arg_8_0.reviewFlag_, var_13_1, function(arg_14_0)
			if isSuccess(arg_14_0.result) then
				ShowTips("CLUB_SAVE_SETTING")
				GuildData:SetGuildSetting(arg_8_0.reviewFlag_, var_13_1)
				arg_8_0:Back()
			else
				ShowTips(arg_14_0.result)
			end
		end)
	end)
	arg_8_0.inputFieldLevel_.onEndEdit:AddListener(function()
		if arg_8_0.inputFieldLevel_.text == "" or arg_8_0.inputFieldLevel_.text == "-" then
			local var_15_0 = GuildData:GetGuildInfo()

			arg_8_0.inputFieldLevel_.text = var_15_0.limitLevel
		else
			arg_8_0.inputFieldLevel_.text = Mathf.Clamp(tonumber(arg_8_0.inputFieldLevel_.text), GameSetting.club_default_level_limit.value[1], GameSetting.user_level_max.value[1])
		end

		arg_8_0.curNum = tonumber(arg_8_0.inputFieldLevel_.text)
		arg_8_0.levelText.text = arg_8_0.curNum
	end)
	arg_8_0:AddBtnListener(arg_8_0.btnmaxBtn_, nil, function()
		arg_8_0.curNum = GameSetting.user_level_max.value[1]

		arg_8_0:RefreshView()
	end)

	for iter_8_0 = 1, 3 do
		arg_8_0:AddToggleListener(arg_8_0[string.format("toggle%d_", iter_8_0)], function(arg_17_0)
			if arg_17_0 then
				arg_8_0.reviewFlag_ = iter_8_0
			end
		end)
	end
end

return var_0_0
