local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ulu8gt0"

function var_0_0:__ctor()
	self.m_chapterList = self:getChild("chapterList")
	self.m_rightBtn = self:getChild("rightBtn")
	self.m_leftBtn = self:getChild("leftBtn")
	self.m_honorComp = self:getChild("honorComp")
	self.m_allAttrBtn = self:getChild("allAttrBtn")
	self.m_honorRankBtn = self:getChild("honorRankBtn")
	self.m_recruitBtn = self:getChild("recruitBtn")
	self.m_bagBtn = self:getChild("bagBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
