local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mjirpm5r"

function var_0_0:__ctor()
	self.m_stageController = self:getController("stage")
	self.m_typeController = self:getController("type")
	self.m_groupController = self:getController("group")
	self.m_stageTxt = self:getChild("stageTxt")
	self.m_targetTxt = self:getChild("targetTxt")
	self.m_schedulerComp = self:getChild("schedulerComp")
end

var_0_0.StageCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.GroupCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
