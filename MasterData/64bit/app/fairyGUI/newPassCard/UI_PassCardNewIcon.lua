local var_0_0 = {}

var_0_0.URL = "ui://gc6wunfkh36u1s"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_iconComp = self:getChild("iconComp")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_numTxt = self:getChild("numTxt")
end

return var_0_0
