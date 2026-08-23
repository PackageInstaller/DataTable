local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jgu4969j1"

function var_0_0:__ctor()
	self.m_preLineTypeController = self:getController("preLineType")
	self.m_preIsActiveController = self:getController("preIsActive")
	self.m_nextLineTypeController = self:getController("nextLineType")
	self.m_nextIsActiveController = self:getController("nextIsActive")
	self.m_line = self:getChild("line")
end

var_0_0.PreLineTypeCtrl = {
	page0 = 3,
	page2 = 1,
	page1 = 0,
	page3 = 2
}
var_0_0.PreIsActiveCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.NextLineTypeCtrl = {
	page0 = 5,
	page2 = 1,
	page1 = 0,
	page3 = 4
}
var_0_0.NextIsActiveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
