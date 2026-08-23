local var_0_0 = {}

var_0_0.URL = "ui://4kvnuk1fqv442t"

function var_0_0:__ctor()
	self.m_isCountDownController = self:getController("isCountDown")
	self.m_bgIcon = self:getChild("bgIcon")
	self.m_tagIcon = self:getChild("tagIcon")
	self.m_title = self:getChild("title")
	self.m_countDownTransition = self:getTransition("countDown")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
