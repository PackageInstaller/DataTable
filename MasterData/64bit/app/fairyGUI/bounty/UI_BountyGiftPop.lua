local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfqr6v3h"

function var_0_0:__ctor()
	self.m_title = self:getChild("title")
	self.m_giftList = self:getChild("giftList")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
