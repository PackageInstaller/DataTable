local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcxga16v"

function var_0_0:__ctor()
	self.m_boxNumController = self:getController("boxNum")
	self.m_boxIcon1 = self:getChild("boxIcon1")
	self.m_boxIcon2 = self:getChild("boxIcon2")
	self.m_boxIcon3 = self:getChild("boxIcon3")
	self.m_boxIcon4 = self:getChild("boxIcon4")
	self.m_boxIcon5 = self:getChild("boxIcon5")
	self.m_moreIcon = self:getChild("moreIcon")
end

var_0_0.BoxNumCtrl = {
	page2 = 2,
	page5 = 5,
	page1 = 1,
	page4 = 4,
	page0 = 8,
	page6 = 6,
	page3 = 3,
	page7 = 7
}

return var_0_0
