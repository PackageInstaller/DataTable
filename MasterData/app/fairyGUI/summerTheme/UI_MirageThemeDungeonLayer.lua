local var_0_0 = {}

var_0_0.URL = "ui://99hn3059g2gv1spemh2"

function var_0_0:__ctor()
	self.m_mapPlaceComp = self:getChild("mapPlaceComp")
	self.m_chestRewardBtn = self:getChild("chestRewardBtn")
	self.m_curTxt = self:getChild("curTxt")
	self.m_totalTxt = self:getChild("totalTxt")
	self.m_progress = self:getChild("progress")
	self.m_chapterList = self:getChild("chapterList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
