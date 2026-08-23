local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o9j768p4"

function var_0_0:__ctor()
	self.m_attrNumController = self:getController("attrNum")
	self.m_showDotController = self:getController("showDot")
	self.m_title = self:getChild("title")
	self.m_firstAttValue = self:getChild("firstAttValue")
	self.m_arrow = self:getChild("arrow")
	self.m_secondAttrValue = self:getChild("secondAttrValue")
end

var_0_0.AttrNumCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.ShowDotCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
