local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99u639kk2pi"

function var_0_0:__ctor()
	self.m_canFightController = self:getController("canFight")
	self.m_typeController = self:getController("type")
	self.m_popPanel = self:getChild("popPanel")
	self.m_teamList = self:getChild("teamList")
	self.m_selectBtn = self:getChild("selectBtn")
	self.m_tipBtn = self:getChild("tipBtn")
	self.m_content = self:getChild("content")
	self.m_changeCheckBtn = self:getChild("changeCheckBtn")
end

var_0_0.CanFightCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.TypeCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 9
}

return var_0_0
