local var_0_0 = {}

var_0_0.URL = "ui://aeavo6obl1fx22"

function var_0_0:__ctor()
	self.m_hasTalentController = self:getController("hasTalent")
	self.m_attrList = self:getChild("attrList")
	self.m_skillList = self:getChild("skillList")
end

var_0_0.HasTalentCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
