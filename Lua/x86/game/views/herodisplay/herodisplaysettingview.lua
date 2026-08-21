local var_0_0 = class("HeroDisplaySettingView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.dropDownText_ = {
		GetTips("LEFT_TOP"),
		GetTips("LEFT_BOTTOM"),
		GetTips("RIGHT_TOP"),
		(GetTips("RIGHT_BOTTOM"))
	}
	arg_1_0.cardController_ = arg_1_0.cardControllerEx_:GetController("default0")
	arg_1_0.levelController_ = arg_1_0.levelControllerEx_:GetController("default0")
	arg_1_0.uidController_ = arg_1_0.uidControllerEx_:GetController("default0")
	arg_1_0.actionController_ = arg_1_0.actionControllerEx_:GetController("default0")
	arg_1_0.color_ = Color.New(0.372549, 0.372549, 0.372549, 1)
	arg_1_0.bgColor_ = Color.New(0.8862746, 0.8862746, 0.8862746, 1)
	arg_1_0.checkmarkColor_ = Color.New(0.2980392, 0.3490196, 0.4156863, 1)

	arg_1_0:InitDropdownData()
end

function var_0_0.InitDropdownData(arg_2_0)
	local var_2_0 = "<color=#FFFFFF>%s</color>"

	arg_2_0.dropDownLogo_.itemText.color = Color.New(0, 0, 0, 1)
	arg_2_0.dropDownCard_.itemText.color = Color.New(0, 0, 0, 1)

	local var_2_1 = GetTips("LEFT_TOP")

	arg_2_0.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_2_0, var_2_1), nil))
	arg_2_0.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_2_0, var_2_1), nil))

	local var_2_2 = GetTips("LEFT_BOTTOM")

	arg_2_0.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_2_0, var_2_2), nil))
	arg_2_0.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_2_0, var_2_2), nil))

	local var_2_3 = GetTips("RIGHT_TOP")

	arg_2_0.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_2_0, var_2_3), nil))
	arg_2_0.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_2_0, var_2_3), nil))

	local var_2_4 = GetTips("RIGHT_BOTTOM")

	arg_2_0.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_2_0, var_2_4), nil))
	arg_2_0.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_2_0, var_2_4), nil))
	arg_2_0:RefreshDropDownOptions(arg_2_0.dropDownLogo_)
	arg_2_0:RefreshDropDownOptions(arg_2_0.dropDownCard_)
end

function var_0_0.RefreshDropDownOptions(arg_3_0, arg_3_1)
	local var_3_0 = "<color=#FFFFFF>%s</color>"
	local var_3_1 = arg_3_1.options.Count

	for iter_3_0 = 1, var_3_1 do
		if iter_3_0 - 1 == arg_3_1.value then
			arg_3_1.options[iter_3_0 - 1].text = arg_3_0.dropDownText_[iter_3_0]
		else
			arg_3_1.options[iter_3_0 - 1].text = string.format(var_3_0, arg_3_0.dropDownText_[iter_3_0])
		end
	end
end

function var_0_0.OnEnter(arg_4_0)
	local var_4_0 = HeroDisplayData:GetSetting()

	arg_4_0.dropDownLogo_.value = var_4_0.logoPos
	arg_4_0.toggleCard_.isOn = var_4_0.cardShow
	arg_4_0.dropDownCard_.value = var_4_0.cardPos
	arg_4_0.toggleLevel_.isOn = var_4_0.cardShowLv
	arg_4_0.toggleUID_.isOn = var_4_0.cardShowUID

	arg_4_0:RefreshInteractable(var_4_0.cardShow)
end

function var_0_0.RefreshInteractable(arg_5_0, arg_5_1)
	arg_5_0.dropDownCard_.interactable = arg_5_1
	arg_5_0.toggleLevel_.interactable = arg_5_1
	arg_5_0.toggleUID_.interactable = arg_5_1

	if arg_5_1 then
		arg_5_0.imageUID2_.color = arg_5_0.checkmarkColor_
		arg_5_0.imageLv2_.color = arg_5_0.checkmarkColor_
	else
		arg_5_0.imageUID2_.color = arg_5_0.color_
		arg_5_0.imageLv2_.color = arg_5_0.color_
	end
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.buttonCancel_, nil, function()
		arg_8_0:OnExit()
		SetActive(arg_8_0.gameObject_, false)
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonOk_, nil, function()
		HeroDisplayData:SaveSetting({
			logoPos = arg_8_0.dropDownLogo_.value,
			cardShow = arg_8_0.toggleCard_.isOn,
			cardPos = arg_8_0.dropDownCard_.value,
			cardShowLv = arg_8_0.toggleLevel_.isOn,
			cardShowUID = arg_8_0.toggleUID_.isOn
		})
		arg_8_0:OnExit()
		SetActive(arg_8_0.gameObject_, false)
	end)
	arg_8_0:AddToggleListener(arg_8_0.dropDownLogo_, function(arg_11_0)
		if arg_8_0.dropDownCard_.value == arg_11_0 then
			if arg_11_0 == 0 then
				arg_8_0.dropDownCard_.value = 1
			else
				arg_8_0.dropDownCard_.value = 0
			end
		end

		arg_8_0:RefreshDropDownOptions(arg_8_0.dropDownLogo_)
	end)
	arg_8_0:AddToggleListener(arg_8_0.dropDownCard_, function(arg_12_0)
		if arg_8_0.dropDownLogo_.value == arg_12_0 then
			if arg_12_0 == 0 then
				arg_8_0.dropDownLogo_.value = 1
			else
				arg_8_0.dropDownLogo_.value = 0
			end
		end

		arg_8_0:RefreshDropDownOptions(arg_8_0.dropDownCard_)
	end)
	arg_8_0:AddToggleListener(arg_8_0.toggleCard_, function(arg_13_0)
		arg_8_0:RefreshInteractable(arg_13_0)
		arg_8_0.cardController_:SetSelectedIndex(arg_13_0 and 1 or 0)
	end)
	arg_8_0:AddToggleListener(arg_8_0.toggleLevel_, function(arg_14_0)
		arg_8_0.levelController_:SetSelectedIndex(arg_14_0 and 1 or 0)
	end)
	arg_8_0:AddToggleListener(arg_8_0.toggleUID_, function(arg_15_0)
		arg_8_0.uidController_:SetSelectedIndex(arg_15_0 and 1 or 0)
	end)
	arg_8_0:AddToggleListener(arg_8_0.toggleAction_, function(arg_16_0)
		arg_8_0.actionController_:SetSelectedIndex(arg_16_0 and 1 or 0)
	end)
end

return var_0_0
