local var_0_0 = {}

var_0_0.URL = "ui://pbd24sil7en825"

function var_0_0:__ctor()
	self.m_grassHolder = self:getChild("grassHolder")
	self.m_mountainAndBuildHolder = self:getChild("mountainAndBuildHolder")
	self.m_buffHolder = self:getChild("buffHolder")
	self.m_effectHolder = self:getChild("effectHolder")
	self.m_levelBanHolder = self:getChild("levelBanHolder")
	self.m_fogHolder = self:getChild("fogHolder")
end

return var_0_0
