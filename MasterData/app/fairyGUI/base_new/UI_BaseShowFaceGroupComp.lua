local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepu4kmwkk32y"

function var_0_0:__ctor()
	self.m_eff = self:getChild("eff")
	self.m_titleNameComp = self:getChild("titleNameComp")
	self.m_icon = self:getChild("icon")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
