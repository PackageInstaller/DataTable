local var_0_0 = {}

var_0_0.URL = "ui://5c0f8ijkv4o8c"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_costNumController = self:getController("costNum")
	self.m_increaseProgBar = self:getChild("increaseProgBar")
	self.m_addEffectHolder = self:getChild("addEffectHolder")
	self.m_increaseEffectHolder = self:getChild("increaseEffectHolder")
	self.m_stageText = self:getChild("stageText")
	self.m_baseAttrComp = self:getChild("baseAttrComp")
	self.m_talentSkillComp = self:getChild("talentSkillComp")
	self.m_resCompBg2 = self:getChild("resCompBg2")
	self.m_resComp2 = self:getChild("resComp2")
	self.m_resCompBg1 = self:getChild("resCompBg1")
	self.m_resComp1 = self:getChild("resComp1")
	self.m_increaseBtn = self:getChild("increaseBtn")
	self.m_maxComp = self:getChild("maxComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_advanceTransition = self:getTransition("advance")
end

return var_0_0
