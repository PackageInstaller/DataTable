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
	rank = 0,
	award = 1
}
var_0_0.HasBgCtrl = {
	has = 1,
	normal = 0
}
var_0_0.HasAllianceCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
