local var_0_0 = {}

var_0_0.URL = "ui://1q5ehb83ubj33"

function var_0_0:__ctor()
	self.m_iconBgLoader = self:getChild("iconBgLoader")
	self.m_itemLoader = self:getChild("itemLoader")
	self.m_eff = self:getChild("eff")
	self.m_textLoader = self:getChild("textLoader")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_timeDiGraph = self:getChild("timeDiGraph")
	self.m_lineLoader = self:getChild("lineLoader")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_passCardBgLoader = self:getChild("passCardBgLoader")
	self.m_passCardList = self:getChild("passCardList")
	self.m_oneKeyBtn = self:getChild("oneKeyBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
