local var_0_0 = {}

var_0_0.URL = "ui://ami25kgybcnx11"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_urStageAddController = self:getController("urStageAdd")
	self.m_bgIcon = self:getChild("bgIcon")
	self.m_groupBgIcon = self:getChild("groupBgIcon")
	self.m_icon = self:getChild("icon")
	self.m_nameText = self:getChild("nameText")
	self.m_relatedComp = self:getChild("relatedComp")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_starComp = self:getChild("starComp")
	self.m_wearGroup = self:getChild("wearGroup")
	self.m_composeGroup = self:getChild("composeGroup")
	self.m_curTxt = self:getChild("curTxt")
	self.m_needTxt = self:getChild("needTxt")
	self.m_processGroup = self:getChild("processGroup")
	self.m_effectComp = self:getChild("effectComp")
	self.m_spiritComp = self:getChild("spiritComp")
end

var_0_0.StateCtrl = {
	可突破 = 4,
	可合成 = 2,
	未拥有 = 3,
	已拥有未穿戴 = 1,
	穿戴中 = 0
}
var_0_0.UrStageAddCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
