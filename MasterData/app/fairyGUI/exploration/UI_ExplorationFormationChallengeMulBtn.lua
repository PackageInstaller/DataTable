local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25nbgf7r"

function var_0_0:__ctor()
	self.m_teamIndexController = self:getController("teamIndex")
	self.m_isFinalBtnController = self:getController("isFinalBtn")
	self.m_down = self:getChild("down")
end

var_0_0.TeamIndexCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.IsFinalBtnCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
