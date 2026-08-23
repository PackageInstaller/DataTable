local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkxd0cl"

function var_0_0:__ctor()
	self.m_roleTypeController = self:getController("roleType")
	self.m_bigScaleController = self:getController("bigScale")
	self.m_isDebuffController = self:getController("isDebuff")
	self.m_isOnlineController = self:getController("isOnline")
	self.m_isBlackController = self:getController("isBlack")
	self.m_isLockController = self:getController("isLock")
	self.m_effectDown = self:getChild("effectDown")
	self.m_knightNode = self:getChild("knightNode")
	self.m_nameText = self:getChild("nameText")
	self.m_hpBar = self:getChild("hpBar")
	self.m_fightText = self:getChild("fightText")
	self.m_battleLoader = self:getChild("battleLoader")
	self.m_buffIcon1 = self:getChild("buffIcon1")
	self.m_buffGroup1 = self:getChild("buffGroup1")
	self.m_buffIcon2 = self:getChild("buffIcon2")
	self.m_buffGroup2 = self:getChild("buffGroup2")
	self.m_effectUp = self:getChild("effectUp")
	self.m_guardComp = self:getChild("guardComp")
	self.m_limitTimeText = self:getChild("limitTimeText")
	self.m_eventComp = self:getChild("eventComp")
	self.m_effRoleUp = self:getChild("effRoleUp")
	self.m_upTransition = self:getTransition("up")
	self.m_showTransition = self:getTransition("show")
	self.m_hideTransition = self:getTransition("hide")
	self.m_showEndTransition = self:getTransition("showEnd")
	self.m_hideEndTransition = self:getTransition("hideEnd")
end

var_0_0.RoleTypeCtrl = {
	other = 3,
	eventNpc = 5,
	mine = 1,
	guard = 4,
	monster = 0
}
var_0_0.BigScaleCtrl = {
	normal = 0,
	big = 1
}
var_0_0.IsDebuffCtrl = {
	normal = 0,
	buff = 1
}
var_0_0.IsOnlineCtrl = {
	online = 0,
	offline = 1
}
var_0_0.IsBlackCtrl = {
	normal = 0,
	black = 1
}
var_0_0.IsLockCtrl = {
	normal = 0,
	lock = 1
}

return var_0_0
