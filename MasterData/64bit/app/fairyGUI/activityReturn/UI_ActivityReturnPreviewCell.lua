local var_0_0 = {}

var_0_0.URL = "ui://0xhekt5ief2w1i"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_title = self:getChild("title")
	self.m_itemNameTxt = self:getChild("itemNameTxt")
	self.m_iconList = self:getChild("iconList")
end

return var_0_0
