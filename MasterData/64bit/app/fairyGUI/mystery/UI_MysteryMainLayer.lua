local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8eifxx0"

function var_0_0:__ctor()
	self.m_hasNewChapterController = self:getController("hasNewChapter")
	self.m_mapComp = self:getChild("mapComp")
	self.m_chatComp = self:getChild("chatComp")
	self.m_goBossBtn = self:getChild("goBossBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_taskComp = self:getChild("taskComp")
	self.m_chapterBtn = self:getChild("chapterBtn")
	self.m_bossBtn = self:getChild("bossBtn")
	self.m_newChapterBtn = self:getChild("newChapterBtn")
	self.m_lineComp = self:getChild("lineComp")
	self.m_playTimesComp = self:getChild("playTimesComp")
	self.m_topBar = self:getChild("topBar")
	self.m_otherOpeComp = self:getChild("otherOpeComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
