local var_0_0 = {}

var_0_0.URL = "ui://ami25kgymuw9r"

function var_0_0:__ctor()
	self.m_isKnightController = self:getController("isKnight")
	self.m_topBar = self:getChild("topBar")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_knightComp = self:getChild("knightComp")
	self.m_resComp = self:getChild("resComp")
	self.m_rebornBtn = self:getChild("rebornBtn")
	self.m_nameComp = self:getChild("nameComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsKnightCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
