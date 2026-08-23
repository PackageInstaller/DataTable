local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgd85e5ibht"

function var_0_0:__ctor()
	self.m_bannerComp = self:getChild("bannerComp")
	self.m_showAssistBtn = self:getChild("showAssistBtn")
	self.m_changeAssistBtn = self:getChild("changeAssistBtn")
	self.m_nextAssistBtn = self:getChild("nextAssistBtn")
	self.m_chatBtn = self:getChild("chatBtn")
	self.m_changeRedPointComp = self:getChild("changeRedPointComp")
	self.m_h5SpList = self:getChild("h5SpList")
	self.m_outTransition = self:getTransition("out")
	self.m_inTransition = self:getTransition("in")
	self.m_out2Transition = self:getTransition("out2")
end

return var_0_0
