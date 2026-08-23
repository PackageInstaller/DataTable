local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oadkwrrnn"

function var_0_0:__ctor()
	self.m_buttonController = self:getController("button")
	self.m_stateController = self:getController("state")
	self.m_qualityBgLoader = self:getChild("qualityBgLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_stateText = self:getChild("stateText")
	self.m_featureText = self:getChild("featureText")
	self.m_skillIcon = self:getChild("skillIcon")
end

var_0_0.ButtonCtrl = {
	up = 0,
	down = 1
}
var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
