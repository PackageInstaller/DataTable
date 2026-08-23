local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9l84a19"

function var_0_0:__ctor()
	self.m_is_moveController = self:getController("is_move")
	self.m_showSpeedController = self:getController("showSpeed")
	self.m_Comp_army_type = self:getChild("Comp_army_type")
	self.m_Txt_pro = self:getChild("Txt_pro")
	self.m_Comp_pro = self:getChild("Comp_pro")
	self.m_Txt_power = self:getChild("Txt_power")
	self.m_Txt_desc = self:getChild("Txt_desc")
	self.m_Comp_move_pro = self:getChild("Comp_move_pro")
	self.m_Txt_move_pro = self:getChild("Txt_move_pro")
	self.m_Btn_check = self:getChild("Btn_check")
	self.m_Btn_exe = self:getChild("Btn_exe")
	self.m_Btn_icon1 = self:getChild("Btn_icon1")
	self.m_Btn_icon2 = self:getChild("Btn_icon2")
	self.m_Btn_icon3 = self:getChild("Btn_icon3")
	self.m_Btn_icon4 = self:getChild("Btn_icon4")
	self.m_Btn_icon5 = self:getChild("Btn_icon5")
	self.m_Btn_icon6 = self:getChild("Btn_icon6")
	self.m_costLoader = self:getChild("costLoader")
	self.m_descTxt = self:getChild("descTxt")
	self.m_addSpeedBtn = self:getChild("addSpeedBtn")
end

var_0_0.Is_moveCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}
var_0_0.ShowSpeedCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
