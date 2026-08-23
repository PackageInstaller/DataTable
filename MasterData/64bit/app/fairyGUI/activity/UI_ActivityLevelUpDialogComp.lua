local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wk9ciy"

function var_0_0:__ctor()
	self.m_showLinesController = self:getController("showLines")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_linesText = self:getChild("linesText")
end

var_0_0.ShowLinesCtrl = {
	不显示 = 0,
	显示 = 1
}

return var_0_0
