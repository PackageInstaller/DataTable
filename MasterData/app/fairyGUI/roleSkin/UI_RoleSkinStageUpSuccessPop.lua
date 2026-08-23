local var_0_0 = {}

var_0_0.URL = "ui://x323b22nje0c1e"

function var_0_0:__ctor()
	self.m_picLoader = self:getChild("picLoader")
	self.m_nameComp = self:getChild("nameComp")
	self.m_attrComp1 = self:getChild("attrComp1")
	self.m_attrComp2 = self:getChild("attrComp2")
	self.m_attrComp3 = self:getChild("attrComp3")
	self.m_attrComp4 = self:getChild("attrComp4")
	self.m_stage1 = self:getChild("stage1")
	self.m_stage2 = self:getChild("stage2")
	self.m_talentTxt = self:getChild("talentTxt")
	self.m_talentGroup = self:getChild("talentGroup")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
