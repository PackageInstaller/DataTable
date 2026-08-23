local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lo3z8ea"

function var_0_0:__ctor()
	self.m_isOnLineController = self:getController("isOnLine")
	self.m_helpStateController = self:getController("helpState")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_pointAwardStateController = self:getController("pointAwardState")
	self.m_shareAwardStateController = self:getController("shareAwardState")
	self.m_icon = self:getChild("icon")
	self.m_nameText = self:getChild("nameText")
	self.m_fightText = self:getChild("fightText")
	self.m_workComp = self:getChild("workComp")
	self.m_helpIcon = self:getChild("helpIcon")
	self.m_helpText = self:getChild("helpText")
	self.m_shareAwardBtn = self:getChild("shareAwardBtn")
	self.m_pointAwardBtn = self:getChild("pointAwardBtn")
	self.m_eff = self:getChild("eff")
end

var_0_0.IsOnLineCtrl = {
	online = 0,
	offline = 1
}
var_0_0.HelpStateCtrl = {
	help = 1,
	callHelp = 2,
	none = 0
}
var_0_0.IsEmptyCtrl = {
	empty = 1,
	normal = 0
}
var_0_0.PointAwardStateCtrl = {
	award = 5,
	none = 4
}
var_0_0.ShareAwardStateCtrl = {
	award = 1,
	none = 0
}

return var_0_0
