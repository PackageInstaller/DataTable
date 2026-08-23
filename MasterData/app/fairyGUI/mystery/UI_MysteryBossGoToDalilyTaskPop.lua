local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8eivux2z"

function var_0_0:__ctor()
	self.m_taskStateController = self:getController("taskState")
	self.m_title = self:getChild("title")
	self.m_taskDescTxt = self:getChild("taskDescTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_bossNameTxt = self:getChild("bossNameTxt")
	self.m_goToBtn = self:getChild("goToBtn")
	self.m_getAwardBtn = self:getChild("getAwardBtn")
	self.m_bossIconComp = self:getChild("bossIconComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
