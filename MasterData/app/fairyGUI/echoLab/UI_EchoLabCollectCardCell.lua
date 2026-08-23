local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1abvq3o"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isShowRightLineController = self:getController("isShowRightLine")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_effectDownNode = self:getChild("effectDownNode")
	self.m_knightComp = self:getChild("knightComp")
	self.m_nameText = self:getChild("nameText")
	self.m_starComp = self:getChild("starComp")
	self.m_stateLoader = self:getChild("stateLoader")
	self.m_effectUpNode = self:getChild("effectUpNode")
	self.m_effectNode = self:getChild("effectNode")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	lock = 0,
	max = 3,
	levelUp = 2,
	canActive = 4,
	normal = 1
}
var_0_0.IsShowRightLineCtrl = {
	hide = 0,
	show = 1
}

return var_0_0
