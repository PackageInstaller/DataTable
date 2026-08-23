local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vl5qq9t"

function var_0_0:__ctor()
	self.m_showController = self:getController("show")
	self.m_numTypeController = self:getController("numType")
	self.m_posController = self:getController("pos")
	self.m_stageController = self:getController("stage")
	self.m_touchArea = self:getChild("touchArea")
	self.m_detailComp = self:getChild("detailComp")
	self.m_selection1 = self:getChild("selection1")
	self.m_selection2 = self:getChild("selection2")
	self.m_selection3 = self:getChild("selection3")
	self.m_selection0 = self:getChild("selection0")
	self.m_resultComp = self:getChild("resultComp")
	self.m_blockArea = self:getChild("blockArea")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_voteList = self:getChild("voteList")
	self.m_tipComp = self:getChild("tipComp")
	self.m_highLight = self:getChild("highLight")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
