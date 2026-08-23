local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepx35i1emigaq"

function var_0_0:__ctor()
	self.m_isLockController = self:getController("isLock")
	self.m_knightComp = self:getChild("knightComp")
	self.m_artifactComp = self:getChild("artifactComp")
	self.m_effDadComp = self:getChild("effDadComp")
end

var_0_0.IsLockCtrl = {
	lock = 1,
	normal = 0
}

return var_0_0
