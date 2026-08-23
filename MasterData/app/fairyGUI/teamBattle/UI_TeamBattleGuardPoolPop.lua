local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lgy5p7x"

function var_0_0:__ctor()
	self.m_isTempController = self:getController("isTemp")
	self.m_easyKeyStateController = self:getController("easyKeyState")
	self.m_knightList = self:getChild("knightList")
	self.m_easyBtn = self:getChild("easyBtn")
	self.m_startBtn = self:getChild("startBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsTempCtrl = {
	temp = 1,
	normal = 0
}
var_0_0.EasyKeyStateCtrl = {
	lineUp = 0,
	lineOff = 1
}

return var_0_0
