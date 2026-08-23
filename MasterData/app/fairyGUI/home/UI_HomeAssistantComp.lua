local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgfkr95ibg0"

function var_0_0:__ctor()
	self.m_showLinesController = self:getController("showLines")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_knightComp = self:getChild("knightComp")
	self.m_movieComp = self:getChild("movieComp")
	self.m_effectComp = self:getChild("effectComp")
	self.m_touchBg = self:getChild("touchBg")
	self.m_bgImg = self:getChild("bgImg")
	self.m_enterTransition = self:getTransition("enter")
	self.m_rightTransition = self:getTransition("right")
	self.m_leftTransition = self:getTransition("left")
end

var_0_0.ShowLinesCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
