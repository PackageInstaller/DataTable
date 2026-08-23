local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oadkwrrng"

function var_0_0:__ctor()
	self.m_hidePlusController = self:getController("hidePlus")
	self.m_rightDevelopComp = self:getChild("rightDevelopComp")
	self.m_knightComp = self:getChild("knightComp")
	self.m_effectCompPlay = self:getChild("effectCompPlay")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HidePlusCtrl = {
	show = 0,
	hide = 1
}

return var_0_0
