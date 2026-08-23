local var_0_0 = {}

var_0_0.URL = "ui://3jnmvl3pw34kgic1m"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_stoneController = self:getController("stone")
	self.m_downEffHolder = self:getChild("downEffHolder")
	self.m_shaderIcon = self:getChild("shaderIcon")
	self.m_upEffHolder = self:getChild("upEffHolder")
end

return var_0_0
