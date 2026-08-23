local var_0_0 = {}

var_0_0.URL = "ui://nhmdbbcvdxwhgic3j"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_skillDescTxt = self:getChild("skillDescTxt")
	self.m_starUpList = self:getChild("starUpList")
end

return var_0_0
