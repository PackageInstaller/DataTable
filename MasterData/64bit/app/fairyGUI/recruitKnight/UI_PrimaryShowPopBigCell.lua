local var_0_0 = {}

var_0_0.URL = "ui://c64rm38ywczd29"

function var_0_0:__ctor()
	self.m_recruitedController = self:getController("recruited")
	self.m_isLuckController = self:getController("isLuck")
	self.m_indexText = self:getChild("indexText")
	self.m_viewBtn = self:getChild("viewBtn")
	self.m_iconList = self:getChild("iconList")
	self.m_effNode = self:getChild("effNode")
	self.m_clickNode = self:getChild("clickNode")
end

var_0_0.RecruitedCtrl = {
	normal = 0,
	recruited = 1
}
var_0_0.IsLuckCtrl = {
	normal = 0,
	luck = 1
}

return var_0_0
