local var_0_0 = {}

var_0_0.URL = "ui://nz3msl46jvs2gibwz"

function var_0_0:__ctor()
	self.m_showUpTipController = self:getController("showUpTip")
	self.m_qualityController = self:getController("quality")
	self.m_icon = self:getChild("icon")
	self.m_upBg = self:getChild("upBg")
	self.m_upText = self:getChild("upText")
	self.m_numText = self:getChild("numText")
end

var_0_0.ShowUpTipCtrl = {
	upTIp = 1,
	normal = 0
}
var_0_0.QualityCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
