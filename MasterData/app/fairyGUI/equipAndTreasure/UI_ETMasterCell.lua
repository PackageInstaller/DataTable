local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7q54f7q"

function var_0_0:__ctor()
	self.m_isResonanceController = self:getController("isResonance")
	self.m_canResoanceController = self:getController("canResoance")
	self.m_resonanceEnoughController = self:getController("resonanceEnough")
	self.m_icon = self:getChild("icon")
	self.m_name = self:getChild("name")
	self.m_progress = self:getChild("progress")
	self.m_curLevelText = self:getChild("curLevelText")
	self.m_nextLevelText = self:getChild("nextLevelText")
	self.m_cantEnhanceTxt = self:getChild("cantEnhanceTxt")
	self.m_targetResonanceLevelComp = self:getChild("targetResonanceLevelComp")
	self.m_curResonanceLevelComp = self:getChild("curResonanceLevelComp")
end

var_0_0.IsResonanceCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.CanResoanceCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ResonanceEnoughCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
