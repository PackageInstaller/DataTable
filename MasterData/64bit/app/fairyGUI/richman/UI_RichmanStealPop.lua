local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwi6ei2u"

function var_0_0:__ctor()
	self.m_pageController = self:getController("page")
	self.m_emptyController = self:getController("empty")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_title = self:getChild("title")
	self.m_playerList = self:getChild("playerList")
	self.m_refreshBtn = self:getChild("refreshBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
