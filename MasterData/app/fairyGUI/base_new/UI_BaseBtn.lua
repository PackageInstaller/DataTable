local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepmdfj14"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_sub_titleController = self:getController("sub_title")
	self.m_loader = self:getChild("loader")
	self.m_mark = self:getChild("mark")
	self.m_subtitle = self:getChild("subtitle")
end

var_0_0.StyleCtrl = {
	page2 = 2,
	page8 = 8,
	page1 = 1,
	page9 = 9,
	page0 = 0,
	page10 = 10,
	page7 = 7,
	page11 = 11,
	page6 = 6,
	page5 = 5,
	page13 = 13,
	page4 = 4,
	page12 = 12,
	page3 = 3
}
var_0_0.Sub_titleCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
