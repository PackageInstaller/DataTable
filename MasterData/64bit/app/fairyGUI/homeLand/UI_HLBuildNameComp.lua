local var_0_0 = {}

var_0_0.URL = "ui://3bq41b3bhqs96"

function var_0_0:__ctor()
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_subNameTxt = self:getChild("subNameTxt")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_hlBuildRedPointComp_1 = self:getChild("hlBuildRedPointComp_1")
	self.m_hlBuildRedPointComp_2 = self:getChild("hlBuildRedPointComp_2")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
