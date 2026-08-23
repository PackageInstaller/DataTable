local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wqzu0jc"

function var_0_0:__ctor()
	self.m_fontColorController = self:getController("fontColor")
	self.m_fontSzieController = self:getController("fontSzie")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.FontColorCtrl = {
	白A6 = 0,
	黑A1 = 1
}
var_0_0.FontSzieCtrl = {
	["36"] = 1,
	["28"] = 0
}

return var_0_0
