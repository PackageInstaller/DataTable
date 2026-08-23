local var_0_0 = {}

var_0_0.URL = "ui://fl8ril81t9w02q"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_groupController = self:getController("group")
	self.m_openController = self:getController("open")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_lvUpBtn = self:getChild("lvUpBtn")
	self.m_costBg = self:getChild("costBg")
	self.m_costComp = self:getChild("costComp")
	self.m_lvUpDescTxt = self:getChild("lvUpDescTxt")
	self.m_activeBtn = self:getChild("activeBtn")
	self.m_starComp2 = self:getChild("starComp2")
	self.m_attrList = self:getChild("attrList")
	self.m_artifactLoader = self:getChild("artifactLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_starComp = self:getChild("starComp")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
