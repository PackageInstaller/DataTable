local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9icy368mp"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_Btn_help = self:getChild("Btn_help")
	self.m_List_farmAwards = self:getChild("List_farmAwards")
	self.m_Comp_decrease = self:getChild("Comp_decrease")
	self.m_Btn_atk = self:getChild("Btn_atk")
	self.m_Btn_farm = self:getChild("Btn_farm")
	self.m_Btn_cancel = self:getChild("Btn_cancel")
	self.m_Txt_time = self:getChild("Txt_time")
	self.m_Txt_desc = self:getChild("Txt_desc")
	self.m_Txt_time2 = self:getChild("Txt_time2")
	self.m_curOccuTime = self:getChild("curOccuTime")
	self.m_curRewardNum = self:getChild("curRewardNum")
	self.m_genDescTxt = self:getChild("genDescTxt")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page9 = 9,
	page8 = 8,
	page7 = 7,
	page6 = 6,
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1
}

return var_0_0
