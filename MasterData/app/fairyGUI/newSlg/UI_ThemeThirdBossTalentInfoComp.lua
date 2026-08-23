local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jgu4969id"

function var_0_0:__ctor()
	self.m_talentTypeController = self:getController("talentType")
	self.m_btnStateController = self:getController("btnState")
	self.m_talentIcon = self:getChild("talentIcon")
	self.m_talentName = self:getChild("talentName")
	self.m_talentDesc = self:getChild("talentDesc")
	self.m_attrList = self:getChild("attrList")
	self.m_resetBtn = self:getChild("resetBtn")
	self.m_resComp = self:getChild("resComp")
	self.m_activeBtn = self:getChild("activeBtn")
	self.m_activeUpBtn = self:getChild("activeUpBtn")
	self.m_activeDownBtn = self:getChild("activeDownBtn")
end

return var_0_0
