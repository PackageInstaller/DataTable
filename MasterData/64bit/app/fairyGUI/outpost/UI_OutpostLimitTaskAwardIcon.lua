local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5yxwex7fd"

function var_0_0:__ctor()
	self.m_isShowEffController = self:getController("isShowEff")
	self.m_icon = self:getChild("icon")
	self.m_effNode = self:getChild("effNode")
end

return var_0_0
