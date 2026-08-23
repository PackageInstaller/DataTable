local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7nyylcp"

function var_0_0:__ctor()
	self.m_isMaxStageController = self:getController("isMaxStage")
	self.m_magicalQualityController = self:getController("magicalQuality")
	self.m_valueDescComp = self:getChild("valueDescComp")
	self.m_talentDescComp = self:getChild("talentDescComp")
	self.m_fragComp = self:getChild("fragComp")
	self.m_maxStage = self:getChild("maxStage")
	self.m_curStage = self:getChild("curStage")
	self.m_nextStage = self:getChild("nextStage")
	self.m_placeHolder = self:getChild("placeHolder")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsMaxStageCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.MagicalQualityCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
