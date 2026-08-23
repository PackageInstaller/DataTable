local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9l84a1n"

function var_0_0:__ctor()
	self.m_monster_typeController = self:getController("monster_type")
	self.m_hide_costController = self:getController("hide_cost")
	self.m_posController = self:getController("pos")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_Comp_army = self:getChild("Comp_army")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Txt_level = self:getChild("Txt_level")
	self.m_Loader_view = self:getChild("Loader_view")
	self.m_Txt_team_num = self:getChild("Txt_team_num")
	self.m_Btn_go = self:getChild("Btn_go")
	self.m_Txt_time = self:getChild("Txt_time")
	self.m_Btn_rule = self:getChild("Btn_rule")
	self.m_Txt_army = self:getChild("Txt_army")
	self.m_Group_army = self:getChild("Group_army")
	self.m_Txt_rule = self:getChild("Txt_rule")
	self.m_List_team = self:getChild("List_team")
	self.m_resTitle = self:getChild("resTitle")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.Monster_typeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Hide_costCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.PosCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 10
}

return var_0_0
