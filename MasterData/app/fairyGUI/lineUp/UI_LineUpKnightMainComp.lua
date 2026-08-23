local var_0_0 = {}

var_0_0.URL = "ui://ij78oondurbsdm"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_effDadComp = self:getChild("effDadComp")
	self.m_spineDadComp = self:getChild("spineDadComp")
	self.m_knightMovieComp = self:getChild("knightMovieComp")
	self.m_effectComp = self:getChild("effectComp")
	self.m_infoComp = self:getChild("infoComp")
	self.m_nameComp = self:getChild("nameComp")
	self.m_addBtn = self:getChild("addBtn")
	self.m_addText = self:getChild("addText")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_switchTransition = self:getTransition("switch")
	self.m_enter_knightTransition = self:getTransition("enter_knight")
end

var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
