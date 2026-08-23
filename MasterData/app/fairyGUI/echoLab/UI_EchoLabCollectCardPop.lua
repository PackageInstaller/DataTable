local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1abvq3s"

function var_0_0:__ctor()
	self.m_clickNode = self:getChild("clickNode")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_infoComp = self:getChild("infoComp")
	self.m_title = self:getChild("title")
	self.m_nameComp = self:getChild("nameComp")
	self.m_lvUpEffHolder = self:getChild("lvUpEffHolder")
	self.m_normalState = self:getChild("normalState")
end

return var_0_0
