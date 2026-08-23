local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ogd2r9rrrt"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_qualityController = self:getController("quality")
	self.m_petIcon = self:getChild("petIcon")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_starComp = self:getChild("starComp")
	self.m_nameText = self:getChild("nameText")
	self.m_stageText = self:getChild("stageText")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.QualityCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
