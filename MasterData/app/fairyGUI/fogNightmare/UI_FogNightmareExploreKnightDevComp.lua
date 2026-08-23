local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oadkwrrnj"

function var_0_0:__ctor()
	self.m_hasController = self:getController("has")
	self.m_isEffectController = self:getController("isEffect")
	self.m_hidePlusController = self:getController("hidePlus")
	self.m_urStageAddController = self:getController("urStageAdd")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_noneUILoader = self:getChild("noneUILoader")
	self.m_addBtn = self:getChild("addBtn")
	self.m_effArtifact = self:getChild("effArtifact")
	self.m_icon = self:getChild("icon")
	self.m_starText = self:getChild("starText")
	self.m_spiritComp = self:getChild("spiritComp")
end

var_0_0.HasCtrl = {
	has = 1,
	none = 0
}
var_0_0.IsEffectCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HidePlusCtrl = {
	hide = 1,
	show = 0
}
var_0_0.UrStageAddCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
