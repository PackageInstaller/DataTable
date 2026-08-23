local var_0_0 = {}

var_0_0.URL = "ui://nz3msl46dngjq"

function var_0_0:__ctor()
	self.m_isTenController = self:getController("isTen")
	self.m_clickEnableController = self:getController("clickEnable")
	self.m_icon = self:getChild("icon")
	self.m_effLoop2 = self:getChild("effLoop2")
	self.m_effLoop10 = self:getChild("effLoop10")
	self.m_effLoop1 = self:getChild("effLoop1")
	self.m_effLoop3 = self:getChild("effLoop3")
	self.m_effLoop4 = self:getChild("effLoop4")
	self.m_effLoop5 = self:getChild("effLoop5")
	self.m_effLoop6 = self:getChild("effLoop6")
	self.m_effLoop7 = self:getChild("effLoop7")
	self.m_effLoop8 = self:getChild("effLoop8")
	self.m_effLoop9 = self:getChild("effLoop9")
	self.m_effectNode2 = self:getChild("effectNode2")
	self.m_effectNode10 = self:getChild("effectNode10")
	self.m_effectNode1 = self:getChild("effectNode1")
	self.m_effectNode3 = self:getChild("effectNode3")
	self.m_effectNode4 = self:getChild("effectNode4")
	self.m_effectNode5 = self:getChild("effectNode5")
	self.m_effectNode6 = self:getChild("effectNode6")
	self.m_effectNode7 = self:getChild("effectNode7")
	self.m_effectNode8 = self:getChild("effectNode8")
	self.m_effectNode9 = self:getChild("effectNode9")
	self.m_enter1Transition = self:getTransition("enter1")
	self.m_backTransition = self:getTransition("back")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsTenCtrl = {
	ten = 1,
	one = 0
}
var_0_0.ClickEnableCtrl = {
	enable = 1,
	disable = 0
}

return var_0_0
