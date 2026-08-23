local var_0_0 = {}

var_0_0.URL = "ui://3w60uerptdy21j"

function var_0_0:__ctor()
	self.m_isShowAwardController = self:getController("isShowAward")
	self.m_rewardTypeController = self:getController("rewardType")
	self.m_award1 = self:getChild("award1")
	self.m_award2 = self:getChild("award2")
	self.m_award3 = self:getChild("award3")
	self.m_award4 = self:getChild("award4")
	self.m_award5 = self:getChild("award5")
	self.m_award6 = self:getChild("award6")
	self.m_award7 = self:getChild("award7")
	self.m_award8 = self:getChild("award8")
	self.m_award9 = self:getChild("award9")
	self.m_award10 = self:getChild("award10")
	self.m_award0 = self:getChild("award0")
	self.m_continueText = self:getChild("continueText")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
