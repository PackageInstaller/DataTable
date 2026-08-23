local var_0_0 = {}

var_0_0.URL = "ui://9n9qtghbr0u2mibwa"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_qualityBgLoader = self:getChild("qualityBgLoader")
	self.m_petIconLoader = self:getChild("petIconLoader")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_starComp = self:getChild("starComp")
	self.m_nameText = self:getChild("nameText")
	self.m_stageText = self:getChild("stageText")
end

return var_0_0
