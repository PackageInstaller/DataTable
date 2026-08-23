local var_0_0 = {}

var_0_0.URL = "ui://3jnmvl3poe4flgichx"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_recruitTwentyBtn = self:getChild("recruitTwentyBtn")
	self.m_uniteTokenBtn1 = self:getChild("uniteTokenBtn1")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_mustGetGroup = self:getChild("mustGetGroup")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
