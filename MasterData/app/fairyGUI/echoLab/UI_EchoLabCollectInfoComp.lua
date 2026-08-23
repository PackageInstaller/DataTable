local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1abvq40"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_listComp = self:getChild("listComp")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_tipText = self:getChild("tipText")
end

var_0_0.StateCtrl = {
	maxGrade = 3,
	canNotActive = 0,
	canNotLevelUp = 2,
	canLevelUp = 4,
	canActive = 1
}

return var_0_0
