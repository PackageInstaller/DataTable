local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oddqk9rrsa"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_effSuit = self:getChild("effSuit")
	self.m_activeIcon1 = self:getChild("activeIcon1")
	self.m_activeIcon2 = self:getChild("activeIcon2")
	self.m_activeIcon3 = self:getChild("activeIcon3")
	self.m_activeIcon4 = self:getChild("activeIcon4")
	self.m_numText = self:getChild("numText")
end

var_0_0.IsActiveCtrl = {
	active = 1,
	none = 0
}

return var_0_0
