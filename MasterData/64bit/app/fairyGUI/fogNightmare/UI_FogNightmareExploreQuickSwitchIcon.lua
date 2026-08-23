local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oadkwrrnq"

function var_0_0:__ctor()
	self.m_isUnlockController = self:getController("isUnlock")
	self.m_icon = self:getChild("icon")
end

var_0_0.IsUnlockCtrl = {
	lock = 0,
	unlock = 1
}

return var_0_0
