local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wdb4rnf"

function var_0_0:__ctor()
	self.m_fontColorController = self:getController("fontColor")
	self.m_fontSzieController = self:getController("fontSzie")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.FontColorCtrl = {
	黑A1 = 1,
	白A6 = 0
}
var_0_0.FontSzieCtrl = {
	["28"] = 0,
	["36"] = 1
}

return var_0_0
