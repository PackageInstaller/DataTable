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
	up = 0,
	down = 1
}
var_0_0.IsEmptyCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.CanLineUpCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsLockCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsEquipCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
