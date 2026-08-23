local var_0_0 = {}

var_0_0.URL = "ui://pbd24silwcih1g"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_matchingDiskComp = self:getChild("matchingDiskComp")
	self.m_effDi = self:getChild("effDi")
	self.m_cdText = self:getChild("cdText")
	self.m_successText = self:getChild("successText")
	self.m_tipsText = self:getChild("tipsText")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
