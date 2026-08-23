local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2sjoy06m"

function var_0_0:__ctor()
	self.m_isUpgradeController = self:getController("isUpgrade")
	self.m_closeBg = self:getChild("closeBg")
	self.m_resultTxt = self:getChild("resultTxt")
	self.m_successList = self:getChild("successList")
	self.m_successNone = self:getChild("successNone")
	self.m_failList = self:getChild("failList")
	self.m_failNone = self:getChild("failNone")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
