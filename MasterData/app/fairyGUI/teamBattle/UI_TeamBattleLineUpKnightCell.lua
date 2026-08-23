local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkpbi8w"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_hideHpController = self:getController("hideHp")
	self.m_isUseController = self:getController("isUse")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_hpBar = self:getChild("hpBar")
	self.m_nameText = self:getChild("nameText")
	self.m_stageText = self:getChild("stageText")
	self.m_starComp = self:getChild("starComp")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_stateText = self:getChild("stateText")
end

var_0_0.StateCtrl = {
	lineUp = 1,
	dead = 2,
	normal = 0
}
var_0_0.HideHpCtrl = {
	hide = 1,
	show = 0
}
var_0_0.IsUseCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
