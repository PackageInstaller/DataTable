local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6p7pmkk38r"

function var_0_0:__ctor()
	self.m_plateComp = self:getChild("plateComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_jumpShopBtn = self:getChild("jumpShopBtn")
	self.m_probBtn = self:getChild("probBtn")
	self.m_probText = self:getChild("probText")
	self.m_progressComp = self:getChild("progressComp")
	self.m_turnOnceBtn = self:getChild("turnOnceBtn")
	self.m_turnFiveBtn = self:getChild("turnFiveBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
