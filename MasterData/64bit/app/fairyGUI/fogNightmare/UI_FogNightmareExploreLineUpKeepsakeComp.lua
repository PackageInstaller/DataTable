local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oadkwrrnl"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_qualityController = self:getController("quality")
	self.m_keepsakeIcon = self:getChild("keepsakeIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_stateText = self:getChild("stateText")
	self.m_powerText = self:getChild("powerText")
end

var_0_0.StateCtrl = {
	lineUp = 1,
	normal = 0
}
var_0_0.QualityCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
