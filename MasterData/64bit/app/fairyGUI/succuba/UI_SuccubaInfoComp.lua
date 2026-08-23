local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1nc3mj"

function var_0_0:__ctor()
	self.m_lvText = self:getChild("lvText")
	self.m_attrComp1 = self:getChild("attrComp1")
	self.m_attrComp2 = self:getChild("attrComp2")
	self.m_attrComp3 = self:getChild("attrComp3")
	self.m_attrComp4 = self:getChild("attrComp4")
	self.m_attrComp5 = self:getChild("attrComp5")
	self.m_skillIcon1 = self:getChild("skillIcon1")
	self.m_skillNameText1 = self:getChild("skillNameText1")
	self.m_skillDescText1 = self:getChild("skillDescText1")
	self.m_skillGroup1 = self:getChild("skillGroup1")
	self.m_skillIcon2 = self:getChild("skillIcon2")
	self.m_skillNameText2 = self:getChild("skillNameText2")
	self.m_skillDescText2 = self:getChild("skillDescText2")
	self.m_skillGroup2 = self:getChild("skillGroup2")
	self.m_skillIcon3 = self:getChild("skillIcon3")
	self.m_skillNameText3 = self:getChild("skillNameText3")
	self.m_skillDescText3 = self:getChild("skillDescText3")
	self.m_skillGroup3 = self:getChild("skillGroup3")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_advanceTransition = self:getTransition("advance")
end

return var_0_0
