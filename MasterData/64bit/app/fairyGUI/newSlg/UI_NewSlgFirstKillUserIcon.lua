local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9lojw68nf"

function var_0_0:__ctor()
	self.m_isselfController = self:getController("isself")
	self.m_Comp_user = self:getChild("Comp_user")
	self.m_Comp_name = self:getChild("Comp_name")
end

var_0_0.IsselfCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
