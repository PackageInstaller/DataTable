local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8e6vvb24"

function var_0_0:__ctor()
	self.m_taskStateController = self:getController("taskState")
	self.m_isGetController = self:getController("isGet")
	self.m_isUnlockController = self:getController("isUnlock")
	self.m_knightPlaceHolder = self:getChild("knightPlaceHolder")
	self.m_descTxt = self:getChild("descTxt")
	self.m_valueTxt = self:getChild("valueTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_giveUpBtn = self:getChild("giveUpBtn")
	self.m_goBtn = self:getChild("goBtn")
	self.m_getAwardBtn = self:getChild("getAwardBtn")
	self.m_getTaskBtn = self:getChild("getTaskBtn")
	self.m_unlockDescTxt = self:getChild("unlockDescTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
