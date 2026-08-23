local var_0_0 = {}

var_0_0.URL = "ui://0vs2yqm8tnf211"

function var_0_0:__ctor()
	self.m_selController = self:getController("sel")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_memberComp1 = self:getChild("memberComp1")
	self.m_title = self:getChild("title")
	self.m_wishList = self:getChild("wishList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
