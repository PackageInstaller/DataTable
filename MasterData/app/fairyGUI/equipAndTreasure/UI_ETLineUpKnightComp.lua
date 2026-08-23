local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7osjs13"

function var_0_0:__ctor()
	self.m_lineUpController = self:getController("lineUp")
	self.m_knightCell1 = self:getChild("knightCell1")
	self.m_knightCell2 = self:getChild("knightCell2")
	self.m_knightCell3 = self:getChild("knightCell3")
	self.m_knightCell4 = self:getChild("knightCell4")
	self.m_knightCell5 = self:getChild("knightCell5")
	self.m_knightCell6 = self:getChild("knightCell6")
	self.m_backLoader = self:getChild("backLoader")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.LineUpCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
