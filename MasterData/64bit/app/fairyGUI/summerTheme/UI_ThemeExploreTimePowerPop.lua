local var_0_0 = {}

var_0_0.URL = "ui://99hn3059lz1jkk33v"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_itemList = self:getChild("itemList")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_picBgLoader = self:getChild("picBgLoader")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_descComp = self:getChild("descComp")
	self.m_content = self:getChild("content")
end

var_0_0.EmptyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
