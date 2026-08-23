local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6m4gpkk3ez"

function var_0_0:__ctor()
	self.m_endlessController = self:getController("endless")
	self.m_isCountDownController = self:getController("isCountDown")
	self.m_bgIcon = self:getChild("bgIcon")
	self.m_tagIcon = self:getChild("tagIcon")
	self.m_title = self:getChild("title")
	self.m_countDownTransition = self:getTransition("countDown")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.EndlessCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsCountDownCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
