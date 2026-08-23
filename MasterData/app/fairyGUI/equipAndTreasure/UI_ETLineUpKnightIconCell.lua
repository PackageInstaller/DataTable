local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7osjs14"

function var_0_0:__ctor()
	self.m_buttonController = self:getController("button")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_canLineUpController = self:getController("canLineUp")
	self.m_isLockController = self:getController("isLock")
	self.m_isEquipController = self:getController("isEquip")
	self.m_icon = self:getChild("icon")
	self.m_addPic = self:getChild("addPic")
	self.m_lockText = self:getChild("lockText")
	self.m_lockText_2 = self:getChild("lockText")
end

var_0_0.ButtonCtrl = {
	down = 1,
	up = 0
}
var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.CanLineUpCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsLockCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsEquipCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
