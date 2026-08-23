local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7wnqfbg"

function var_0_0:__ctor()
	self.m_hasPassiveSkillController = self:getController("hasPassiveSkill")
	self.m_skillList = self:getChild("skillList")
	self.m_suitAttrList = self:getChild("suitAttrList")
end

var_0_0.HasPassiveSkillCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
