local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2hcfpk"

function var_0_0:__ctor()
	self.m_btnTypeController = self:getController("btnType")
	self.m_lockController = self:getController("lock")
	self.m_iconLoader = self:getChild("iconLoader")
end

var_0_0.BtnTypeCtrl = {
	skip = 5,
	autoSel = 4,
	autoUnSel = 3,
	["speed*3"] = 2,
	["speed*1"] = 1,
	pause = 0
}
var_0_0.LockCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
