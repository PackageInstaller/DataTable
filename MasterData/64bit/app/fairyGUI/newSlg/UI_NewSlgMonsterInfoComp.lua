local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9k43j3l"

function var_0_0:__ctor()
	self.m_c1Controller = self:getController("c1")
	self.m_Comp_bannerInfo = self:getChild("Comp_bannerInfo")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Comp_armyIcon = self:getChild("Comp_armyIcon")
	self.m_Txt_authority = self:getChild("Txt_authority")
	self.m_Txt_level = self:getChild("Txt_level")
	self.m_Comp_pro = self:getChild("Comp_pro")
	self.m_Txt_power = self:getChild("Txt_power")
	self.m_List_icon = self:getChild("List_icon")
	self.m_Txt_tips = self:getChild("Txt_tips")
	self.m_Txt_times = self:getChild("Txt_times")
	self.m_Btn_fight = self:getChild("Btn_fight")
	self.m_loaderBtn = self:getChild("loaderBtn")
	self.m_btnSearch = self:getChild("btnSearch")
	self.m_Comp_addition = self:getChild("Comp_addition")
	self.m_additionComp = self:getChild("additionComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.C1Ctrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
