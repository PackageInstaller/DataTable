local var_0_0 = {}

var_0_0.URL = "ui://lpxuu9tapaws0"

function var_0_0:__ctor()
	self.m_hasGiftController = self:getController("hasGift")
	self.m_closePnl = self:getChild("closePnl")
	self.m_rightComp = self:getChild("rightComp")
	self.m_leftComp = self:getChild("leftComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
