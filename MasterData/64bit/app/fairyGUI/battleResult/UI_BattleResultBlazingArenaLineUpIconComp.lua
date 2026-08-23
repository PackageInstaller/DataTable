local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkv3rkmibyu"

function var_0_0:__ctor()
	self.m_lineUpStateController = self:getController("lineUpState")
	self.m_isDieController = self:getController("isDie")
	self.m_iconComp = self:getChild("iconComp")
end

return var_0_0
