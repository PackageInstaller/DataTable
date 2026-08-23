local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgd85e5ibi4"

function var_0_0:__ctor()
	self.m_selectIndexController = self:getController("selectIndex")
	self.m_showDotController = self:getController("showDot")
	self.m_bannerBtnList = self:getChild("bannerBtnList")
	self.m_bannerDotList = self:getChild("bannerDotList")
	self.m_loopTransition = self:getTransition("loop")
end

var_0_0.ShowDotCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
