local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7nyylda"

function var_0_0:__ctor()
	self.m_suitTypeController = self:getController("suitType")
	self.m_suitStage = self:getChild("suitStage")
	self.m_conditionDesc = self:getChild("conditionDesc")
end

var_0_0.SuitTypeCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
