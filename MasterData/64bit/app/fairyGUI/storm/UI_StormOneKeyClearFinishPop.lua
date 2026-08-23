local var_0_0 = {}

var_0_0.URL = "ui://arku10fqmmtckk2y1"

function var_0_0:__ctor()
	self.m_popPanel = self:getChild("popPanel")
	self.m_rewardList = self:getChild("rewardList")
	self.m_finishBtn = self:getChild("finishBtn")
	self.m_jumpBtn = self:getChild("jumpBtn")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_boxNode = self:getChild("boxNode")
	self.m_attackerNode = self:getChild("attackerNode")
	self.m_content = self:getChild("content")
	self.m_goAndOpenBoxTransition = self:getTransition("goAndOpenBox")
end

return var_0_0
