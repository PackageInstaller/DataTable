local var_0_0 = {}

var_0_0.URL = "ui://3w60uerptdy22"

function var_0_0:__ctor()
	self.m_showStateController = self:getController("showState")
	self.m_iconComp = self:getChild("iconComp")
	self.m_lockTip = self:getChild("lockTip")
end

return var_0_0
