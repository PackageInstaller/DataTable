local var_0_0 = {}

var_0_0.URL = "ui://foyq921sfu8o26"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_difficultyController = self:getController("difficulty")
	self.m_hard = self:getChild("hard")
	self.m_stageIndex = self:getChild("stageIndex")
	self.m_effectNode = self:getChild("effectNode")
	self.m_effectNodePrefact = self:getChild("effectNodePrefact")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.DifficultyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
