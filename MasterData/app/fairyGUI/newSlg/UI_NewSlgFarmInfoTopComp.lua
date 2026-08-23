local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9icy368mq"

function var_0_0:__ctor()
	self.m_show_timeController = self:getController("show_time")
	self.m_Comp_bannerInfo = self:getChild("Comp_bannerInfo")
	self.m_Txt_Lv = self:getChild("Txt_Lv")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Txt_belongCity = self:getChild("Txt_belongCity")
	self.m_Comp_belongName = self:getChild("Comp_belongName")
	self.m_Btn_share = self:getChild("Btn_share")
	self.m_Comp_troop = self:getChild("Comp_troop")
	self.m_Txt_time = self:getChild("Txt_time")
	self.m_posTxt = self:getChild("posTxt")
	self.m_Txt_army = self:getChild("Txt_army")
	self.m_Group_army = self:getChild("Group_army")
	self.m_Txt_rule = self:getChild("Txt_rule")
	self.m_armyShow = self:getChild("armyShow")
end

var_0_0.Show_timeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
