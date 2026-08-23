local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1xku32z"

function var_0_0:__ctor()
	self.m_isMaxLvController = self:getController("isMaxLv")
	self.m_isReachController = self:getController("isReach")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_lvTxt = self:getChild("lvTxt")
	self.m_alterNameTxt = self:getChild("alterNameTxt")
	self.m_nextLvAttrList = self:getChild("nextLvAttrList")
	self.m_maxLvTxt = self:getChild("maxLvTxt")
	self.m_content = self:getChild("content")
end

var_0_0.IsMaxLvCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsReachCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
