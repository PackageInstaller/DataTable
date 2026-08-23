local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vzqdx9bnoq9"

function var_0_0:__ctor()
	self.m_curChapterController = self:getController("curChapter")
	self.m_chapterComp1 = self:getChild("chapterComp1")
	self.m_chapterComp2 = self:getChild("chapterComp2")
	self.m_chapterComp3 = self:getChild("chapterComp3")
	self.m_ship1 = self:getChild("ship1")
	self.m_effShip1 = self:getChild("effShip1")
	self.m_ship2 = self:getChild("ship2")
	self.m_effShip2 = self:getChild("effShip2")
	self.m_position1 = self:getChild("position1")
	self.m_position3 = self:getChild("position3")
	self.m_position2 = self:getChild("position2")
	self.m_chapter = self:getChild("chapter")
	self.m_shipMove1Transition = self:getTransition("shipMove1")
	self.m_shipMove2Transition = self:getTransition("shipMove2")
	self.m_hideLine1Transition = self:getTransition("hideLine1")
	self.m_hideLine2Transition = self:getTransition("hideLine2")
end

return var_0_0
