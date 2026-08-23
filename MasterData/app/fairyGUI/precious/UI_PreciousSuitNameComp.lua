local var_0_0 = {}

var_0_0.URL = "ui://671qywx2gn4yp"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_starComp = self:getChild("starComp")
	self.m_suitNameTxt = self:getChild("suitNameTxt")
end

return var_0_0
