local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnvy8jgibxj"

function var_0_0:__ctor()
	self.m_isShowTitleController = self:getController("isShowTitle")
	self.m_suitNumController = self:getController("suitNum")
	self.m_nameText = self:getChild("nameText")
	self.m_suitCell1 = self:getChild("suitCell1")
	self.m_suitCell2 = self:getChild("suitCell2")
	self.m_suitCell3 = self:getChild("suitCell3")
	self.m_suitCell4 = self:getChild("suitCell4")
end

var_0_0.IsShowTitleCtrl = {
	是 = 1,
	否 = 0
}
var_0_0.SuitNumCtrl = {
	["3条"] = 0,
	["4条"] = 1
}

return var_0_0
