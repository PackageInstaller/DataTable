local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkpbi8x"

function var_0_0:__ctor()
	self.m_wearStateController = self:getController("wearState")
	self.m_bgImg = self:getChild("bgImg")
	self.m_artifactIcon = self:getChild("artifactIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_starComp = self:getChild("starComp")
	self.m_knightIconComp = self:getChild("knightIconComp")
	self.m_idleEffectDown = self:getChild("idleEffectDown")
	self.m_knightIconLoader = self:getChild("knightIconLoader")
	self.m_idleEffectUp = self:getChild("idleEffectUp")
end

var_0_0.WearStateCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
