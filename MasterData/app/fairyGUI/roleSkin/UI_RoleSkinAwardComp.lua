local var_0_0 = {}

var_0_0.URL = "ui://x323b22nje0c1k"

function var_0_0:__ctor()
	self.m_eff = self:getChild("eff")
	self.m_nameComp = self:getChild("nameComp")
	self.m_attrComp1 = self:getChild("attrComp1")
	self.m_attrComp2 = self:getChild("attrComp2")
	self.m_attrComp3 = self:getChild("attrComp3")
	self.m_attrComp4 = self:getChild("attrComp4")
	self.m_roleSkinPic = self:getChild("roleSkinPic")
	self.m_backTransition = self:getTransition("back")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
