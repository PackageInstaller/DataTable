local var_0_0 = {}

var_0_0.URL = "ui://99hn3059lz1jkk33u"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_itemLoader = self:getChild("itemLoader")
	self.m_progressTxt = self:getChild("progressTxt")
	self.m_progress = self:getChild("progress")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
