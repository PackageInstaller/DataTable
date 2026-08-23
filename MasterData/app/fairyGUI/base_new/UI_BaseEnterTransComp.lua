local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepegmj1p"

function var_0_0:__ctor()
	self.m_styleTypeController = self:getController("styleType")
	self.m_touchFliter = self:getChild("touchFliter")
	self.m_normalGroup = self:getChild("normalGroup")
	self.m_effectHolder = self:getChild("effectHolder")
	self.m_spineGroup = self:getChild("spineGroup")
	self.m_enter_rightTransition = self:getTransition("enter_right")
	self.m_enter_leftTransition = self:getTransition("enter_left")
	self.m_enter_right2Transition = self:getTransition("enter_right2")
	self.m_enter_left2Transition = self:getTransition("enter_left2")
end

var_0_0.StyleTypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
