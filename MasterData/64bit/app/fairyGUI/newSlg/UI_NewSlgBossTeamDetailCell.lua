local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9f8iz8a"

function var_0_0:__ctor()
	self.m_is_selfController = self:getController("is_self")
	self.m_is_leaderController = self:getController("is_leader")
	self.m_move_timeController = self:getController("move_time")
	self.m_is_emptyController = self:getController("is_empty")
	self.m_Comp_armyIcon = self:getChild("Comp_armyIcon")
	self.m_Comp_name = self:getChild("Comp_name")
	self.m_Txt_armyLv = self:getChild("Txt_armyLv")
	self.m_Comp_desc = self:getChild("Comp_desc")
	self.m_Comp_userIcon = self:getChild("Comp_userIcon")
	self.m_Txt_moveTime = self:getChild("Txt_moveTime")
	self.m_Btn_1 = self:getChild("Btn_1")
	self.m_Btn_2 = self:getChild("Btn_2")
	self.m_Btn_3 = self:getChild("Btn_3")
end

var_0_0.Is_selfCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.Is_leaderCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.Move_timeCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.Is_emptyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
