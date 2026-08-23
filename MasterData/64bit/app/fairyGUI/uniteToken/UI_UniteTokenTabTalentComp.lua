local var_0_0 = {}

var_0_0.URL = "ui://3yl23vbxj4mi1l"

function var_0_0:__ctor()
	self.m_showPassiveController = self:getController("showPassive")
	self.m_skillList = self:getChild("skillList")
	self.m_passiveList = self:getChild("passiveList")
	self.m_talentList = self:getChild("talentList")
end

var_0_0.ShowPassiveCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
