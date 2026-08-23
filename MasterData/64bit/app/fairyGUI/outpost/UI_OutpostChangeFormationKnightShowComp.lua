local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5116r73r"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_knightLoader = self:getChild("knightLoader")
	self.m_lineUpBtn = self:getChild("lineUpBtn")
	self.m_lockStrTxt = self:getChild("lockStrTxt")
end

return var_0_0
