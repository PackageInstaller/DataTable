local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8erxfr2g"

function var_0_0:__ctor()
	self.m_lastBtn = self:getChild("lastBtn")
	self.m_nextBtn = self:getChild("nextBtn")
	self.m_chapterList = self:getChild("chapterList")
	self.m_chatComp = self:getChild("chatComp")
	self.m_playTimesComp = self:getChild("playTimesComp")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
