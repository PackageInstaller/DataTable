local var_0_0 = {}

var_0_0.URL = "ui://pbd24sil7en82c"

function var_0_0:__ctor()
	self.m_buffTypeController = self:getController("buffType")
	self.m_bg = self:getChild("bg")
	self.m_effRefresh = self:getChild("effRefresh")
	self.m_effGet = self:getChild("effGet")
	self.m_refreshTransition = self:getTransition("refresh")
	self.m_getTransition = self:getTransition("get")
	self.m_resetTransition = self:getTransition("reset")
end

return var_0_0
