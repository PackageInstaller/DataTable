local var_0_0 = {}

var_0_0.URL = "ui://671qywx2gn4yo"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_hideStageController = self:getController("hideStage")
	self.m_baseComp = self:getChild("baseComp")
	self.m_numTxt = self:getChild("numTxt")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
