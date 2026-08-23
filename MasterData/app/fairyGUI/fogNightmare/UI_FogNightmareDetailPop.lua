local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88owbv4fo"

function var_0_0:__ctor()
	self.m_maxFloorController = self:getController("maxFloor")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_curReward1 = self:getChild("curReward1")
	self.m_curReward2 = self:getChild("curReward2")
	self.m_nextReward1 = self:getChild("nextReward1")
	self.m_nextReward2 = self:getChild("nextReward2")
	self.m_nextStageTxt = self:getChild("nextStageTxt")
	self.m_content = self:getChild("content")
end

var_0_0.MaxFloorCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
