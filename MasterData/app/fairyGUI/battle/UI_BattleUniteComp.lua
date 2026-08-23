local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2hcfpm"

function var_0_0:__ctor()
	self.m_proComp = self:getChild("proComp")
	self.m_skillComp1 = self:getChild("skillComp1")
	self.m_skillComp2 = self:getChild("skillComp2")
	self.m_skillComp3 = self:getChild("skillComp3")
	self.m_skillComp4 = self:getChild("skillComp4")
	self.m_combineBg = self:getChild("combineBg")
	self.m_uniteNumberText = self:getChild("uniteNumberText")
	self.m_effPro = self:getChild("effPro")
	self.m_tipPlaceHolder = self:getChild("tipPlaceHolder")
	self.m_refreshTransition = self:getTransition("refresh")
	self.m_fullTransition = self:getTransition("full")
end

return var_0_0
