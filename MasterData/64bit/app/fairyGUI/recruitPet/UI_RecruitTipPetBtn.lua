local var_0_0 = {}

var_0_0.URL = "ui://3wkhfdlxvzejlgich9"

function var_0_0:__ctor()
	self.m_hideKnightController = self:getController("hideKnight")
	self.m_knightComp = self:getChild("knightComp")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_qualityTextLoader = self:getChild("qualityTextLoader")
	self.m_knightBtnGroup = self:getChild("knightBtnGroup")
end

return var_0_0
