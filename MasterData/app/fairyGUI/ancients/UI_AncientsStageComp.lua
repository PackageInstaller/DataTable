local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2kr031n"

function var_0_0:__ctor()
	self.m_stageController = self:getController("stage")
	self.m_Txt_stage = self:getChild("Txt_stage")
	self.m_Txt_cd = self:getChild("Txt_cd")
end

var_0_0.StageCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
