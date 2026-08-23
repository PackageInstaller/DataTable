local var_0_0 = {}

var_0_0.URL = "ui://3ryajb8dxggolgicbj"

function var_0_0:__ctor()
	self.m_leftLoader = self:getChild("leftLoader")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_rightLoader = self:getChild("rightLoader")
	self.m_rightTextLoader = self:getChild("rightTextLoader")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_tipKnightBtn1 = self:getChild("tipKnightBtn1")
	self.m_limitTipLoader = self:getChild("limitTipLoader")
	self.m_raioText = self:getChild("raioText")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_groupClickComp = self:getChild("groupClickComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
