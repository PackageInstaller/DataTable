local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1abvq3t"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_clickNode = self:getChild("clickNode")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_title = self:getChild("title")
	self.m_levelTxt1 = self:getChild("levelTxt1")
	self.m_levelTxt2 = self:getChild("levelTxt2")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_listComp = self:getChild("listComp")
	self.m_nameComp = self:getChild("nameComp")
	self.m_lvUpEffHolder = self:getChild("lvUpEffHolder")
	self.m_normalState = self:getChild("normalState")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.StateCtrl = {
	active = 1,
	upgrade = 0
}

return var_0_0
