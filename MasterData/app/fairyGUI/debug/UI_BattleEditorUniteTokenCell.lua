local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7ys1tk5ibjn"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_skillComp = self:getChild("skillComp")
	self.m_qualityBgLoader = self:getChild("qualityBgLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_stateText = self:getChild("stateText")
	self.m_featureText = self:getChild("featureText")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
