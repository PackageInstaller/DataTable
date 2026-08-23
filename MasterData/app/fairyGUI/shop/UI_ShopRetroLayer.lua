local var_0_0 = {}

var_0_0.URL = "ui://454a48jpt7iz14bnnlp"

function var_0_0:__ctor()
	self.m_childComp = self:getChild("childComp")
	self.m_timeComp = self:getChild("timeComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
