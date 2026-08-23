local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6cfmu1kk40m"

function var_0_0:__ctor()
	self.m_inGameController = self:getController("inGame")
	self.m_knightComp = self:getChild("knightComp")
	self.m_knightFrontComp = self:getChild("knightFrontComp")
	self.m_selection1 = self:getChild("selection1")
	self.m_selection2 = self:getChild("selection2")
	self.m_selection3 = self:getChild("selection3")
	self.m_selection4 = self:getChild("selection4")
	self.m_effHolder = self:getChild("effHolder")
end

var_0_0.InGameCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
