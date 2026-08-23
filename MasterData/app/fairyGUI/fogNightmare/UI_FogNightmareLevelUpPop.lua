local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ob45srrhg"

function var_0_0:__ctor()
	self.m_showViewController = self:getController("showView")
	self.m_effComTitle = self:getChild("effComTitle")
	self.m_beforeLevelText = self:getChild("beforeLevelText")
	self.m_effIconbg = self:getChild("effIconbg")
	self.m_curLevelText = self:getChild("curLevelText")
	self.m_effArrow = self:getChild("effArrow")
	self.m_titleText = self:getChild("titleText")
	self.m_levelDescComp = self:getChild("levelDescComp")
	self.m_autoNode = self:getChild("autoNode")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ShowViewCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
