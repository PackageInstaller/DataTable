local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gt62oz"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_isHideNameController = self:getController("isHideName")
	self.m_hideRedController = self:getController("hideRed")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_icon = self:getChild("icon")
	self.m_stageComp1 = self:getChild("stageComp1")
	self.m_stageGroup = self:getChild("stageGroup")
	self.m_talentName = self:getChild("talentName")
	self.m_eff = self:getChild("eff")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_upTransition = self:getTransition("up")
end

return var_0_0
