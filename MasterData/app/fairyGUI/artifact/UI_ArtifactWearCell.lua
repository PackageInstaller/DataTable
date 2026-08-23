local var_0_0 = {}

var_0_0.URL = "ui://nhmdbbcvlu7agic2j"

function var_0_0:__ctor()
	self.m_wearStateController = self:getController("wearState")
	self.m_urStageAddController = self:getController("urStageAdd")
	self.m_bgImg = self:getChild("bgImg")
	self.m_artifactIcon = self:getChild("artifactIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_starComp = self:getChild("starComp")
	self.m_idleEffectDown = self:getChild("idleEffectDown")
	self.m_wearComp = self:getChild("wearComp")
	self.m_knightIconComp = self:getChild("knightIconComp")
	self.m_enterEffect = self:getChild("enterEffect")
	self.m_idleEffectUp = self:getChild("idleEffectUp")
	self.m_spiritComp = self:getChild("spiritComp")
end

return var_0_0
