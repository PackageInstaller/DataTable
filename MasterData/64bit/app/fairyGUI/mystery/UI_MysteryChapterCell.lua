local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8e6vvb26"

function var_0_0:__ctor()
	self.m_isCurController = self:getController("isCur")
	self.m_stateController = self:getController("state")
	self.m_haveBossController = self:getController("haveBoss")
	self.m_isPassController = self:getController("isPass")
	self.m_chapterLoader = self:getChild("chapterLoader")
	self.m_chapterNameTxt = self:getChild("chapterNameTxt")
	self.m_bossIconComp = self:getChild("bossIconComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
