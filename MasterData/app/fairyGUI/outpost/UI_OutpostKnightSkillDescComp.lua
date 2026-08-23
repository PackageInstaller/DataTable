local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5sih57f6"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_isHasArtifactRelatedController = self:getController("isHasArtifactRelated")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_descText = self:getChild("descText")
	self.m_relatedDesc = self:getChild("relatedDesc")
	self.m_relatedGroup = self:getChild("relatedGroup")
	self.m_descList = self:getChild("descList")
	self.m_skillGroup = self:getChild("skillGroup")
end

return var_0_0
