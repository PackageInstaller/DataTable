local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5t5x82c"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_lineUpNumTxt = self:getChild("lineUpNumTxt")
	self.m_changeLineUpBtn = self:getChild("changeLineUpBtn")
	self.m_lineUpBtn = self:getChild("lineUpBtn")
	self.m_knightList = self:getChild("knightList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
