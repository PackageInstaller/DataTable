local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiqmi252r"

function var_0_0:__ctor()
	self.m_bg = self:getChild("bg")
	self.m_title = self:getChild("title")
	self.m_giftList = self:getChild("giftList")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
