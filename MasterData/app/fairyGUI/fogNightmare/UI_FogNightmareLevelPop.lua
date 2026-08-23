local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88or7ifh0"

function var_0_0:__ctor()
	self.m_isCurLevelController = self:getController("isCurLevel")
	self.m_isMaxLevelController = self:getController("isMaxLevel")
	self.m_effLevelPopbg = self:getChild("effLevelPopbg")
	self.m_leftBtn = self:getChild("leftBtn")
	self.m_rightBtn = self:getChild("rightBtn")
	self.m_levelProgressComp = self:getChild("levelProgressComp")
	self.m_expText = self:getChild("expText")
	self.m_titleText = self:getChild("titleText")
	self.m_levelDescComp = self:getChild("levelDescComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switchTransition = self:getTransition("switch")
end

var_0_0.IsCurLevelCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsMaxLevelCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
