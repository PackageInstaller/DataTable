local var_0_0 = {}

var_0_0.URL = "ui://05rqz4hsftt520"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_qualityBtn1 = self:getChild("qualityBtn1")
	self.m_qualityBtn2 = self:getChild("qualityBtn2")
	self.m_qualityBtn3 = self:getChild("qualityBtn3")
	self.m_qualityBtn4 = self:getChild("qualityBtn4")
	self.m_qualityBtn5 = self:getChild("qualityBtn5")
	self.m_qualityBtn6 = self:getChild("qualityBtn6")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
