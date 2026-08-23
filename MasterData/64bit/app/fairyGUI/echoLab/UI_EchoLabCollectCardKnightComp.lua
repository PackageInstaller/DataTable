local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1abvq3p"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_isLockController = self:getController("isLock")
	self.m_midIcon = self:getChild("midIcon")
	self.m_topIcon = self:getChild("topIcon")
end

var_0_0.TypeCtrl = {
	pet = 4,
	artifact = 3,
	skin = 2,
	uniteToken = 1,
	knight = 0
}
var_0_0.IsLockCtrl = {
	normal = 0,
	lock = 1
}

return var_0_0
