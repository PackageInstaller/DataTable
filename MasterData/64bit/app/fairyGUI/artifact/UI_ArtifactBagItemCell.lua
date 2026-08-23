local var_0_0 = {}

var_0_0.URL = "ui://nhmdbbcvtnrvgic32"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_urStageAddController = self:getController("urStageAdd")
	self.m_bgIcon = self:getChild("bgIcon")
	self.m_groupBgComp = self:getChild("groupBgComp")
	self.m_icon = self:getChild("icon")
	self.m_nameText = self:getChild("nameText")
	self.m_smallKnightIcon = self:getChild("smallKnightIcon")
	self.m_relatedComp = self:getChild("relatedComp")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_starComp = self:getChild("starComp")
	self.m_wearGroup = self:getChild("wearGroup")
	self.m_composeGroup = self:getChild("composeGroup")
	self.m_curTxt = self:getChild("curTxt")
	self.m_needTxt = self:getChild("needTxt")
	self.m_processGroup = self:getChild("processGroup")
	self.m_effectComp = self:getChild("effectComp")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_spiritComp = self:getChild("spiritComp")
end

return var_0_0
