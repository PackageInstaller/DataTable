local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lgy5p8g"

function var_0_0:__ctor()
	self.m_hasKnightController = self:getController("hasKnight")
	self.m_addBtn = self:getChild("addBtn")
	self.m_knightLoader = self:getChild("knightLoader")
	self.m_starGroupComp = self:getChild("starGroupComp")
	self.m_leftQualityLoader = self:getChild("leftQualityLoader")
	self.m_elementLoader = self:getChild("elementLoader")
end

var_0_0.HasKnightCtrl = {
	has = 1,
	normal = 0
}

return var_0_0
