local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9fetm68td"

function var_0_0:__ctor()
	self.m_showTypeController = self:getController("showType")
	self.m_hasBgController = self:getController("hasBg")
	self.m_hasAllianceController = self:getController("hasAlliance")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_allianceIcon = self:getChild("allianceIcon")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_scoreTxt = self:getChild("scoreTxt")
end

var_0_0.ShowTypeCtrl = {
	award = 1,
	rank = 0
}
var_0_0.HasBgCtrl = {
	normal = 0,
	has = 1
}
var_0_0.HasAllianceCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
