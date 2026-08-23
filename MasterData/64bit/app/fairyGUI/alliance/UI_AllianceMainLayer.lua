local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcjye20"

function var_0_0:__ctor()
	self.m_bgComp = self:getChild("bgComp")
	self.m_flag = self:getChild("flag")
	self.m_allianceName = self:getChild("allianceName")
	self.m_allianceLevel = self:getChild("allianceLevel")
	self.m_warZoneBtn = self:getChild("warZoneBtn")
	self.m_mergeTipsBtn = self:getChild("mergeTipsBtn")
	self.m_chat = self:getChild("chat")
	self.m_sendBoxBtn = self:getChild("sendBoxBtn")
	self.m_openBoxBtn = self:getChild("openBoxBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
