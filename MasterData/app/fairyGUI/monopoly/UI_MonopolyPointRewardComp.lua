local var_0_0 = {}

var_0_0.URL = "ui://6b52cxc1oky98x"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isLastController = self:getController("isLast")
	self.m_progressImg = self:getChild("progressImg")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_numTxt = self:getChild("numTxt")
	self.m_eff = self:getChild("eff")
end

return var_0_0
