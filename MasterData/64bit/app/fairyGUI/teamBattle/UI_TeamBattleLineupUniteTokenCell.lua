local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkpbi8y"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_qualityBgLoader = self:getChild("qualityBgLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_featureText = self:getChild("featureText")
	self.m_stateText = self:getChild("stateText")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
