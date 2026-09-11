local HeroTrammelsSwitchNetItem = class("HeroTrammelsSwitchNetItem", ReduxView)

function HeroTrammelsSwitchNetItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index = arg_1_2

	SetActive(self.gameObject_, true)
	self:Init()
end

function HeroTrammelsSwitchNetItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroTrammelsSwitchNetItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.indexController = ControllerUtil.GetController(self.transform_, "index")

	self.indexController:SetSelectedIndex(self.index - 1)
end

function HeroTrammelsSwitchNetItem:AddUIListener()
	self:AddBtnListener(nil, self.m_btn, function()
		if self.callback_ then
			self.callback_(self.index)
		end
	end)
end

function HeroTrammelsSwitchNetItem:SetData(arg_6_1)
	self.stateController:SetSelectedIndex(arg_6_1)
end

function HeroTrammelsSwitchNetItem:RegistCallBack(arg_7_1)
	self.callback_ = arg_7_1
end

return HeroTrammelsSwitchNetItem
