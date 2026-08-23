local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1jr2h3l"

function var_0_0:__ctor()
	self.m_isPlayController = self:getController("isPlay")
	self.m_spineNode = self:getChild("spineNode")
	self.m_leftBtn = self:getChild("leftBtn")
	self.m_rightBtn = self:getChild("rightBtn")
	self.m_bookList = self:getChild("bookList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
