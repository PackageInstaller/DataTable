local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52wn6q6ar"

function var_0_0:__ctor()
	self.m_popPanel = self:getChild("popPanel")
	self.m_awardList = self:getChild("awardList")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
