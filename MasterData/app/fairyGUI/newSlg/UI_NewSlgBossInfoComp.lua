local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9kz3v85"

function var_0_0:__ctor()
	self.m_colorController = self:getController("color")
	self.m_Comp_bannerInfo = self:getChild("Comp_bannerInfo")
	self.m_Btn_checkDefenderInfo = self:getChild("Btn_checkDefenderInfo")
	self.m_List_award = self:getChild("List_award")
	self.m_Btn_gather = self:getChild("Btn_gather")
	self.m_Txt_desc = self:getChild("Txt_desc")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Comp_armyIcon = self:getChild("Comp_armyIcon")
	self.m_Txt_authority = self:getChild("Txt_authority")
	self.m_Txt_level = self:getChild("Txt_level")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.ColorCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
