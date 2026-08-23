local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88owbv4fn"

function var_0_0:__ctor()
	self.m_lockController = self:getController("lock")
	self.m_isShowMaskController = self:getController("isShowMask")
	self.m_isBossController = self:getController("isBoss")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_centerIconLoader = self:getChild("centerIconLoader")
	self.m_powerText = self:getChild("powerText")
	self.m_powerGroup = self:getChild("powerGroup")
	self.m_nameBgLoader = self:getChild("nameBgLoader")
	self.m_effectNode = self:getChild("effectNode")
	self.m_nameText = self:getChild("nameText")
	self.m_subMaskLoader = self:getChild("subMaskLoader")
	self.m_maskLoader = self:getChild("maskLoader")
	self.m_maskTransition = self:getTransition("mask")
	self.m_upTransition = self:getTransition("up")
	self.m_downTransition = self:getTransition("down")
end

var_0_0.LockCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsShowMaskCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsBossCtrl = {
	boss = 1,
	normal = 0
}

return var_0_0
