local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ullw08t"

function var_0_0:__ctor()
	self.m_cardNumController = self:getController("cardNum")
	self.m_card5 = self:getChild("card5")
	self.m_card4 = self:getChild("card4")
	self.m_card3 = self:getChild("card3")
	self.m_card1 = self:getChild("card1")
	self.m_card2 = self:getChild("card2")
	self.m_switch1Transition = self:getTransition("switch1")
	self.m_switch2Transition = self:getTransition("switch2")
	self.m_switch3Transition = self:getTransition("switch3")
	self.m_switch4Transition = self:getTransition("switch4")
	self.m_switch5Transition = self:getTransition("switch5")
end

return var_0_0
