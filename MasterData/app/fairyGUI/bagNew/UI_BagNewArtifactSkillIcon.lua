local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qritsp66"

function var_0_0:__ctor()
	self.m_skillStateController = self:getController("skillState")
	self.m_isRelatedController = self:getController("isRelated")
	self.m_isLineUpController = self:getController("isLineUp")
	self.m_iconBg = self:getChild("iconBg")
	self.m_levelBg = self:getChild("levelBg")
	self.m_levelText = self:getChild("levelText")
end

var_0_0.SkillStateCtrl = {
	["3星"] = 3,
	["0星"] = 0,
	["1星"] = 1,
	["2星"] = 2
}
var_0_0.IsRelatedCtrl = {
	是 = 1,
	否 = 0
}
var_0_0.IsLineUpCtrl = {
	小队模式 = 1,
	非小队模式 = 0
}

return var_0_0
