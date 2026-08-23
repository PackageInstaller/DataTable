local var_0_0 = {}

var_0_0.URL = "ui://7ex6tye9tq3w56"

function var_0_0:__ctor()
	self.m_tipsText = self:getChild("tipsText")
	self.m_uniteTokenList = self:getChild("uniteTokenList")
	self.m_petList = self:getChild("petList")
	self.m_borrowDayText1 = self:getChild("borrowDayText1")
	self.m_borrowTipsText1 = self:getChild("borrowTipsText1")
	self.m_borrowDayText2 = self:getChild("borrowDayText2")
	self.m_borrowTipsText2 = self:getChild("borrowTipsText2")
	self.m_content = self:getChild("content")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
