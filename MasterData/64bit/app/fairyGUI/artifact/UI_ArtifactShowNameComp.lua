local var_0_0 = {}

var_0_0.URL = "ui://nhmdbbcvdq869"

function var_0_0:__ctor()
	self.m_urStageAddController = self:getController("urStageAdd")
	self.m_quality = self:getChild("quality")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_starComp = self:getChild("starComp")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_spiritComp = self:getChild("spiritComp")
end

return var_0_0
