local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9w9w2z0"

function var_0_0:__ctor()
	self.m_activityCompDad = self:getChild("activityCompDad")
	self.m_tabList = self:getChild("tabList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
