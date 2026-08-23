local var_0_0 = {}

var_0_0.URL = "ui://o45uocofh9x2gic30"

function var_0_0:__ctor()
	self.m_isShareController = self:getController("isShare")
	self.m_isSelectTalkController = self:getController("isSelectTalk")
	self.m_shareBg = self:getChild("shareBg")
	self.m_logoLoader = self:getChild("logoLoader")
	self.m_eggImage = self:getChild("eggImage")
	self.m_eggNumber = self:getChild("eggNumber")
	self.m_eggName = self:getChild("eggName")
	self.m_eggDescComp = self:getChild("eggDescComp")
	self.m_shareDesc = self:getChild("shareDesc")
	self.m_shareTalkComp = self:getChild("shareTalkComp")
	self.m_talkList = self:getChild("talkList")
	self.m_shareComp = self:getChild("shareComp")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_showGroup = self:getChild("showGroup")
	self.m_openTransition = self:getTransition("open")
	self.m_closeTransition = self:getTransition("close")
	self.m_talk_1Transition = self:getTransition("talk_1")
end

return var_0_0
