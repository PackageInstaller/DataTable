local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vl5qq93"

function var_0_0:__ctor()
	self.m_curChapterController = self:getController("curChapter")
	self.m_bgIcon = self:getChild("bgIcon")
	self.m_chapterComp = self:getChild("chapterComp")
	self.m_voteEntranceBtn = self:getChild("voteEntranceBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
