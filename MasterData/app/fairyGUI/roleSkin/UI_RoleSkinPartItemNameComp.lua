local var_0_0 = {}

var_0_0.URL = "ui://x323b22nje0c17"

function var_0_0:__ctor()
	self.m_showStageController = self:getController("showStage")
	self.m_name = self:getChild("name")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_stage = self:getChild("stage")
end

var_0_0.ShowStageCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
