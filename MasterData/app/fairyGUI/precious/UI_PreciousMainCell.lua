local var_0_0 = {}

var_0_0.URL = "ui://671qywx2gn4yq"

function var_0_0:__ctor()
	self.m_hideNameController = self:getController("hideName")
	self.m_hideStageController = self:getController("hideStage")
	self.m_effBg = self:getChild("effBg")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_subComp1 = self:getChild("subComp1")
	self.m_subComp2 = self:getChild("subComp2")
	self.m_subComp3 = self:getChild("subComp3")
	self.m_suitNameComp = self:getChild("suitNameComp")
	self.m_effSuccess = self:getChild("effSuccess")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
