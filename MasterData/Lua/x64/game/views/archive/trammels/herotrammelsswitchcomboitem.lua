local HeroTrammelsSwitchComboItem = class("HeroTrammelsSwitchComboItem", ReduxView)

function HeroTrammelsSwitchComboItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.level = arg_1_2

	self:Init()
end

function HeroTrammelsSwitchComboItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroTrammelsSwitchComboItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.m_lvLab.text = GetTips("LEVEL") .. self.level
end

function HeroTrammelsSwitchComboItem:AddUIListener()
	self:AddBtnListener(nil, self.m_btn, function()
		if self.callback_ then
			self.callback_(self.level)
		end
	end)
end

function HeroTrammelsSwitchComboItem:SetData(arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1 < self.level

	if self.level == arg_6_2 then
		self.stateController:SetSelectedIndex(var_6_0 and 3 or 2)
	else
		self.stateController:SetSelectedIndex(var_6_0 and 0 or 1)
	end
end

function HeroTrammelsSwitchComboItem:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function HeroTrammelsSwitchComboItem:RegistCallBack(arg_8_1)
	self.callback_ = arg_8_1
end

function HeroTrammelsSwitchComboItem:Dispose()
	HeroTrammelsSwitchComboItem.super.Dispose(self)
end

return HeroTrammelsSwitchComboItem
