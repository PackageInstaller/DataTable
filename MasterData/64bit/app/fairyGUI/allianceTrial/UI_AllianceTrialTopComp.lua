local var_0_0 = {}

var_0_0.URL = "ui://whf5j5b58llxz"

function var_0_0:__ctor()
	self.m_stage = self:getChild("stage")
	self.m_level = self:getChild("level")
	self.m_lastTime = self:getChild("lastTime")
	self.m_loaderBtn = self:getChild("loaderBtn")
	self.m_tipText = self:getChild("tipText")
end

return var_0_0
