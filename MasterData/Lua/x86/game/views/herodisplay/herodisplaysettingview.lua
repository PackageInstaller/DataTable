local HeroDisplaySettingView = class("HeroDisplaySettingView", ReduxView)

function HeroDisplaySettingView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.dropDownText_ = {
		GetTips("LEFT_TOP"),
		GetTips("LEFT_BOTTOM"),
		GetTips("RIGHT_TOP"),
		(GetTips("RIGHT_BOTTOM"))
	}
	self.cardController_ = self.cardControllerEx_:GetController("default0")
	self.levelController_ = self.levelControllerEx_:GetController("default0")
	self.uidController_ = self.uidControllerEx_:GetController("default0")
	self.actionController_ = self.actionControllerEx_:GetController("default0")
	self.color_ = Color.New(0.372549, 0.372549, 0.372549, 1)
	self.bgColor_ = Color.New(0.8862746, 0.8862746, 0.8862746, 1)
	self.checkmarkColor_ = Color.New(0.2980392, 0.3490196, 0.4156863, 1)

	self:InitDropdownData()
end

function HeroDisplaySettingView:InitDropdownData()
	self.dropDownLogo_.itemText.color = Color.New(0, 0, 0, 1)
	self.dropDownCard_.itemText.color = Color.New(0, 0, 0, 1)

	local var_2_0 = GetTips("LEFT_TOP")

	self.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", var_2_0), nil))
	self.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", var_2_0), nil))

	local var_2_1 = GetTips("LEFT_BOTTOM")

	self.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", var_2_1), nil))
	self.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", var_2_1), nil))

	local var_2_2 = GetTips("RIGHT_TOP")

	self.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", var_2_2), nil))
	self.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", var_2_2), nil))

	local var_2_3 = GetTips("RIGHT_BOTTOM")

	self.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", var_2_3), nil))
	self.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", var_2_3), nil))
	self:RefreshDropDownOptions(self.dropDownLogo_)
	self:RefreshDropDownOptions(self.dropDownCard_)
end

function HeroDisplaySettingView:RefreshDropDownOptions(arg_3_1)
	for iter_3_0 = 1, arg_3_1.options.Count do
		arg_3_1.options[iter_3_0 - 1].text = iter_3_0 - 1 == arg_3_1.value and self.dropDownText_[iter_3_0] or string.format("<color=#FFFFFF>%s</color>", self.dropDownText_[iter_3_0])
	end
end

function HeroDisplaySettingView:OnEnter()
	local var_4_0 = HeroDisplayData:GetSetting()

	self.dropDownLogo_.value = var_4_0.logoPos
	self.toggleCard_.isOn = var_4_0.cardShow
	self.dropDownCard_.value = var_4_0.cardPos
	self.toggleLevel_.isOn = var_4_0.cardShowLv
	self.toggleUID_.isOn = var_4_0.cardShowUID

	self:RefreshInteractable(var_4_0.cardShow)
end

function HeroDisplaySettingView:RefreshInteractable(arg_5_1)
	self.dropDownCard_.interactable = arg_5_1
	self.toggleLevel_.interactable = arg_5_1
	self.toggleUID_.interactable = arg_5_1

	if arg_5_1 then
		self.imageUID2_.color = self.checkmarkColor_
		self.imageLv2_.color = self.checkmarkColor_
	else
		self.imageUID2_.color = self.color_
		self.imageLv2_.color = self.color_
	end
end

function HeroDisplaySettingView:OnExit()
	return
end

function HeroDisplaySettingView:Dispose()
	HeroDisplaySettingView.super.Dispose(self)
end

function HeroDisplaySettingView:AddListeners()
	self:AddBtnListener(self.buttonCancel_, nil, function()
		self:OnExit()
		SetActive(self.gameObject_, false)
	end)
	self:AddBtnListener(self.buttonOk_, nil, function()
		HeroDisplayData:SaveSetting({
			logoPos = self.dropDownLogo_.value,
			cardShow = self.toggleCard_.isOn,
			cardPos = self.dropDownCard_.value,
			cardShowLv = self.toggleLevel_.isOn,
			cardShowUID = self.toggleUID_.isOn
		})
		self:OnExit()
		SetActive(self.gameObject_, false)
	end)
	self:AddToggleListener(self.dropDownLogo_, function(arg_11_0)
		if self.dropDownCard_.value == arg_11_0 then
			self.dropDownCard_.value = arg_11_0 == 0 and 1 or 0
		end

		self:RefreshDropDownOptions(self.dropDownLogo_)
	end)
	self:AddToggleListener(self.dropDownCard_, function(arg_12_0)
		if self.dropDownLogo_.value == arg_12_0 then
			self.dropDownLogo_.value = arg_12_0 == 0 and 1 or 0
		end

		self:RefreshDropDownOptions(self.dropDownCard_)
	end)
	self:AddToggleListener(self.toggleCard_, function(arg_13_0)
		self:RefreshInteractable(arg_13_0)
		self.cardController_:SetSelectedIndex(arg_13_0 and 1 or 0)
	end)
	self:AddToggleListener(self.toggleLevel_, function(arg_14_0)
		self.levelController_:SetSelectedIndex(arg_14_0 and 1 or 0)
	end)
	self:AddToggleListener(self.toggleUID_, function(arg_15_0)
		self.uidController_:SetSelectedIndex(arg_15_0 and 1 or 0)
	end)
	self:AddToggleListener(self.toggleAction_, function(arg_16_0)
		self.actionController_:SetSelectedIndex(arg_16_0 and 1 or 0)
	end)
end

return HeroDisplaySettingView
