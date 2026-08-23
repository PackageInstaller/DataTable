local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1abvq3p"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_isLockController = self:getController("isLock")
	self.m_midIcon = self:getChild("midIcon")
	self.m_topIcon = self:getChild("topIcon")
end

var_0_0.TypeCtrl = {
	skin = 2,
	knight = 0,
	pet = 4,
	uniteToken = 1,
	artifact = 3
}
var_0_0.IsLockCtrl = {
	lock = 1,
	normal = 0
}

return var_0_0
