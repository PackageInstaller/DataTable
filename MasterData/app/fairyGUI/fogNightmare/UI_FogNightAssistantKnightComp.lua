local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88od4e5rrm7"

function var_0_0:__ctor()
	self.m_hasKnightController = self:getController("hasKnight")
	self.m_qualityLine = self:getChild("qualityLine")
	self.m_knightLoader = self:getChild("knightLoader")
	self.m_knightStarComp = self:getChild("knightStarComp")
	self.m_knightNameText = self:getChild("knightNameText")
	self.m_indexText = self:getChild("indexText")
end

var_0_0.HasKnightCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
