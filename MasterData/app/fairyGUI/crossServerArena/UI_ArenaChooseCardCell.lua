local var_0_0 = {}

var_0_0.URL = "ui://n47h6oagqtk92b"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_seasonStatusController = self:getController("seasonStatus")
	self.m_seasonTime = self:getChild("seasonTime")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_noRankTxt = self:getChild("noRankTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.SeasonStatusCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
