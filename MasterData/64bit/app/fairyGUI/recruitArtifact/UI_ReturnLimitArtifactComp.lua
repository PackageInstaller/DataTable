local var_0_0 = {}

var_0_0.URL = "ui://3ryajb8diqtt12uytqg"

function var_0_0:__ctor()
	self.m_leftLoader = self:getChild("leftLoader")
	self.m_tipBtn1 = self:getChild("tipBtn1")
	self.m_rightLoder = self:getChild("rightLoder")
	self.m_tipBtn3 = self:getChild("tipBtn3")
	self.m_centerLoader = self:getChild("centerLoader")
	self.m_tipBtn2 = self:getChild("tipBtn2")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_raioText = self:getChild("raioText")
	self.m_wishComp = self:getChild("wishComp")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
