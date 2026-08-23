local var_0_0 = {}

var_0_0.URL = "ui://3q06rys8l42a1v"

function var_0_0:__ctor()
	self.m_cntController = self:getController("cnt")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_logo = self:getChild("logo")
	self.m_inviteCode = self:getChild("inviteCode")
	self.m_typeLoader = self:getChild("typeLoader")
	self.m_shareBtn3 = self:getChild("shareBtn3")
	self.m_shareBtn2 = self:getChild("shareBtn2")
	self.m_shareBtn1 = self:getChild("shareBtn1")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
