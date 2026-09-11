local CaptureSettingModule = class("CaptureSettingModule", ReduxView)

function CaptureSettingModule:OnCtor(arg_1_1)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/Module/Setting/CaptureSettingModule"), arg_1_1)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CaptureSettingModule:Init()
	self:InitUI()
end

function CaptureSettingModule:InitUI()
	self:BindCfgUI()

	self.staticCtx = {
		rotateControlle = self.rotateToggleController_:GetController("default0"),
		cardController = self.cardToggleController_:GetController("default0"),
		levelController = self.levelToggleController_:GetController("default0"),
		uidController = self.uidToggleController_:GetController("default0")
	}
	self.dropDownText_ = {
		GetTips("LEFT_TOP"),
		GetTips("LEFT_BOTTOM"),
		GetTips("RIGHT_TOP"),
		(GetTips("RIGHT_BOTTOM"))
	}

	self:InitDropdownData()
	self:AddListener()
end

function CaptureSettingModule:AddListener()
	self:AddToggleListener(self.showLevelToggle_, function(arg_5_0)
		CaptureGameSettingData:SetNeedLevelState(arg_5_0)
		self.staticCtx.levelController:SetSelectedState(arg_5_0 and "on" or "off")
	end)
	self:AddToggleListener(self.showUidToggle_, function(arg_6_0)
		CaptureGameSettingData:SetNeedUidState(arg_6_0)
		self.staticCtx.uidController:SetSelectedState(arg_6_0 and "on" or "off")
	end)
	self:AddToggleListener(self.rotateHeroToggle_, function(arg_7_0)
		CaptureGameSettingData:SetRotModelState(arg_7_0)
		self.staticCtx.rotateControlle:SetSelectedState(arg_7_0 and "on" or "off")
	end)
	self:AddToggleListener(self.showCardToggle_, function(arg_8_0)
		CaptureGameSettingData:SetNeedPlayerNameState(arg_8_0)
		self.staticCtx.cardController:SetSelectedState(arg_8_0 and "on" or "off")
	end)
	self:AddToggleListener(self.dropDownLogo_, function(arg_9_0)
		if self.dropDownCard_.value == arg_9_0 then
			self.dropDownCard_.value = arg_9_0 == 0 and 1 or 0
		end

		CaptureGameSettingData:SetLogoPos(arg_9_0)
		self:RefreshDropDownOptions(self.dropDownLogo_)
	end)
	self:AddToggleListener(self.dropDownCard_, function(arg_10_0)
		if self.dropDownLogo_.value == arg_10_0 then
			self.dropDownLogo_.value = arg_10_0 == 0 and 1 or 0
		end

		CaptureGameSettingData:SetCardPos(arg_10_0)
		self:RefreshDropDownOptions(self.dropDownCard_)
	end)
end

function CaptureSettingModule:OnEnter()
	SetActive(self.gameObject_, true)
	self:RenderSettingView()
end

function CaptureSettingModule:RenderSettingView()
	self.showLevelToggle_.isOn = CaptureGameSettingData:CheckNeedLevel()
	self.rotateHeroToggle_.isOn = CaptureGameSettingData:CheckCanRotateModel()
	self.showCardToggle_.isOn = CaptureGameSettingData:CheckNeedPlayerName()
	self.showUidToggle_.isOn = CaptureGameSettingData:CheckNeedUid()
	self.dropDownLogo_.value = CaptureGameSettingData:GetLogoPos()
	self.dropDownCard_.value = CaptureGameSettingData:GetCardPos()
end

function CaptureSettingModule:InitDropdownData()
	self.dropDownLogo_.itemText.color = Color.New(0, 0, 0, 1)
	self.dropDownCard_.itemText.color = Color.New(0, 0, 0, 1)

	local var_13_0 = GetTips("LEFT_TOP")

	self.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", var_13_0), nil))
	self.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", var_13_0), nil))

	local var_13_1 = GetTips("LEFT_BOTTOM")

	self.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", var_13_1), nil))
	self.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", var_13_1), nil))

	local var_13_2 = GetTips("RIGHT_TOP")

	self.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", var_13_2), nil))
	self.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", var_13_2), nil))

	local var_13_3 = GetTips("RIGHT_BOTTOM")

	self.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", var_13_3), nil))
	self.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", var_13_3), nil))
	self:RefreshDropDownOptions(self.dropDownLogo_)
	self:RefreshDropDownOptions(self.dropDownCard_)
end

function CaptureSettingModule:RefreshDropDownOptions(arg_14_1)
	for iter_14_0 = 1, arg_14_1.options.Count do
		arg_14_1.options[iter_14_0 - 1].text = iter_14_0 - 1 == arg_14_1.value and self.dropDownText_[iter_14_0] or string.format("<color=#FFFFFF>%s</color>", self.dropDownText_[iter_14_0])
	end
end

function CaptureSettingModule:OnExit()
	SetActive(self.gameObject_, false)
end

function CaptureSettingModule:Dispose()
	self.staticCtx.rotateControlle = nil
	self.staticCtx.cardController = nil
	self.staticCtx.uidController = nil
	self.staticCtx.levelController = nil

	self:RemoveAllListeners()
	CaptureSettingModule.super.Dispose(self)
end

return CaptureSettingModule
