local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfib932a"

function var_0_0:__ctor()
	self.m_popPanel = self:getChild("popPanel")
	self.m_rewardList = self:getChild("rewardList")
	self.m_tabList = self:getChild("tabList")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
