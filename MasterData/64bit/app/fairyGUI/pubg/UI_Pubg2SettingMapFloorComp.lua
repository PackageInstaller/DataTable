local var_0_0 = {}

var_0_0.URL = "ui://pbd24silex4r7f"

function var_0_0:__ctor()
	self.m_renderHolder = self:getChild("renderHolder")
	self.m_lineRoot = self:getChild("lineRoot")
	self.m_triangleMeshRoot = self:getChild("triangleMeshRoot")
	self.m_settingHolder = self:getChild("settingHolder")
	self.m_effectHolder = self:getChild("effectHolder")
	self.m_fogHolder = self:getChild("fogHolder")
	self.m_levelBanHolder = self:getChild("levelBanHolder")
end

return var_0_0
