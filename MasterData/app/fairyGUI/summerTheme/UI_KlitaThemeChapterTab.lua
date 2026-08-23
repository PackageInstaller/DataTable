local var_0_0 = {}

var_0_0.URL = "ui://99hn3059va3gmw2xob"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isSelectController = self:getController("isSelect")
	self.m_selectBg = self:getChild("selectBg")
	self.m_iconfg = self:getChild("iconfg")
	self.m_openTime = self:getChild("openTime")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	page0 = 2,
	page2 = 5,
	page1 = 3
}
var_0_0.IsSelectCtrl = {
	page0 = 2,
	page1 = 3
}

return var_0_0
