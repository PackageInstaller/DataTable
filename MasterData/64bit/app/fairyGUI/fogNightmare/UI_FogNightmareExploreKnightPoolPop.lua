local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ou8jrrrj5"

function var_0_0:__ctor()
	self.m_showBtnController = self:getController("showBtn")
	self.m_knightNumText = self:getChild("knightNumText")
	self.m_keepsakeNumText = self:getChild("keepsakeNumText")
	self.m_autoBtn = self:getChild("autoBtn")
	self.m_startBtn = self:getChild("startBtn")
	self.m_poolList = self:getChild("poolList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ShowBtnCtrl = {
	hide = 0,
	show = 1
}

return var_0_0
