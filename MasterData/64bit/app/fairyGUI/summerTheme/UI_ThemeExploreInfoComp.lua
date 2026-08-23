local var_0_0 = {}

var_0_0.URL = "ui://99hn3059lz1jkk33t"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_descTxt = self:getChild("descTxt")
	self.m_iconLoader1 = self:getChild("iconLoader1")
	self.m_iconLoader2 = self:getChild("iconLoader2")
	self.m_progress1 = self:getChild("progress1")
	self.m_progress2 = self:getChild("progress2")
	self.m_progressTxt1 = self:getChild("progressTxt1")
	self.m_progressTxt2 = self:getChild("progressTxt2")
	self.m_enterBtn = self:getChild("enterBtn")
	self.m_resetBtn = self:getChild("resetBtn")
end

var_0_0.TypeCtrl = {
	page3 = 6,
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page4 = 16
}

return var_0_0
