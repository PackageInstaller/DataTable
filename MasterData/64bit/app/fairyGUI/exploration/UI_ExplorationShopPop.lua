local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25egt14c"

function var_0_0:__ctor()
	self.m_resComp = self:getChild("resComp")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_costComp = self:getChild("costComp")
	self.m_freshBtn = self:getChild("freshBtn")
	self.m_shopList = self:getChild("shopList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
