local var_0_0 = {}

var_0_0.URL = "ui://e2ymx4waxfgb1l"

function var_0_0:__ctor()
	self.m_showUpTipController = self:getController("showUpTip")
	self.m_icon = self:getChild("icon")
	self.m_upBg = self:getChild("upBg")
	self.m_upText = self:getChild("upText")
	self.m_numText = self:getChild("numText")
end

return var_0_0
