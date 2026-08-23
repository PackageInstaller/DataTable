local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9d9da9p"

function var_0_0:__ctor()
	self.m_is_moveController = self:getController("is_move")
	self.m_is_selfController = self:getController("is_self")
	self.m_is_leaderController = self:getController("is_leader")
	self.m_emptyController = self:getController("empty")
	self.m_Comp_userIcon = self:getChild("Comp_userIcon")
	self.m_Txt_countDown = self:getChild("Txt_countDown")
end

var_0_0.Is_moveCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_selfCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_leaderCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
