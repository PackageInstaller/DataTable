local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9qhbr87"

function var_0_0:__ctor()
	self.m_is_emptyController = self:getController("is_empty")
	self.m_canGatherController = self:getController("canGather")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_Comp_bossView = self:getChild("Comp_bossView")
	self.m_Comp_defence = self:getChild("Comp_defence")
	self.m_Btn_join = self:getChild("Btn_join")
	self.m_Btn_go = self:getChild("Btn_go")
	self.m_List_team = self:getChild("List_team")
	self.m_Btn_refresh = self:getChild("Btn_refresh")
	self.m_Txt_time = self:getChild("Txt_time")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.Is_emptyCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.CanGatherCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
