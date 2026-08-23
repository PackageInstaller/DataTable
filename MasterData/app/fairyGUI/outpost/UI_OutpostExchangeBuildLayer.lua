local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5116r73n"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isShowTempController = self:getController("isShowTemp")
	self.m_buildInfoComp = self:getChild("buildInfoComp")
	self.m_itemList = self:getChild("itemList")
	self.m_knightList = self:getChild("knightList")
	self.m_tempCell = self:getChild("tempCell")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_cellOutTransition = self:getTransition("cellOut")
end

return var_0_0
