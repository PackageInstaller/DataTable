local var_0_0 = {}

var_0_0.URL = "ui://16fa1nlapz8f4v"

function var_0_0:__ctor()
	self.m_isKnightController = self:getController("isKnight")
	self.m_isNewController = self:getController("isNew")
	self.m_qualityBgEffect = self:getChild("qualityBgEffect")
	self.m_groupIcon = self:getChild("groupIcon")
	self.m_groupText = self:getChild("groupText")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_knightPic = self:getChild("knightPic")
	self.m_qualityBorder = self:getChild("qualityBorder")
	self.m_qualityBorderEffect = self:getChild("qualityBorderEffect")
	self.m_fragIcon = self:getChild("fragIcon")
	self.m_numTxt = self:getChild("numTxt")
	self.m_groupFrag = self:getChild("groupFrag")
	self.m_fragEffectNode = self:getChild("fragEffectNode")
	self.m_enterTransition = self:getTransition("enter")
	self.m_fragEnterTransition = self:getTransition("fragEnter")
end

var_0_0.IsKnightCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsNewCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
