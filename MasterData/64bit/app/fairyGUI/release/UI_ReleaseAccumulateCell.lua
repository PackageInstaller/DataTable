local var_0_0 = {}

var_0_0.URL = "ui://ltl1fuv2mg6n1e"

function var_0_0:__ctor()
	self.m_isFirstController = self:getController("isFirst")
	self.m_stateController = self:getController("state")
	self.m_numTxt = self:getChild("numTxt")
	self.m_icon = self:getChild("icon")
	self.m_drawCountTxt = self:getChild("drawCountTxt")
	self.m_progBarComp = self:getChild("progBarComp")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_eff = self:getChild("eff")
end

return var_0_0
