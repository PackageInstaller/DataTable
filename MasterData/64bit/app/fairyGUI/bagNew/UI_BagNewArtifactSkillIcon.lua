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
	["0星"] = 0,
	["3星"] = 3,
	["2星"] = 2,
	["1星"] = 1
}
var_0_0.IsRelatedCtrl = {
	是 = 1,
	否 = 0
}
var_0_0.IsLineUpCtrl = {
	非小队模式 = 0,
	小队模式 = 1
}

return var_0_0
