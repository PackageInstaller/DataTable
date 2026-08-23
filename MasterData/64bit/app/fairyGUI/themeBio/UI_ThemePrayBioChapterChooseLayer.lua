local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vimf3mw2xfn"

function var_0_0:__ctor()
	self.m_bgIcon = self:getChild("bgIcon")
	self.m_chapterComp1 = self:getChild("chapterComp1")
	self.m_chapterComp2 = self:getChild("chapterComp2")
	self.m_chapterComp3 = self:getChild("chapterComp3")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
