local var_0_0 = {}

var_0_0.URL = "ui://fl8ril81hs8us"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_campController = self:getController("camp")
	self.m_tabBtn1 = self:getChild("tabBtn1")
	self.m_tabBtn5 = self:getChild("tabBtn5")
	self.m_tabBtn4 = self:getChild("tabBtn4")
	self.m_tabBtn2 = self:getChild("tabBtn2")
	self.m_tabBtn3 = self:getChild("tabBtn3")
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
