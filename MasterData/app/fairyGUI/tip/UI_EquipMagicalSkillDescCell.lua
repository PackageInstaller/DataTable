local var_0_0 = {}

var_0_0.URL = "ui://sap1qcktek02frer"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_levelText = self:getChild("levelText")
	self.m_descText = self:getChild("descText")
end

return var_0_0
