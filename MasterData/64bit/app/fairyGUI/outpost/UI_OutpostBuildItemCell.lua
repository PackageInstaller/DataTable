local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5116r747"

function var_0_0:__ctor()
	self.m_isSelectController = self:getController("isSelect")
	self.m_showNameController = self:getController("showName")
	self.m_itemNameTxt = self:getChild("itemNameTxt")
	self.m_qualityLoader = self:getChild("qualityLoader")
end

return var_0_0
