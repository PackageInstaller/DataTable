local var_0_0 = {}

var_0_0.URL = "ui://aeavo6obl1fx1x"

function var_0_0:__ctor()
	self.m_preLineTypeController = self:getController("preLineType")
	self.m_preIsActiveController = self:getController("preIsActive")
	self.m_nextLineTypeController = self:getController("nextLineType")
	self.m_nextIsActiveController = self:getController("nextIsActive")
	self.m_line = self:getChild("line")
end

var_0_0.PreLineTypeCtrl = {
	page1 = 0,
	page0 = 3,
	page3 = 2,
	page2 = 1
}
var_0_0.PreIsActiveCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.NextLineTypeCtrl = {
	page1 = 0,
	page0 = 5,
	page3 = 4,
	page2 = 1
}
var_0_0.NextIsActiveCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
