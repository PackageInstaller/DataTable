local var_0_0 = {}

var_0_0.URL = "ui://arku10fqkn9i7s"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_bg = self:getChild("bg")
	self.m_mapComp = self:getChild("mapComp")
	self.m_topBar = self:getChild("topBar")
	self.m_effmap = self:getChild("effmap")
	self.m_playTimesComp = self:getChild("playTimesComp")
	self.m_garrisonInfoBtn = self:getChild("garrisonInfoBtn")
	self.m_skillTreeBtn = self:getChild("skillTreeBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_rewardBtn = self:getChild("rewardBtn")
	self.m_easyBtn = self:getChild("easyBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
