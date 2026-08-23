local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1p5qx42"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_starComp = self:getChild("starComp")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_lappingIcon = self:getChild("lappingIcon")
	self.m_lappingValueTxt = self:getChild("lappingValueTxt")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
