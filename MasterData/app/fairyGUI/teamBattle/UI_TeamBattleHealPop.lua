local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8ld8jo4k"

function var_0_0:__ctor()
	self.m_eff = self:getChild("eff")
	self.m_title = self:getChild("title")
	self.m_descTxt = self:getChild("descTxt")
	self.m_hurtList = self:getChild("hurtList")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_healBtn = self:getChild("healBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
