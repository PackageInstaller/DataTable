local var_0_0 = {}

var_0_0.URL = "ui://3jnmvl3pvb7pgibyr"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_recruitTwentyBtn = self:getChild("recruitTwentyBtn")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_uniteTokenBtn1 = self:getChild("uniteTokenBtn1")
	self.m_uniteTokenBtn2 = self:getChild("uniteTokenBtn2")
	self.m_countDownTxt = self:getChild("countDownTxt")
	self.m_countDown = self:getChild("countDown")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
