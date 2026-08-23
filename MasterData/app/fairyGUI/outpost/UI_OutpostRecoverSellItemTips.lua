local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5lrhf7br"

function var_0_0:__ctor()
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_effNameTxt = self:getChild("effNameTxt")
	self.m_effValueTxt = self:getChild("effValueTxt")
	self.m_priceTitle = self:getChild("priceTitle")
	self.m_priceTxt = self:getChild("priceTxt")
	self.m_timeTitle = self:getChild("timeTitle")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
