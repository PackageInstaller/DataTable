local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oadkwrrnk"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isUseController = self:getController("isUse")
	self.m_bgImg = self:getChild("bgImg")
	self.m_artifactIcon = self:getChild("artifactIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_starComp = self:getChild("starComp")
	self.m_knightIconComp = self:getChild("knightIconComp")
	self.m_idleEffectDown = self:getChild("idleEffectDown")
	self.m_bindKnightIcon = self:getChild("bindKnightIcon")
	self.m_idleEffectUp = self:getChild("idleEffectUp")
end

var_0_0.StateCtrl = {
	equip = 1,
	normal = 0
}
var_0_0.IsUseCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
