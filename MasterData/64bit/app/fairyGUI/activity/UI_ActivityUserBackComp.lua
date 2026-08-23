local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wqlxuji"

function var_0_0:__ctor()
	self.m_signUpBtn = self:getChild("signUpBtn")
	self.m_giftBagBtn = self:getChild("giftBagBtn")
	self.m_recruitBtn = self:getChild("recruitBtn")
	self.m_resourceBtn = self:getChild("resourceBtn")
	self.m_artifactBtn = self:getChild("artifactBtn")
	self.m_timeText = self:getChild("timeText")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
