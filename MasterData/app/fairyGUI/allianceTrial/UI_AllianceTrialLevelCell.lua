local var_0_0 = {}

var_0_0.URL = "ui://whf5j5b58llx14"

function var_0_0:__ctor()
	self.m_levelStateController = self:getController("levelState")
	self.m_loader = self:getChild("loader")
	self.m_levelText = self:getChild("levelText")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
