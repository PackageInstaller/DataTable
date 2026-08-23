local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5116r746"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_buildIcon = self:getChild("buildIcon")
	self.m_buildNameTxt = self:getChild("buildNameTxt")
	self.m_buildDescTxt = self:getChild("buildDescTxt")
	self.m_unlockTxt = self:getChild("unlockTxt")
	self.m_buildOpeBtn = self:getChild("buildOpeBtn")
	self.m_costResComp = self:getChild("costResComp")
	self.m_effNode = self:getChild("effNode")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
