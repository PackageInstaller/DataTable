local var_0_0 = {}

var_0_0.URL = "ui://q8j59504qq6b6r"

function var_0_0:__ctor()
	self.m_lineUpStateController = self:getController("lineUpState")
	self.m_showLevelController = self:getController("showLevel")
	self.m_iconComp = self:getChild("iconComp")
	self.m_levelText = self:getChild("levelText")
end

var_0_0.LineUpStateCtrl = {
	empty = 1,
	inBattle = 2,
	lock = 0
}
var_0_0.ShowLevelCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
