local var_0_0 = {}

var_0_0.URL = "ui://1b29hdofjaqt4z"

function var_0_0:__ctor()
	self.m_picIcon = self:getChild("picIcon")
	self.m_closeTouchPanel = self:getChild("closeTouchPanel")
	self.m_rechargeItem1 = self:getChild("rechargeItem1")
	self.m_rechargeItem2 = self:getChild("rechargeItem2")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
