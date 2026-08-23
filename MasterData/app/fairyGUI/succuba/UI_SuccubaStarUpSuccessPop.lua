local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1nc3mn"

function var_0_0:__ctor()
	self.m_bgComp = self:getChild("bgComp")
	self.m_spineHolder = self:getChild("spineHolder")
	self.m_effPlaceHolder = self:getChild("effPlaceHolder")
	self.m_starComp = self:getChild("starComp")
	self.m_effStarHolder = self:getChild("effStarHolder")
	self.m_attrComp1 = self:getChild("attrComp1")
	self.m_attrComp2 = self:getChild("attrComp2")
	self.m_attrComp3 = self:getChild("attrComp3")
	self.m_attrComp4 = self:getChild("attrComp4")
	self.m_attrComp5 = self:getChild("attrComp5")
	self.m_skillIcon1 = self:getChild("skillIcon1")
	self.m_skillLvText1 = self:getChild("skillLvText1")
	self.m_skillGroup1 = self:getChild("skillGroup1")
	self.m_skillIcon2 = self:getChild("skillIcon2")
	self.m_skillLvText2 = self:getChild("skillLvText2")
	self.m_skillGroup2 = self:getChild("skillGroup2")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
