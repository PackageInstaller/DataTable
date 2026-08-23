local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6xll81kk40r"

function var_0_0:__ctor()
	self.m_endlessController = self:getController("endless")
	self.m_isCountDownController = self:getController("isCountDown")
	self.m_num_typeController = self:getController("num_type")
	self.m_bgIcon = self:getChild("bgIcon")
	self.m_tagIcon = self:getChild("tagIcon")
	self.m_title = self:getChild("title")
	self.m_countDownTransition = self:getTransition("countDown")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.EndlessCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsCountDownCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.Num_typeCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
