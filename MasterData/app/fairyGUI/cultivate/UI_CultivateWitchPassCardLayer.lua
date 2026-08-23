local var_0_0 = {}

var_0_0.URL = "ui://1q5ehb83ijb63c"

function var_0_0:__ctor()
	self.m_knightComp = self:getChild("knightComp")
	self.m_eff = self:getChild("eff")
	self.m_textLoader = self:getChild("textLoader")
	self.m_timeDiGraph = self:getChild("timeDiGraph")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_passCardBgLoader = self:getChild("passCardBgLoader")
	self.m_passTitleBg = self:getChild("passTitleBg")
	self.m_passCardList = self:getChild("passCardList")
	self.m_oneKeyBtn = self:getChild("oneKeyBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
