local var_0_0 = class("CaptureSettingModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/Module/Setting/CaptureSettingModule")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.staticCtx = {
		rotateControlle = arg_3_0.rotateToggleController_:GetController("default0"),
		cardController = arg_3_0.cardToggleController_:GetController("default0"),
		levelController = arg_3_0.levelToggleController_:GetController("default0"),
		uidController = arg_3_0.uidToggleController_:GetController("default0")
	}
	arg_3_0.dropDownText_ = {
		GetTips("LEFT_TOP"),
		GetTips("LEFT_BOTTOM"),
		GetTips("RIGHT_TOP"),
		(GetTips("RIGHT_BOTTOM"))
	}

	arg_3_0:InitDropdownData()
	arg_3_0:AddListener()
end

function var_0_0.AddListener(arg_4_0)
	arg_4_0:AddToggleListener(arg_4_0.showLevelToggle_, function(arg_5_0)
		CaptureGameSettingData:SetNeedLevelState(arg_5_0)
		arg_4_0.staticCtx.levelController:SetSelectedState(arg_5_0 and "on" or "off")
	end)
	arg_4_0:AddToggleListener(arg_4_0.showUidToggle_, function(arg_6_0)
		CaptureGameSettingData:SetNeedUidState(arg_6_0)
		arg_4_0.staticCtx.uidController:SetSelectedState(arg_6_0 and "on" or "off")
	end)
	arg_4_0:AddToggleListener(arg_4_0.rotateHeroToggle_, function(arg_7_0)
		CaptureGameSettingData:SetRotModelState(arg_7_0)
		arg_4_0.staticCtx.rotateControlle:SetSelectedState(arg_7_0 and "on" or "off")
	end)
	arg_4_0:AddToggleListener(arg_4_0.showCardToggle_, function(arg_8_0)
		CaptureGameSettingData:SetNeedPlayerNameState(arg_8_0)
		arg_4_0.staticCtx.cardController:SetSelectedState(arg_8_0 and "on" or "off")
	end)
	arg_4_0:AddToggleListener(arg_4_0.dropDownLogo_, function(arg_9_0)
		if arg_4_0.dropDownCard_.value == arg_9_0 then
			if arg_9_0 == 0 then
				arg_4_0.dropDownCard_.value = 1
			else
				arg_4_0.dropDownCard_.value = 0
			end
		end

		CaptureGameSettingData:SetLogoPos(arg_9_0)
		arg_4_0:RefreshDropDownOptions(arg_4_0.dropDownLogo_)
	end)
	arg_4_0:AddToggleListener(arg_4_0.dropDownCard_, function(arg_10_0)
		if arg_4_0.dropDownLogo_.value == arg_10_0 then
			if arg_10_0 == 0 then
				arg_4_0.dropDownLogo_.value = 1
			else
				arg_4_0.dropDownLogo_.value = 0
			end
		end

		CaptureGameSettingData:SetCardPos(arg_10_0)
		arg_4_0:RefreshDropDownOptions(arg_4_0.dropDownCard_)
	end)
end

function var_0_0.OnEnter(arg_11_0)
	SetActive(arg_11_0.gameObject_, true)
	arg_11_0:RenderSettingView()
end

function var_0_0.RenderSettingView(arg_12_0)
	arg_12_0.showLevelToggle_.isOn = CaptureGameSettingData:CheckNeedLevel()
	arg_12_0.rotateHeroToggle_.isOn = CaptureGameSettingData:CheckCanRotateModel()
	arg_12_0.showCardToggle_.isOn = CaptureGameSettingData:CheckNeedPlayerName()
	arg_12_0.showUidToggle_.isOn = CaptureGameSettingData:CheckNeedUid()
	arg_12_0.dropDownLogo_.value = CaptureGameSettingData:GetLogoPos()
	arg_12_0.dropDownCard_.value = CaptureGameSettingData:GetCardPos()
end

function var_0_0.InitDropdownData(arg_13_0)
	local var_13_0 = "<color=#FFFFFF>%s</color>"

	arg_13_0.dropDownLogo_.itemText.color = Color.New(0, 0, 0, 1)
	arg_13_0.dropDownCard_.itemText.color = Color.New(0, 0, 0, 1)

	local var_13_1 = GetTips("LEFT_TOP")

	arg_13_0.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_13_0, var_13_1), nil))
	arg_13_0.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_13_0, var_13_1), nil))

	local var_13_2 = GetTips("LEFT_BOTTOM")

	arg_13_0.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_13_0, var_13_2), nil))
	arg_13_0.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_13_0, var_13_2), nil))

	local var_13_3 = GetTips("RIGHT_TOP")

	arg_13_0.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_13_0, var_13_3), nil))
	arg_13_0.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_13_0, var_13_3), nil))

	local var_13_4 = GetTips("RIGHT_BOTTOM")

	arg_13_0.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_13_0, var_13_4), nil))
	arg_13_0.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_13_0, var_13_4), nil))
	arg_13_0:RefreshDropDownOptions(arg_13_0.dropDownLogo_)
	arg_13_0:RefreshDropDownOptions(arg_13_0.dropDownCard_)
end

function var_0_0.RefreshDropDownOptions(arg_14_0, arg_14_1)
	local var_14_0 = "<color=#FFFFFF>%s</color>"
	local var_14_1 = arg_14_1.options.Count

	for iter_14_0 = 1, var_14_1 do
		if iter_14_0 - 1 == arg_14_1.value then
			arg_14_1.options[iter_14_0 - 1].text = arg_14_0.dropDownText_[iter_14_0]
		else
			arg_14_1.options[iter_14_0 - 1].text = string.format(var_14_0, arg_14_0.dropDownText_[iter_14_0])
		end
	end
end

function var_0_0.OnExit(arg_15_0)
	SetActive(arg_15_0.gameObject_, false)
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.staticCtx.rotateControlle = nil
	arg_16_0.staticCtx.cardController = nil
	arg_16_0.staticCtx.uidController = nil
	arg_16_0.staticCtx.levelController = nil

	arg_16_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
