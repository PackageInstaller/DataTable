local var_0_0 = {}

var_0_0.URL = "ui://2r646mayce3b14"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_selectNum = self:getChild("selectNum")
	self.m_titleShowComp = self:getChild("titleShowComp")
	self.m_oneKeyDropBtn = self:getChild("oneKeyDropBtn")
	self.m_titleList = self:getChild("titleList")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_content = self:getChild("content")
end

var_0_0.IsEmptyCtrl = {
	否 = 0,
	是 = 1
}

return var_0_0
