local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wt0oh2"

function var_0_0:__ctor()
	self.m_iconShadow = self:getChild("iconShadow")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_swichTransition = self:getTransition("swich")
	self.m_reSwichTransition = self:getTransition("reSwich")
end

return var_0_0
