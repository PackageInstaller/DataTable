local var_0_0 = {}

var_0_0.URL = "ui://lgwihzjqc8pw3q"

function var_0_0:__ctor()
	self.m_chapterLable = self:getChild("chapterLable")
	self.m_chapteBgImage = self:getChild("chapteBgImage")
	self.m_chapteList = self:getChild("chapteList")
	self.m_chapterGroup = self:getChild("chapterGroup")
	self.m_switchTransition = self:getTransition("switch")
end

return var_0_0
