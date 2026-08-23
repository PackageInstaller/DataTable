local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5116r75x"

function var_0_0:__ctor()
	self.m_selIndexController = self:getController("selIndex")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_buildInfoComp = self:getChild("buildInfoComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_recipeList = self:getChild("recipeList")
	self.m_shelfList = self:getChild("shelfList")
	self.m_knightList = self:getChild("knightList")
	self.m_tempCell = self:getChild("tempCell")
	self.m_guideBtn = self:getChild("guideBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_cellOutTransition = self:getTransition("cellOut")
end

return var_0_0
