local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8ld8jo4s"

function var_0_0:__ctor()
	self.m_eff = self:getChild("eff")
	self.m_title = self:getChild("title")
	self.m_descTxt = self:getChild("descTxt")
	self.m_reviveList = self:getChild("reviveList")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_reviveBtn = self:getChild("reviveBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
