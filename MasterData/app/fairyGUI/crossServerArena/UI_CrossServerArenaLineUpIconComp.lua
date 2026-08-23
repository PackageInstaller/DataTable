local var_0_0 = {}

var_0_0.URL = "ui://n47h6oaghuis1t"

function var_0_0:__ctor()
	self.m_lineUpStateController = self:getController("lineUpState")
	self.m_isBuffController = self:getController("isBuff")
	self.m_groupController = self:getController("group")
	self.m_iconComp = self:getChild("iconComp")
	self.m_buff = self:getChild("buff")
end

var_0_0.LineUpStateCtrl = {
	empty = 1,
	inBattle = 2,
	lock = 0
}
var_0_0.IsBuffCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.GroupCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}

return var_0_0
