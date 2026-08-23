local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wrqeoel"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_isPetLinkController = self:getController("isPetLink")
	self.m_knightComp = self:getChild("knightComp")
end

var_0_0.QualityCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.IsPetLinkCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
